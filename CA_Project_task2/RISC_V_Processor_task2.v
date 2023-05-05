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
wire [31:0]IF_ID_ins;
wire [63:0]IF_IC_PC_Out;
wire ID_EX_Branch,ID_EX_MemWrite,ID_EX_MemRead,ID_EX_MemtoReg,ID_EX_ALUSrc,ID_EX_RegWrite;
wire [1:0]ID_EX_ALUOp;
wire [63:0]ID_EX_PC_Out;
wire [63:0]ID_EX_ReadData1;
wire [63:0]ID_EX_ReadData2;
wire [63:0]ID_EX_imm_data;
wire [3:0]ID_EX_Func;
wire [4:0]ID_EX_rd;
wire [2:0]ID_EX_func3;
wire [63:0]EX_MEM_branch_adder;
wire [63:0]EX_MEM_Result;
wire EX_MEM_ZERO;
wire [63:0]EX_MEM_ReadData2;
wire [4:0]EX_MEM_rd;
wire EX_MEM_RegWrite,EX_MEM_MemtoReg,EX_MEM_Branch,EX_MEM_MemRead,EX_MEM_MemWrite;
wire MEM_WB_RegWrite, MEM_WB_MemtoReg;
wire [63:0]MEM_WB_Result;
wire [63:0]MEM_WB_read_mem_data;
wire [4:0]MEM_WB_rd;

Mux m1 (normal_adder, branch_adder, EX_MEM_Branch&EX_MEM_ZERO, PC_In); //PC src, deciding which pc_in to use
Program_Counter p1 (clk,reset,PC_In, PC_Out); //Program counter taking in PC_in from the adders and giving a pc_out
Adder a1 (PC_Out, 64'b100, normal_adder); //adder adding 4 to take to the next instruction
Instruction_Memory i1 (PC_Out,instruction); //reading the instruction


ImmGen im1(IF_ID_ins,imm_data);  //immediate generation of the immediate value

InsParser in1(IF_ID_ins,opcode,rd,funct3,rs1,rs2,funct7); //decoding the instruction
IF_ID pr1(clk,instruction,PC_Out,IF_ID_ins,IF_ID_PC_Out);
Control_Unit c1(opcode,Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp);//control unit giving the control signals
registerFile r1(WriteData,rs1,rs2,rd,RegWrite, clk, reset,ReadData1,ReadData2);  //working in the register block

ID_EX pr2(clk,Branch,MemWrite,MemRead,MemtoReg,ALUSrc,RegWrite,ALUOp,funct3,IF_ID_PC_Out,ReadData1,ReadData2,imm_data,
Func,rd,ID_EX_Branch,ID_EX_MemWrite,ID_EX_MemRead,ID_EX_MemtoReg,ID_EX_ALUSrc,ID_EX_RegWrite,ID_EX_ALUOp,ID_EX_func3,ID_EX_PC_Out,ID_EX_ReadData1,ID_EX_ReadData2,ID_EX_imm_data,ID_EX_Func,ID_EX_rd);

assign imm=ID_EX_imm_data<<1;
Mux m2 (ID_EX_ReadData2, ID_EX_imm_data, ID_EX_ALUSrc, ALU_input2); //ALU src, deciding what goes to the alu
ALU_Control alu_c1 (ID_EX_ALUOp, ID_EX_Func,operation); //deciding the operation for alu
ALU_64_bit alu1 (ID_EX_ReadData1, ALU_input2, operation,ID_EX_func3, Result, ZERO); //alu performing the said operation
Adder a2 (ID_EX_PC_Out, imm, branch_adder); //adder adding in the branch value

EX_MEM pr3(clk,branch_adder,Result,ZERO,ID_EX_ReadData2,ID_EX_rd,ID_EX_RegWrite,ID_EX_MemtoReg,ID_EX_Branch,ID_EX_MemRead,ID_EX_MemWrite,
EX_MEM_branch_adder,EX_MEM_Result,EX_MEM_ZERO,EX_MEM_ReadData2,EX_MEM_rd,EX_MEM_RegWrite,EX_MEM_MemtoReg,EX_MEM_Branch,EX_MEM_MemRead,EX_MEM_MemWrite);


Data_Memory d1(EX_MEM_Result,EX_MEM_ReadData2, clk, EX_MEM_MemWrite,EX_MEM_MemRead,read_mem_data); //working with the data memeory
MEM_WB pr4(clk,EX_MEM_RegWrite, EX_MEM_MemtoReg,EX_MEM_Result,read_mem_data,EX_MEM_rd,MEM_WB_RegWrite, MEM_WB_MemtoReg,MEM_WB_Result,MEM_WB_read_mem_data,MEM_WB_rd);
Mux m3 (MEM_WB_Result, MEM_WB_read_mem_data, MEM_WB_MemtoReg, WriteData); //deciding which data to write back
endmodule







   
//endmodule