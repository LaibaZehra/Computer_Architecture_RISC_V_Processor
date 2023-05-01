`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2023 05:55:51 PM
// Design Name: 
// Module Name: IF_ID
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


module IF_ID ( 

    input clk,
    
    input [31:0]Instruction, 
    
    input [63:0]PCOut, 
    
    output reg[31:0]Ins, 
    
    output reg[63:0]PC 
    
); 

always @(negedge clk)
begin
    Ins = Instruction; 
    
    PC = PCOut; 
end

endmodule