`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2024 08:54:24
// Design Name: 
// Module Name: uart_tx
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

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2024 08:54:24
// Design Name: 
// Module Name: uart_tx
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

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2024 08:54:24
// Design Name: 
// Module Name: uart_tx
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

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2024 08:54:24
// Design Name: 
// Module Name: uart_tx
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

module uart_tx #(
    parameter CLKRATE = 100000000,
    parameter BAUD = 114200,
    parameter WORD_LENGTH = 8
) (         
    input clk,
    input rst,
    input [WORD_LENGTH-1:0] tx_data,
    input tx_data_valid,
    output wire UART_TX
);

    // Internal registers
    reg [WORD_LENGTH-1:0] tx_data_i;
    reg [2:0] bit_index; // To track the bit position in the word being transmitted
    reg uart_baud_done; // Placeholder for baud rate done signal
    reg uart_data_done; // Placeholder for data done signal
    reg [WORD_LENGTH-1:0] uart_data_shift_buffer; // Placeholder for shifting data
    reg uart_tx_i; // Internal signal for UART_TX

    // State definitions
    localparam IDLE = 3'b000;
    localparam START = 3'b001;
    localparam DATA = 3'b010;
    localparam PARITY = 3'b011;
    localparam STOP = 3'b100;
    localparam WAIT = 3'b101;

    // State registers
    reg [2:0] current_state = IDLE;
    reg [2:0] next_state = IDLE;

    // Define tx signal constants
    localparam TX_IDLE = 1'b1;
    localparam TX_START = 1'b0;
    localparam TX_STOP = 1'b1;

    // Store tx_data_i when valid
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx_data_i <= 0;
        end else begin
            if (tx_data_valid && tx_data_ready) begin
                tx_data_i <= tx_data;
            end
        end
    end

    // State machine for UART transmission
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= IDLE;
            uart_tx_i <= TX_IDLE;
            bit_index <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state; // Default to no change in state
        case (current_state)
            IDLE: begin
                if (tx_data_valid) begin
                    next_state = START;
                end
            end

            START: begin
                if (uart_baud_done) begin
                    next_state = DATA;
                end
            end

            DATA: begin
                if (uart_data_done && uart_baud_done) begin
                    next_state = PARITY;
                end
            end

            PARITY: begin
                if (uart_baud_done) begin
                    next_state = STOP;
                end
            end

            STOP: begin
                if (uart_baud_done) begin
                    next_state = WAIT;
                end
            end

            WAIT: begin
                if (uart_baud_done) begin
                    next_state = IDLE;
                end
            end

            default: next_state = IDLE;
        endcase
    end

    always @(*) begin
        case (current_state)
            IDLE: uart_tx_i = TX_IDLE;
            START: uart_tx_i = TX_START;
            DATA: uart_tx_i = tx_data_i[bit_index];
            PARITY: uart_tx_i = ^tx_data_i;
            STOP: uart_tx_i = TX_STOP;
            WAIT: uart_tx_i = TX_IDLE;
        endcase
    end

    assign tx_data_ready = (current_state == IDLE) ? 1'b1 : 1'b0;
    assign UART_TX = uart_tx_i;

    // Dummy assignments for baud and data done signals
    // Replace these with your actual logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            uart_baud_done <= 0;
            uart_data_done <= 0;
        end else begin
            uart_baud_done <= 1; // This is just a placeholder
            uart_data_done <= (bit_index == WORD_LENGTH - 1); // Placeholder logic
        end
    end

endmodule
