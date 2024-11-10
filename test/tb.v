`timescale 1ns / 1ps

module tb;

  // 8-bit Inputs and Outputs
  reg [7:0] ui_in;
  reg clk;
  reg rst_n;
  reg ena;

  // 8-bit Outputs
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

  // Instantiate the Device Under Test (DUT)
  tt_um_liaf dut (
    .ui_in(ui_in),
    .uo_out(uo_out),
    .uio_out(uio_out),
    .uio_oe(uio_oe),
    .ena(ena),
    .clk(clk),
    .rst_n(rst_n)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 100MHz clock
  end

  // Test sequence
  initial begin
    // Initialize inputs
    ui_in = 8'b00000000;
    ena = 1;
    rst_n = 0;

    // Apply reset
    #10 rst_n = 1;

    // Apply input stimulus after reset is released
    #10 ui_in = 8'b00001111;
    #20 ui_in = 8'b11110000;
    #20 ui_in = 8'b10101010;

    // Finish the test after some time
    #100 $finish;
  end

  // Monitor output for debugging
  initial begin
    $monitor("Time = %0t | clk = %b | rst_n = %b | ena = %b | ui_in = %b | uo_out = %b | uio_out = %b",
             $time, clk, rst_n, ena, ui_in, uo_out, uio_out);
  end

endmodule


