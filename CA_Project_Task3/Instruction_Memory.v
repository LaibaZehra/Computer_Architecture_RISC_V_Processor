`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2023 12:20:03 AM
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory
(
	input [63:0] Inst_Address,
	output reg [31:0] Instruction
);
	reg [7:0] inst_mem [95:0];
	
	initial
	begin

		//addi x6,x0, 1 
        inst_mem[0]=8'b00010011;
		inst_mem[1]=8'b00000011;
		inst_mem[2]=8'b00010000;
		inst_mem[3]=8'b00000000;
		//addi x7,x0, 4
		inst_mem[4]=8'b10010011;
		inst_mem[5]=8'b00000011;
		inst_mem[6]=8'b01000000;
		inst_mem[7]=8'b00000000;
		//addi x8,x0, 5 
		inst_mem[8]=8'b00010011;
		inst_mem[9]=8'b00000100;
		inst_mem[10]=8'b01010000;
		inst_mem[11]=8'b00000000;
		//addi x9,x0, 3 
		inst_mem[12]=8'b10010011;
		inst_mem[13]=8'b00000100;
		inst_mem[14]=8'b00110000;
		inst_mem[15]=8'b00000000;
		//addi x10, x0,8
		inst_mem[16]=8'b00010011;
		inst_mem[17]=8'b00000101;
		inst_mem[18]=8'b10000000;
		inst_mem[19]=8'b00000000;
		
		//addi x20,x0, 4 
		inst_mem[20]=8'b00010011;
		inst_mem[21]=8'b00001010;
		inst_mem[22]=8'b01010000;
		inst_mem[23]=8'b00000000;
		//Addi x19,x0,4 
		inst_mem[24]=8'b10010011;
		inst_mem[25]=8'b00001001;
		inst_mem[26]=8'b01010000;
		inst_mem[27]=8'b00000000;
		//addi x12,x0, 0 
		inst_mem[28]=8'b00010011;
		inst_mem[29]=8'b00000110;
		inst_mem[30]=8'b00000000;
		inst_mem[31]=8'b00000000;
		//blt x20, x12, exit1
		inst_mem[32]=8'b01100011;
		inst_mem[33]=8'b01000000;
		inst_mem[34]=8'b11001010;
		inst_mem[35]=8'b00000100;
		//addi x13,x0, 0
		inst_mem[36]=8'b10010011;
		inst_mem[37]=8'b00000110;
		inst_mem[38]=8'b00000000;
		inst_mem[39]=8'b00000000;
		//slli x15, x13, 3 
		inst_mem[40]=8'b10010011;
		inst_mem[41]=8'b10010111;
		inst_mem[42]=8'b00110110;
		inst_mem[43]=8'b00000000;
		//add x15, x5, x15
		inst_mem[44]=8'b10110011;
		inst_mem[45]=8'b10000111;
		inst_mem[46]=8'b11110010;
		inst_mem[47]=8'b00000000;
		//ld x16, 0(x15) 
		inst_mem[48]=8'b00000011;
		inst_mem[49]=8'b10101000;
		inst_mem[50]=8'b00000111;
		inst_mem[51]=8'b00000000;
		//addi x18, x15, 8    //correct
		inst_mem[52]=8'b00010011;
		inst_mem[53]=8'b10001001;
		inst_mem[54]=8'b10000111;
		inst_mem[55]=8'b00000000;
		//ld x17, 0(x18)      //datamemory[8] = 5
		inst_mem[56]=8'b10000011;
		inst_mem[57]=8'b00101000;
		inst_mem[58]=8'b00001001;
		inst_mem[59]=8'b00000000;
		//blt x16, x17, exit2 
		inst_mem[60]=8'b01100011;
		inst_mem[61]=8'b01001000;
		inst_mem[62]=8'b00011000;
		inst_mem[63]=8'b00000001;
		//add x11, x0, x16
		inst_mem[64]=8'b10110011;
		inst_mem[65]=8'b00000101;
		inst_mem[66]=8'b00000000;
		inst_mem[67]=8'b00000001;
		// sd x17, 0(x15)
		inst_mem[68]=8'b00100011;
		inst_mem[69]=8'b10100000;
		inst_mem[70]=8'b00010111;
		inst_mem[71]=8'b00000001;
		//sd x11, 0(x18)
		inst_mem[72]=8'b00100011;
		inst_mem[73]=8'b00100000;
		inst_mem[74]=8'b10111001;
		inst_mem[75]=8'b00000000;
		//addi x13, x13, 1 
		inst_mem[76]=8'b10010011;
		inst_mem[77]=8'b10000110;
		inst_mem[78]=8'b00010110;
		inst_mem[79]=8'b00000000;
		//sub x19, x19, x12 
		inst_mem[80]=8'b10110011;
		inst_mem[81]=8'b10001001;
		inst_mem[82]=8'b11001001;
		inst_mem[83]=8'b01000000;
		// blt x13, x19, loop2 
		inst_mem[84]=8'b11100011;
		inst_mem[85]=8'b11001010;
		inst_mem[86]=8'b00110110;
		inst_mem[87]=8'b11111101;
		//addi x12, x12, 1 
		inst_mem[88]=8'b00010011;
		inst_mem[89]=8'b00000110;
		inst_mem[90]=8'b00010110;
		inst_mem[91]=8'b00000000;
		//beq x0, x0, loop1
		inst_mem[92]=8'b11100011;
		inst_mem[93]=8'b00000010;
		inst_mem[94]=8'b00000000;
		inst_mem[95]=8'b11111100;
		 
		
		
	end
	
	
	always @(Inst_Address)
	begin
		Instruction={inst_mem[Inst_Address+3],inst_mem[Inst_Address+2],inst_mem[Inst_Address+1],inst_mem[Inst_Address]};
	end
endmodule
