`timescale 1ns/1ps

module tb;

  // Declare signals for the DUT (Device Under Test) connections
  reg ui_in;
  reg clk;
  reg rst_n;
  reg ena;
  wire uo_out;
  wire uio_in;
  wire uio_out;
  wire uio_oe;

  // Instantiate the DUT
  // Ensure that the module name and signal connections match your design
  tt_um_lif uut (
    .ui_in(ui_in),
    .uo_out(uo_out),
    .uio_in(uio_in),
    .uio_out(uio_out),
    .uio_oe(uio_oe),
    .ena(ena),
    .clk(clk),
    .rst_n(rst_n)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // Generate a clock with a period of 10 time units
  end

  // Test procedure
  initial begin
    // Initialize signals
    ui_in = 0;
    rst_n = 0;
    ena = 0;

    // Reset pulse
    #10 rst_n = 1;
    #10 rst_n = 0;
    #10 rst_n = 1;

    // Test scenario
    #20 ena = 1;   // Enable the DUT
    #20 ui_in = 1; // Set input to test output response
    #50 ui_in = 0;
    #20 ena = 0;   // Disable the DUT

    #100 $finish;  // End simulation
  end

  // Monitor signals
  initial begin
    $monitor("Time = %0t | clk = %b | rst_n = %b | ena = %b | ui_in = %b | uo_out = %b", 
              $time, clk, rst_n, ena, ui_in, uo_out);
  end

endmodule

