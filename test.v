`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2023 01:17:46 PM
// Design Name: 
// Module Name: test
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


module test_processor();
   reg clk;
   reg reset;
   wire [63:0] PC_In;  //prev inst add
   wire [63:0] PC_Out;  //new ins add
   wire [31:0] instruction;  //ins
   wire [6:0] opcode; //opcode
   wire [4:0] rs1;
   wire [4:0] rs2;
   wire [4:0] rd;
   wire [63:0] WriteData; //in rd
   wire [63:0] ReadData1;
   wire [63:0] ReadData2; //writedata (mem)
   wire Branch, MemWrite, MemRead, MemtoReg;
   wire [1:0] ALUOp;
   wire ALUSrc, RegWrite;
   wire [63:0] Result; //Mem_Add
   wire [63:0] read_mem_data;
   wire [63:0] imm;
   wire [3:0] operation;
   wire Zero;
   wire [63:0] ALU_input2;
   wire [63:0] branch;
   wire [63:0] immi;

RISC_V_Processor r1(clk, reset, PC_In, PC_Out, instruction, opcode, rs1, rs2, rd, WriteData, ReadData1,ReadData2, Branch, MemWrite, MemRead, MemtoReg, ALUOp, ALUSrc, RegWrite, Result,  read_mem_data,imm,operation,Zero, ALU_input2,branch,immi);

initial begin

clk = 1'b0; 
reset = 1'b0;
// #20 reset = 1'b1;
// #20 reset = 1'b0;
// #100 reset = 1'b1;
// #20 reset = 1'b0;
end
 always
 #10 clk = ~clk;
endmodule


