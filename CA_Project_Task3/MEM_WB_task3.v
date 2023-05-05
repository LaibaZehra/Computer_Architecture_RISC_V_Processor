`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2023 02:50:50 PM
// Design Name: 
// Module Name: MEM_WB_task3
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


module MEM_WB_task3(
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
always @(posedge clk)
begin
    regwriteout = regwrite; 

    memtoregout = memtoreg; 

    aluresout = alures; 

    readmemout = readmem; 

    RDout = RD; 
end

endmodule
