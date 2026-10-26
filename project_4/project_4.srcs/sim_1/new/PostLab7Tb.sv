`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2026 09:09:43 PM
// Design Name: 
// Module Name: PostLab7Tb
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

module PostLab7Tb;

    logic clk;
    logic reset;
    logic x;
    logic z;
    logic sample_led;

    PostLab7Design #(.SLOW_COUNT(10)) UUT (
        .clk(clk),
        .reset(reset),
        .x(x),
        .z(z),
        .sample_led(sample_led)
    );

    always #5 clk = ~clk;

    task send_bit(input logic value);
        begin
            @(negedge clk);
            x = value;

            repeat (10) @(posedge clk);
            #1;
            $display("x=%b  z=%b", x, z);
        end
    endtask

    initial begin
        clk = 0;
        reset = 1;
        x = 0;

        repeat (2) @(posedge clk);
        @(negedge clk);
        reset = 0;

        send_bit(1'b1);
        send_bit(1'b0);
        send_bit(1'b0);
        send_bit(1'b1);

        send_bit(1'b1);
        send_bit(1'b0);
        send_bit(1'b0);
        send_bit(1'b1);

        $finish;
    end

endmodule