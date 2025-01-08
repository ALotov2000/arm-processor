module SRAM (
    clk,
    addr,
    we,

    data
);
  input clk;
  input [17:0] addr;
  input we;

  inout [15:0] data;

  reg [15:0] mem[0:262143];
  wire [15:0] write_data;

  assign write_data = data;
  assign data = (~we) ? 16'bz : mem[addr];

  always @(posedge clk) begin
    if (~we) begin
      mem[addr] <= write_data;
    end
  end

endmodule
