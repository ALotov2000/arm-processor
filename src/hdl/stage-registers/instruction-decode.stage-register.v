module InstructionDecodeStageReg (
    clk,
    rst,
    flush,
    writeBackEnabled_in,
    memoryReadEnabled_in,
    memoryWriteEnabled_in,
    b_in,
    s_in,
    executionCommand_in,
    pc_in,
    valRn_in,
    valRm_in,
    imm_in,
    shiftOperand_in,
    imm24_in,
    destination_in,
    status_in,
    src1_in,
    src2_in,
    writeBackEnabled,
    memoryReadEnabled,
    memoryWriteEnabled,
    b,
    s,
    executionCommand,
    pc,
    valRn,
    valRm,
    imm,
    shiftOperand,
    imm24,
    destination,
    status,
    src1,
    src2
);
  input clk, rst, flush;
  input writeBackEnabled_in, memoryReadEnabled_in, memoryWriteEnabled_in;
  input b_in, s_in;
  input [3:0] executionCommand_in;
  input [31:0] pc_in;
  input [31:0] valRn_in, valRm_in;
  input imm_in;
  input [11:0] shiftOperand_in;
  input [23:0] imm24_in;
  input [3:0] destination_in;
  input [3:0] status_in;
  input [3:0] src1_in, src2_in;

  output writeBackEnabled, memoryReadEnabled, memoryWriteEnabled;
  output b, s;
  output [3:0] executionCommand;
  output [31:0] pc;
  output [31:0] valRn, valRm;
  output imm;
  output [11:0] shiftOperand;
  output [23:0] imm24;
  output [3:0] destination;
  output [3:0] status;
  output [3:0] src1, src2;


  RegisterWithFreezeAndFlush #(3*1 + 2*1 + 4*1 + 32*1 + 32*2 + 1*1 + 12*1 + 24*1 + 4*1 + 4*1 + 4*2) u_RegisterWithFreezeAndFlush (
      .clk(clk),
      .rst(rst),
      .freeze(1'b0),
      .flush(flush),
      .in({
        writeBackEnabled_in,
        memoryReadEnabled_in,
        memoryWriteEnabled_in,
        b_in,
        s_in,
        executionCommand_in,
        pc_in,
        valRn_in,
        valRm_in,
        imm_in,
        shiftOperand_in,
        imm24_in,
        destination_in,
        status_in,
        src1_in,
        src2_in
      }),
      .out({
        writeBackEnabled,
        memoryReadEnabled,
        memoryWriteEnabled,
        b,
        s,
        executionCommand,
        pc,
        valRn,
        valRm,
        imm,
        shiftOperand,
        imm24,
        destination,
        status,
        src1,
        src2
      })
  );

  always @(writeBackEnabled_in) begin
    $display("instruction stage register: writebackEnabled_in = %b", writeBackEnabled_in);
  end
endmodule
