`define READ_DEFAULT 2'd0
`define READ_FROM_MEM 2'd1
`define READ_FROM_WB 2'd2

module ExecutionStage (
    clk,
    executionCommand,
    memoryReadEnabled,
    memoryWriteEnabled,
    pc,
    valRn,
    valRm,
    imm,
    shiftOperand,
    imm24,
    status,

    // forwarding
    forwarded_mem,
    forwarded_wb,
    src1Sel,
    src2Sel,

    aluResult,
    branchAddress,
    statusOut
);

  input clk;
  input [3:0] executionCommand;
  input memoryReadEnabled, memoryWriteEnabled;
  input [31:0] pc;
  input [31:0] valRn, valRm;
  input imm;
  input [11:0] shiftOperand;
  input [23:0] imm24;
  input [3:0] status;

  input [31:0] forwarded_mem, forwarded_wb;
  input [1:0] src1Sel, src2Sel;

  output [31:0] aluResult, branchAddress;
  output [3:0] statusOut;

  wire memoryInstruction;

  wire [31:0] val1_in;

  wire [31:0] val1, val2genIn, val2;
  wire carryIn;

  assign val1    = (src1Sel == `READ_FROM_MEM) ? forwarded_mem : (src1Sel == `READ_FROM_WB) ? forwarded_wb : valRn;
  assign val2genIn = (src2Sel == `READ_FROM_MEM) ? forwarded_mem : (src2Sel == `READ_FROM_WB) ? forwarded_wb : valRm;
  assign carryIn = status[1];

  assign memoryInstruction = memoryReadEnabled | memoryWriteEnabled;

  assign branchAddress = pc + {{6{imm24[23]}}, imm24, 2'b0};

  Val2Generator u_Val2Generator (
      .val2genIn        (val2genIn),
      .shiftOperand     (shiftOperand),
      .imm              (imm),
      .memoryInstruction(memoryInstruction),
      .val2             (val2)
  );


  ALU alu (
      val1,
      val2,
      executionCommand,
      carryIn,
      aluResult,
      statusOut
  );
endmodule
