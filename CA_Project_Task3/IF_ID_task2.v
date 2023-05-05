`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2023 11:08:06 PM
// Design Name: 
// Module Name: IF_ID_task2
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


module IF_ID 

( 

  

    input clk, 

    input [63:0] PC_addr, 

    input [31:0] Instruc, 

    output reg [63:0] PC_store, 

    output reg [31:0] Instr_store 

); 

always @(negedge clk) begin 

    PC_store = PC_addr; 

    Instr_store = Instruc; 

     

end 

endmodule  

  
