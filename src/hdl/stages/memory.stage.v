module MemoryStage (
    clk,
    rst,
    memoryReadEnabled,
    memoryWriteEnabled,
    aluResult,
    valRm,

    SRAMData,
    SRAMAddress,
    SRAMUB,
    SRAMLB,
    SRAMWE,
    SRAMOE,
    SRAMCE,

    data,
    SRAMFreeze
);
  input clk, rst;
  input memoryReadEnabled, memoryWriteEnabled;
  input [31:0] aluResult, valRm;

  inout [15:0] SRAMData;
  output [17:0] SRAMAddress;
  output SRAMUB, SRAMLB, SRAMOE, SRAMCE, SRAMWE;

  output [31:0] data;
  output SRAMFreeze;

  SRAMController u_SRAMController (
      .clk        (clk),
      .rst        (rst),
      .read       (memoryReadEnabled),
      .write      (memoryWriteEnabled),
      .address    (aluResult),
      .dataIn     (valRm),
      .SRAMData   (SRAMData),
      .SRAMAddress(SRAMAddress),
      .SRAMUB     (SRAMUB),
      .SRAMLB     (SRAMLB),
      .SRAMOE     (SRAMOE),
      .SRAMCE     (SRAMCE),
      .SRAMWE     (SRAMWE),
      .dataOut    (data),
      .freeze     (SRAMFreeze)
  );


endmodule
