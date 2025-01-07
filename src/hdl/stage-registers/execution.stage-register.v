module ExecutionStageReg (
    clk,
    rst,
    freeze,
    writebackEnabledIn,
    memoryReadEnabledIn,
    memoryWriteEnabledIn,
    aluResultIn,
    valRmIn,
    destinationIn,
    writebackEnabled,
    memoryReadEnabled,
    memoryWriteEnabled,
    aluResult,
    valRm,
    destination
);
  input clk, rst;
  input freeze;
  input writebackEnabledIn, memoryReadEnabledIn, memoryWriteEnabledIn;
  input [31:0] aluResultIn, valRmIn;
  input [3:0] destinationIn;

  output writebackEnabled, memoryReadEnabled, memoryWriteEnabled;
  output [31:0] aluResult, valRm;
  output [3:0] destination;


  RegisterWithFreezeAndFlush #(1 * 3 + 32 * 2 + 4 * 1) u_RegisterWithFreezeAndFlush (
      .clk(clk),
      .rst(rst),
      .freeze(freeze),
      .flush(1'b0),
      .in({
        writebackEnabledIn,
        memoryReadEnabledIn,
        memoryWriteEnabledIn,
        aluResultIn,
        valRmIn,
        destinationIn
      }),
      .out({writebackEnabled, memoryReadEnabled, memoryWriteEnabled, aluResult, valRm, destination})
  );

endmodule
