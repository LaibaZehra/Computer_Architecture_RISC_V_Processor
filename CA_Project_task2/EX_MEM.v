`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2023 05:57:05 PM
// Design Name: 
// Module Name: EX_MEM
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


module EX_MEM( 
input clk,

input [63:0]addsum, 

input [63:0]Alures, 

input zero, 

input [63:0]RD2, 

input [4:0]RD, 

input regwrite, memtoreg, branch, memread,memwrite, 

output reg[63:0]addsumout, 

output reg[63:0]Aluresout, 

output reg zerout, 

output reg [63:0]RD2out, 

output reg [4:0]RDout, 

output reg regwriteout, memtoregout, branchout, memreadout, memwriteout 

); 
always @(negedge clk)
begin
    addsumout = addsum; 

    Aluresout = Alures; 

    zerout = zero; 

    RD2out = RD2; 

    RDout = RD; 

    regwriteout = regwrite; 

    memtoregout = memtoreg; 

    branchout = branch; 

    memreadout = memread; 

    memwriteout = memwrite; 

end

endmodule  
