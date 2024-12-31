`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2024 20:18:41
// Design Name: 
// Module Name: lfsr_8bit
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

module lfsr_8bit(
    input clk,
    input rst,
    input clk_en,
    output [7:0] data
);
    reg [7:0] lfsr;
    wire lfsr_feedback;

    assign lfsr_feedback = lfsr[7] ^ lfsr[5] ^ lfsr[4] ^ lfsr[3];

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            lfsr <= 8'b11111111;
        end else if (clk_en) begin
            lfsr <= {lfsr[6:0], lfsr_feedback};
        end
    end

    assign data = lfsr;

endmodule
