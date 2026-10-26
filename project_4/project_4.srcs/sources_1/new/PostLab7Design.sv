`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2026 09:09:28 PM
// Design Name: 
// Module Name: PostLab7Design
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

module PostLab7Design #(
    parameter integer SLOW_COUNT = 100000000
)(
    input  logic clk,
    input  logic reset,
    input  logic x,
    output logic z,
    output logic sample_led
);

    typedef enum logic [2:0] {
        A, B, C, D, E
    } state_t;

    state_t current_state, next_state;
    integer count;

    // Advance the FSM once every SLOW_COUNT clock cycles
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            count <= 0;
            sample_led <= 0;
        end
        else if (count == SLOW_COUNT - 1) begin
            count <= 0;
            current_state <= next_state;
            sample_led <= ~sample_led;
        end
        else begin
            count <= count + 1;
        end
    end

    // Moore FSM detects 1001
    always_comb begin
        next_state = current_state;
        z = 1'b0;

        case (current_state)
            A: begin
                if (x == 1'b1)
                    next_state = B;
                else
                    next_state = A;
            end

            B: begin
                if (x == 1'b0)
                    next_state = C;
                else
                    next_state = B;
            end

            C: begin
                if (x == 1'b0)
                    next_state = D;
                else
                    next_state = B;
            end

            D: begin
                if (x == 1'b1)
                    next_state = E;
                else
                    next_state = A;
            end

            E: begin
                z = 1'b1;

                if (x == 1'b1)
                    next_state = B;
                else
                    next_state = A;
            end

            default: begin
                next_state = A;
                z = 1'b0;
            end
        endcase
    end

endmodule