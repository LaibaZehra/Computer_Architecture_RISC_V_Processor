`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2023 07:07:37 PM
// Design Name: 
// Module Name: ALU_64_bit
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


module Mux
(
	input [63:0] a,
	input [63:0] b,
	input  sel,
	
	output reg [63:0]data_out
);



always @ (a, b, sel)
begin
	if (!sel)
		data_out = a;
	else
		data_out = b;
end

endmodule 

module ALU_64_bit
(
	input [63:0]a, b,
	input [3:0] ALUOp,
	input [2:0]funct3,
	output reg [63:0] Result,
	output  reg ZERO
);

localparam [3:0]
AND = 4'b0000,
OR	= 4'b0001,
ADD	= 4'b0010,
Sub	= 4'b0110,
NOR = 4'b1100,
SLLI = 4'b1000;

always @ (ALUOp, a, b)
begin
	case (ALUOp)
		AND: Result = a & b;
		OR:	 Result = a | b;
		ADD: Result = a + b;
		Sub: Result = a-b;
		NOR: Result = ~(a | b);
		SLLI: Result = a << b;
		
		default: Result = 0;
	endcase
end
always @(*)
    begin
    case (funct3)
    3'b000: ZERO=(Result == 64'b0 ? 1 : 0);
    3'b100: ZERO=(Result[63]== 1 ? 1 : 0);
    3'b101: ZERO =(Result[63] == 0 ? 1 : 0);
    default : ZERO =0;
    endcase
    end

endmodule 

module Adder
(
	input [63:0] a,b,
	output reg [63:0] out
);

	
	
	always @ (a or b)
		out=a+b;

endmodule
