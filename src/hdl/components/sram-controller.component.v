`define Idle 4'd0
`define DataWriteLow 4'd1
`define DataWriteHigh 4'd2
`define DataReadLow 4'd3
`define DataReadHigh 4'd4
`define DataReadAux 4'd5
`define Wait1 4'd6
`define Wait2 4'd7
`define Done 4'd9


module SRAMController (
    clk,
    rst,
    read,
    write,
    address,
    dataIn,

    SRAMData,
    SRAMAddress,
    SRAMUB,
    SRAMLB,
    SRAMWE,
    SRAMOE,
    SRAMCE,

    dataOut,
    freeze
);
  input clk, rst;
  input read, write;
  input [31:0] address;
  input [31:0] dataIn;

  inout [15:0] SRAMData;

  output reg [17:0] SRAMAddress;
  output SRAMUB, SRAMLB, SRAMOE, SRAMCE;
  output reg SRAMWE;
  
  output reg [31:0] dataOut;
  output reg freeze;

  reg [4:0] ps, ns;

  reg [15:0] passedData;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      ps <= 0;
    end else begin
      ps <= ns;
    end
  end

  always @(ps, read, write) begin
    ns = `Idle;
    case (ps)
      `Idle: begin
        ns = write ? `DataWriteLow : read ? `DataReadLow : `Idle;
      end
      `DataWriteLow: begin
        ns = `DataWriteHigh;
      end
      `DataWriteHigh: begin
        ns = `Wait1;
      end
      `DataReadLow: begin
        ns = `DataReadHigh;
      end
      `DataReadHigh: begin
        ns = `DataReadAux;
      end
      `DataReadAux: begin
        ns = `Wait2;
      end
      `Wait1: begin
        ns = `Wait2;
      end
      `Wait2: begin
        ns = `Done;
      end
      `Done: begin
        ns = `Idle;
      end
      default: ;
    endcase
  end

  always @(ps) begin
    SRAMWE = 1'b1;
    freeze = 1'b1;
    SRAMAddress = 18'bz;
    passedData = 16'bz;
    case (ps)
      `Idle: begin
        freeze = 1'b0;
      end
      `DataWriteLow: begin
        SRAMWE = 0;
        SRAMAddress = {address[18:2], 1'b0};
        passedData = dataIn[15:0];
      end
      `DataWriteHigh: begin
        SRAMWE = 0;
        SRAMAddress = {address[18:2], 1'b1};
        passedData = dataIn[31:16];
      end
      `DataReadLow: begin
        SRAMAddress = {address[18:2], 1'b0};
      end
      `DataReadHigh: begin
        SRAMAddress = {address[18:2], 1'b1};
        dataOut = {dataOut[15:0], SRAMData[15:0]};
      end
      `DataReadAux: begin
        dataOut = {SRAMData[15:0], dataOut[15:0]};
      end
      default: ;
    endcase
  end

  assign SRAMData = (~SRAMWE) ? passedData : 16'bz;
  assign {SRAMUB, SRAMLB, SRAMOE, SRAMCE} = 0;
endmodule
