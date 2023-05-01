`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2023 03:55:56 PM
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module RISC_V_Processor(
   input clk, reset,
   output wire [63:0] PC_In,  //prev inst add
   output wire [63:0] PC_Out,  //new ins add
   output wire [31:0] instruction,  //ins
   output wire [6:0] opcode, //opcode
   output wire [4:0] rs1,
   output wire [4:0] rs2,
   output wire [4:0] rd,
   output wire [63:0] WriteData, //in rd
   output wire [63:0] ReadData1,
   output wire [63:0] ReadData2, //writedata (mem)
   output wire Branch, MemWrite, MemRead, MemtoReg,
   output wire [1:0] ALUOp,
   output wire ALUSrc, RegWrite,
   output wire [63:0] Result, //Mem_Add
   output wire [63:0] read_mem_data,
   output  wire [63:0]imm_data,
   output wire [3:0] operation,
   output wire ZERO,
   output wire [63:0] ALU_input2,
   output wire[63:0] branch_adder,
   output wire[63:0] imm
);
wire [63:0] normal_adder;
wire [2:0] funct3;
wire [6:0] funct7;

wire [3:0] Func;
assign Func[3] = instruction[30];
assign Func[2:0] = instruction[14:12];

Program_Counter p1 (clk,reset,PC_In, PC_Out); //Program counter taking in PC_in from the adders and giving a pc_out
Adder a1 (PC_Out, 64'b100, normal_adder); //adder adding 4 to take to the next instruction
ImmGen im1(instruction,imm_data);  //immediate generation of the immediate value
assign imm=imm_data<<1;
Adder a2 (PC_Out, imm, branch_adder); //adder adding in the branch value
Control_Unit c1 (opcode,Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp); //control unit giving the control signals
Mux m1 (normal_adder, branch_adder, Branch&ZERO, PC_In); //PC src, deciding which pc_in to use
Instruction_Memory i1 (PC_Out,instruction); //reading the instruction
InsParser in1(instruction,opcode,rd,funct3,rs1,rs2,funct7); //decoding the instruction
registerFile r1 (WriteData,rs1,rs2,rd,RegWrite, clk, reset,ReadData1,ReadData2);  //working in the register block
Mux m2 (ReadData2, imm_data, ALUSrc, ALU_input2); //ALU src, deciding what goes to the alu
ALU_Control alu_c1 (ALUOp, Func,operation); //deciding the operation for alu
ALU_64_bit alu1 (ReadData1, ALU_input2, operation,funct3, Result, ZERO); //alu performing the said operation
Data_Memory d1(Result,ReadData2, clk, MemWrite, MemRead,read_mem_data); //working with the data memeory
Mux m3 (Result, read_mem_data, MemtoReg, WriteData); //deciding which data to write back
endmodule


