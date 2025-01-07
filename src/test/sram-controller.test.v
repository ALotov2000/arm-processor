`timescale 1ns / 1ns
module SRAMControllerTest;
  reg clk, rst;

  reg read, write;

  reg readFromSRAMData;
  reg [15:0] receivedSRAMData;

  localparam dataIn = 32'h1234_5678;
  localparam receivedData = 32'h3452_6785;
  localparam address = 32'h0000_1000;

  wire [15:0] SRAMData;
  wire [17:0] SRAMAddress;
  wire [31:0] dataOut;
  wire SRAMWE;
  wire freeze;

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

  assign SRAMData = (readFromSRAMData) ? receivedSRAMData : 32'bz;


  initial begin
    clk = 1'b0;
    forever begin
      #10 clk = ~clk;
    end
  end

  initial begin
    {read, write} = 0;
    readFromSRAMData = 0;

    rst = 0;
    #30 rst = 1;
    #40 rst = 0;

    #50 write = 1'b1;
    #40 write = 1'b0;

    #1000;
    readFromSRAMData = 1;
    receivedSRAMData = receivedData[15:0];

    read = 1'b1;
    #40 read = 1'b0;
    wait(dataOut[15:0] == receivedData[15:0]);
    receivedSRAMData = receivedData[31:16];

    #1000 $stop;
  end
endmodule
