`define READ_DEFAULT 2'd0
`define READ_FROM_MEM 2'd1
`define READ_FROM_WB 2'd2

module ForwardingUnit (
    forwardingEnabled,
    writeBackEnabled_mem,
    writeBackEnabled_wb,
    destination_mem,
    destination_wb,
    src1,
    src2,
    src1Sel,
    src2Sel
);
  input forwardingEnabled;
  input writeBackEnabled_wb, writeBackEnabled_mem;
  input [3:0] destination_wb, destination_mem;
  input [3:0] src1, src2;
  output [1:0] src1Sel, src2Sel;

  assign src1Sel = forwardingEnabled ? (
    (writeBackEnabled_mem && src1 == destination_mem) ? `READ_FROM_MEM :
    (writeBackEnabled_wb && src1 == destination_wb) ? `READ_FROM_WB:
      `READ_DEFAULT
      ) : `READ_DEFAULT;

  assign src2Sel = forwardingEnabled ? (
    (writeBackEnabled_mem && src2 == destination_mem) ? `READ_FROM_MEM :
    (writeBackEnabled_wb && src2 == destination_wb) ? `READ_FROM_WB:
      `READ_DEFAULT
      ) : `READ_DEFAULT;
endmodule
