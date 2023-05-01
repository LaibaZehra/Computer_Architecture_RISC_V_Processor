`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2023 07:13:38 PM
// Design Name: 
// Module Name: Control_Unit
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


module ALU_Control
(
	input [1:0] ALUOp, 
	input [3:0] Funct,
	output reg [3:0] Operation
);

	always @ (ALUOp or Funct)
	begin
		case(ALUOp)
			2'b00: 
			begin
			case(Funct)
		      4'b0001: Operation= 4'b1000;
		      default: Operation = 4'b0010;
		endcase
		end
			2'b01: Operation = 4'b0110;
			2'b10: 
			begin 
			case(Funct)
				4'b0000: Operation = 4'b0010;
				4'b1000: Operation = 4'b0110;
				4'b0111: Operation = 4'b0000;
				4'b0110: Operation = 4'b0001;
			endcase
			end
		endcase
	end
	
endmodule

module Control_Unit
(
	input [6:0] Opcode,
	output reg Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, 
	output reg [1:0] ALUOp
);

	always @ (Opcode)
	begin
		case (Opcode)
			7'b0110011: //R type
				begin
					Branch = 0;
					MemRead = 0;
					MemtoReg = 0;
					MemWrite = 0;
					ALUSrc = 0;
					RegWrite = 1;
					ALUOp = 2'b10;
				end
			7'b0000011: //ld
				begin
					Branch = 0;
					MemRead = 1;
					MemtoReg = 1;
					MemWrite = 0;
					ALUSrc = 1;
					RegWrite = 1;
					ALUOp = 2'b00;
				end
			7'b0010011: //addi
				begin
					Branch = 0;
					MemRead = 0;
					MemtoReg = 0;
					MemWrite = 0;
					ALUSrc = 1;
					RegWrite = 1;
					ALUOp = 2'b00;
				end
			7'b0100011: // I type SD
				begin
					Branch = 0;
					MemRead = 0;
					MemtoReg = 1'bx;
					MemWrite = 1;
					ALUSrc = 1;
					RegWrite = 0;
					ALUOp = 2'b00;
				end
			7'b1100011:  //SB
				begin
					Branch = 1;
					MemRead = 0;
					MemtoReg = 1'bx;
					MemWrite = 0;
					ALUSrc = 0;
					RegWrite = 0;
					ALUOp = 2'b01;
				end
		endcase
	end

endmodule 
