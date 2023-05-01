`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2023 05:56:44 PM
// Design Name: 
// Module Name: ID_EX
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


module ID_EX( 
input clk,

input branch, memwrite, memread, memtoreg, alusrc, regwrite, 

input [1:0]ALUop,

input [2:0]func3,

input PC, 

input [63:0]RD1, RD2, 

input [63:0]Immgen, 

input [3:0]func, 

input [4:0]RD, 

output reg branchout, memwriteout, memreadout, memtoregout,regwriteout, alusrcout, 

output reg[1:0]ALUopout,

output reg[2:0]func3out,

output reg PCout, 

output reg [63:0]RD1out, RD2out, 

output reg [63:0]Immgenout, 

output reg [3:0]funcout, 

output reg [4:0]RDout

); 
always @(negedge clk)
begin
 branchout = branch; 

 memwriteout = memwrite; 

 memreadout = memread; 

 memtoregout = memtoreg; 

 regwriteout = regwrite; 

 alusrcout = alusrc; 
 
 ALUopout = ALUop;
 
 func3out = func3;
 
 PCout = PC; 

 RD1out = RD1; 

 RD2out = RD2; 

 Immgenout = Immgen; 

 funcout = func; 

 RDout = RD; 
end

endmodule  
