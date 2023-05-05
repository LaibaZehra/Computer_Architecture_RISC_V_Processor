`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2023 02:49:28 PM
// Design Name: 
// Module Name: IF_ID_task3
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


module IF_ID_task3(
    input clk,
    
    input Flushout,
    
    input IFID_Write,
    
    input [31:0]Instruction, 
    
    input [63:0]PCOut, 
    
    output reg[31:0]Ins, 
    
    output reg[63:0]PC

    
); 

always @(posedge clk)
begin
if (Flushout)
begin
    Ins = 32'b0; 
    
    PC = 64'b0; 
    
end
else if (!IFID_Write)
begin
    Ins = Ins;
    PC = PC;
end
else
begin
    Ins = Instruction; 
    
    PC = PCOut; 
    
end
end

endmodule
