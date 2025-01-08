`timescale 1ns / 1ns
module SRAMControllerTest;
  reg clk, rst;

  reg read, write;

  localparam dataIn = 32'h1234_5678;
  localparam address = 32'h0000_1000;

  wire [15:0] SRAMData;
  wire [17:0] SRAMAddress;
  wire [31:0] dataOut;
  wire SRAMWE;
  wire freeze;

  SRAM u_SRAM (
      .clk (clk),
      .addr(SRAMAddress),
      .we  (SRAMWE),
      .data(SRAMData)
  );


  SRAMController u_SRAMController (
      .clk        (clk),
      .rst        (rst),
      .read       (read),
      .write      (write),
      .address    (address),
      .dataIn     (dataIn),
      .SRAMData   (SRAMData),
      .SRAMAddress(SRAMAddress),
      .SRAMUB     (),
      .SRAMLB     (),
      .SRAMOE     (),
      .SRAMCE     (),
      .SRAMWE     (SRAMWE),
      .dataOut    (dataOut),
      .freeze     (freeze)
  );


  initial begin
    clk = 1'b0;
    forever begin
      #10 clk = ~clk;
    end
  end

  initial begin
    {read, write} = 0;

    rst = 0;
    #30 rst = 1;
    #40 rst = 0;

    #50 write = 1'b1;
    #40 write = 1'b0;

    #1000;

    read = 1'b1;
    #40 read = 1'b0;
    wait (dataOut[15:0] == dataIn[15:0]);
    wait (dataOut[31:16] == dataIn[31:16]);

    if (dataIn == dataOut) begin
      $display("SRAMControllerTest: Test passed");
    end else begin
      $display("SRAMControllerTest: Test failed");
    end

    #1000 $stop;
  end
endmodule
