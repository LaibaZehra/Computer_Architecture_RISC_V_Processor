`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2023 11:03:36 PM
// Design Name: 
// Module Name: Branch_Control_task2
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


module Branch_Control
(
    input Branch, Zero, Is_Greater,
    input [3:0] funct,
    input [63:0]Result,
    output reg switch_branch
);


always @(*) begin

    if (Branch) begin

        case ({funct[2:0]})
            3'b000: switch_branch = Zero ? 1 : 0;
            3'b001: switch_branch = Zero ? 0 : 1;
            3'b100 : switch_branch = (Result[63]== 1 ? 1 : 0);
            3'b101: switch_branch = Is_Greater ? 1 : 0;
        endcase
    
    end
    
    else
        switch_branch = 0;
end


endmodule
