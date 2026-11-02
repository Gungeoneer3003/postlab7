`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2026 06:28:47 PM
// Design Name: 
// Module Name: sequence_detector_1001_q2_tb
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


module sequence_detector_1001_q2_tb;

    logic clk;
    logic rst_n;
    logic in_bit;
    logic detected;

    sequence_detector_1001_q2 uut (
        .clk(clk),
        .rst_n(rst_n),
        .in_bit(in_bit),
        .detected(detected)
    );

    // Clock: 20 ns period
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    // Reset and test inputs
    initial begin
        rst_n  = 0;
        in_bit = 0;

        #15;
        rst_n = 1;      

        #5;

       
        in_bit = 1; #20;
        in_bit = 0; #20;
        in_bit = 0; #20;
        in_bit = 1; #20;

        // Test 2: 1000 -- detected stays 0
        in_bit = 1; #20;
        in_bit = 0; #20;
        in_bit = 0; #20;
        in_bit = 0; #20;

      
        in_bit = 1; #20;
        in_bit = 0; #20;
        in_bit = 0; #20;
        in_bit = 1; #20;
        in_bit = 0; #20;
        in_bit = 0; #20;
        in_bit = 1; #20;

        
        in_bit = 1; #20;
        in_bit = 0; #20;
        in_bit = 0; #20;
        in_bit = 1; #20;

        in_bit = 1; #20;
        in_bit = 0; #20;
        in_bit = 0; #20;
        in_bit = 1; #20;

        #20;
        $finish;
    end

endmodule