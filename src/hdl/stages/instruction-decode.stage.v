module InstructionDecodeStage (clk,
                               rst,
                               INSTRUCTION,
                               RESULT_WB,
                               WB_EN_IN,
                               DEST_WB,
                               HAZARD,
                               SR,
                               WB_EN,
                               MEM_R_EN,
                               MEM_W_EN,
                               B,
                               S,
                               EXE_CMD,
                               VAL_RN,
                               VAL_RM,
                               IMM,
                               SHIFT_OPERAND,
                               SIGNED_IMM_24,
                               DEST,
                               SRC1,
                               SRC2,
                               TWO_SRC);
    
    input clk, rst;
    input [31:0] INSTRUCTION;
    input [31:0] RESULT_WB;
    input WB_EN_IN;
    input [3:0] DEST_WB;
    input HAZARD;
    input [3:0] SR;
    output WB_EN, MEM_R_EN, MEM_W_EN, B, S;
    output [3:0] EXE_CMD;
    output [31:0] VAL_RN, VAL_RM;
    output IMM;
    output [11:0] SHIFT_OPERAND;
    output [23:0] SIGNED_IMM_24;
    output [3:0] DEST;
    output [3:0] SRC1, SRC2;
    output TWO_SRC;
    
    wire CONDITION, CONTROL;
    
    wire[3:0] COND, OPCODE;
    wire[1:0] MODE;
    wire S_IN, I;
    wire[3:0] RN, RD, RS, RM;
    
    assign COND          = INSTRUCTION[31:28];
    assign MODE          = INSTRUCTION[27:26];
    assign I             = INSTRUCTION[25];
    assign OPCODE        = INSTRUCTION[24:21];
    assign S_IN          = INSTRUCTION[20];
    assign RN            = INSTRUCTION[19:16];
    assign RD            = INSTRUCTION[15:12];
    assign RS            = INSTRUCTION[11:8];
    assign RM            = INSTRUCTION[3:0];
    assign SHIFT_OPERAND = INSTRUCTION[11:0];
    assign SIGNED_IMM_24 = INSTRUCTION[23:0];
    assign IMM           = INSTRUCTION[24];
    
    assign DEST = RD;
    
    assign SRC1 = RN;
    Mux2 #(4) src2mux (
    .in0(RM), .in1(RD),
    .selector(MEM_W_EN),
    .out(SRC2)
    );
    
    RegisterFile registerFile(
    .clk(clk), .rst(rst),
    .SRC1(SRC1),
    .SRC2(SRC2),
    .DEST_WB(DEST_WB),
    .RESULT_WB(RESULT_WB),
    .WB_EN(WB_EN_IN),
    .REG1(VAL_RN), .REG2(VAL_RM)
    );
    
    wire TP_S, TP_B;
    wire[3:0] TP_EXE_CMD;
    wire TP_MEM_W_EN, TP_MEM_R_EN, TP_WB_EN;
    
    ControlUnit controlUnit(
    .OPCODE(OPCODE),
    .MODE(MODE),
    .S_IN(S_IN),
    
    .EXE_CMD(TP_EXE_CMD),
    .S(TP_S),
    .B(TP_B),
    .MEM_W_EN(TP_MEM_W_EN),
    .MEM_R_EN(TP_MEM_R_EN),
    .WB_EN(TP_WB_EN)
    );
    
    ConditionCheck conditionCheck(
    .COND(COND),
    .STATUS(SR),
    .RESULT(CONDITION)
    );
    
    assign CONTROL = ~CONDITION | HAZARD;
    
    Mux2 #(9) controlMux(
    .in0(9'b0),
    .in1({TP_S, TP_B, TP_EXE_CMD, TP_MEM_W_EN, TP_MEM_R_EN, TP_WB_EN}),
    .selector(CONTROL),
    
    .out({S, B, EXE_CMD, MEM_W_EN, MEM_R_EN, WB_EN})
    );
    
    assign TWO_SRC = ~I | MEM_W_EN;
    
    
endmodule
