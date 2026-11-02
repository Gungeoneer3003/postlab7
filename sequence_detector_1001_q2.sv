`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2026 06:22:15 PM
// Design Name: 
// Module Name: sequence_detector_1001_q2
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


module sequence_detector_1001_q2(
     input  logic clk,
    input  logic rst_n,
    input  logic in_bit,
    output logic detected
);

    // S0 = no matching bits
    // S1 = received 1
    // S2 = received 10
    // S3 = received 100
    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10,
        S3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State register
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next-state and Mealy output logic
    always_comb begin
        next_state = current_state;
        detected   = 1'b0;

        case (current_state)

            S0: begin
                if (in_bit == 1'b1)
                    next_state = S1;
                else
                    next_state = S0;
            end

            S1: begin
                if (in_bit == 1'b0)
                    next_state = S2;
                else
                    next_state = S1;
            end

            S2: begin
                if (in_bit == 1'b0)
                    next_state = S3;
                else
                    next_state = S1;
            end

            S3: begin
                if (in_bit == 1'b1) begin
                    detected   = 1'b1;
                    next_state = S0;  // non-overlapping reset
                end
                else begin
                    next_state = S0;
                end
            end

            default: begin
                next_state = S0;
                detected   = 1'b0;
            end
        endcase
    end
endmodule


