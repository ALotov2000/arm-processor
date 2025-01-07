
module MemoryStageReg (
    clk,
    rst,
    freeze,
    destination_in,
    data_in,
    aluResult_in,
    memoryReadEnabled_in,
    writeBackEnabled_in,
    destination,
    data,
    aluResult,
    memoryReadEnabled,
    writeBackEnabled
);

  input clk, rst;
  input freeze;
  input [3:0] destination_in;
  input [31:0] data_in, aluResult_in;
  input memoryReadEnabled_in, writeBackEnabled_in;

  output [3:0] destination;
  output [31:0] data, aluResult;
  output memoryReadEnabled, writeBackEnabled;

  RegisterWithFreezeAndFlush #(1 * 4 + 2 * 32 + 2 * 1) u_RegisterWithFreezeAndFlush (
      .clk   (clk),
      .rst   (rst),
      .freeze(freeze),
      .flush (1'b0),
      .in    ({destination_in, data_in, aluResult_in, memoryReadEnabled_in, writeBackEnabled_in}),
      .out   ({destination, data, aluResult, memoryReadEnabled, writeBackEnabled})
  );


  always @(writeBackEnabled_in) begin
    $display("memory stage register: writebackEnabled_in = %b", writeBackEnabled_in);
    $display("memory stage register: writebackEnabled = %b", writeBackEnabled);
  end
endmodule
