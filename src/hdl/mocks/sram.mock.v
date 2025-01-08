module SRAM (
    clk,
    addr,
    we,

    data
);

  parameter WIDTH = 12;
  input clk;
  input [17:0] addr;
  input we;

  inout [15:0] data;

  reg [15:0] mem[0:WIDTH-1];
  wire [15:0] write_data;

  reg [17:0] trueAddr;

  always @(addr) begin
    trueAddr = addr - 18'd512;
  end

  assign write_data = data;
  assign data = (~we) ? 16'bz : mem[trueAddr];

  always @(posedge clk) begin
    if (~we) begin
      mem[trueAddr] <= write_data;
    end
  end

endmodule
