`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2023 12:16:03 AM
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory
(
	input [63:0] Mem_Addr,
	input [63:0] Write_Data,
	input clk, MemWrite, MemRead,
	output reg [63:0] Read_Data
);

	reg [7:0] DataMemory [63:0];

	initial
	begin
		DataMemory[0] = 8'd2;
		DataMemory[1] = 8'd0;
		DataMemory[2] = 8'd0;
		DataMemory[3] = 8'd0;
		DataMemory[4] = 8'd0;
		DataMemory[5] = 8'd0;
		DataMemory[6] = 8'd0;
		DataMemory[7] = 8'd0;
		DataMemory[8] = 8'd5;
		DataMemory[9] = 8'd0;
		DataMemory[10] = 8'd0;
		DataMemory[11] = 8'd0;
		DataMemory[12] = 8'd0;
		DataMemory[13] = 8'd0;
		DataMemory[14] = 8'd0;
		DataMemory[15] = 8'd0;
		DataMemory[16] = 8'd6;
		DataMemory[17] = 8'd0;
		DataMemory[18] = 8'd0;
		DataMemory[19] = 8'd0;
		DataMemory[20] = 8'd0;
		DataMemory[21] = 8'd0;
		DataMemory[22] = 8'd0;
		DataMemory[23] = 8'd0;
		DataMemory[24] = 8'd3;
		DataMemory[25] = 8'd0;
		DataMemory[26] = 8'd0;
		DataMemory[27] = 8'd0;
		DataMemory[28] = 8'd0;
		DataMemory[29] = 8'd0;
		DataMemory[30] = 8'd0;
		DataMemory[31] = 8'd0;
		DataMemory[32] = 8'd4;
		DataMemory[33] = 8'd0;
		DataMemory[34] = 8'd0;
		DataMemory[35] = 8'd0;
		DataMemory[36] = 8'd0;
		DataMemory[37] = 8'd0;
		DataMemory[38] = 8'd0;
		DataMemory[39] = 8'd0;
		DataMemory[40] = 8'd8;
		DataMemory[41] = 8'd0;
		DataMemory[42] = 8'd0;
		DataMemory[43] = 8'd0;
		DataMemory[44] = 8'd0 ;
		DataMemory[45] = 8'd0;
		DataMemory[46] = 8'd0;
		DataMemory[47] = 8'd0;
		DataMemory[48] = 8'd0;
		DataMemory[49] = 8'd0;
		DataMemory[50] = 8'd0;
		DataMemory[51] = 8'd0;
		DataMemory[52] = 8'd0;
		DataMemory[53] = 8'd0;
		DataMemory[54] = 8'd0;
		DataMemory[55] = 8'd0;
		DataMemory[56] = 8'd0;
		DataMemory[57] = 8'd0;
		DataMemory[58] = 8'd0;
		DataMemory[59] = 8'd0;
		DataMemory[60] = 8'd0;
		DataMemory[61] = 8'd0;
		DataMemory[62] = 8'd0;
		DataMemory[63] = 8'd0;
	end
	
	always @ (*)
	begin
		if (MemRead)
			Read_Data = {DataMemory[Mem_Addr+7],DataMemory[Mem_Addr+6],DataMemory[Mem_Addr+5],DataMemory[Mem_Addr+4],DataMemory[Mem_Addr+3],DataMemory[Mem_Addr+2],DataMemory[Mem_Addr+1],DataMemory[Mem_Addr]};
	end
	
	always @ (negedge clk) 
	begin
		if (MemWrite)
		begin
			DataMemory[Mem_Addr] = Write_Data[7:0];
			DataMemory[Mem_Addr+1] = Write_Data[15:8];
			DataMemory[Mem_Addr+2] = Write_Data[23:16];
			DataMemory[Mem_Addr+3] = Write_Data[31:24];
			DataMemory[Mem_Addr+4] = Write_Data[39:32];
			DataMemory[Mem_Addr+5] = Write_Data[47:40];
			DataMemory[Mem_Addr+6] = Write_Data[55:48];
			DataMemory[Mem_Addr+7] = Write_Data[63:56];
		end
	end
	
endmodule