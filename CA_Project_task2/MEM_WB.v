`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2023 05:57:25 PM
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB( 
input clk,

input regwrite, memtoreg, 

input [63:0]alures, 

input [63:0]readmem, 

input [4:0]RD, 

output reg regwriteout, memtoregout, 

output reg [63:0]aluresout, 

output reg[63:0]readmemout, 

output reg[4:0]RDout 

); 
always @(negedge clk)
begin
    regwriteout = regwrite; 

    memtoregout = memtoreg; 

    aluresout = alures; 

    readmemout = readmem; 

    RDout = RD; 
end

endmodule
