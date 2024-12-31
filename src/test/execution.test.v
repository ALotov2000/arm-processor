
`timescale 1ns / 1ps

module ExecutionTest();
    reg clk;
    reg rst;
    
    wire flush, freeze;
    
    wire[31:0] branchAddress_if, pc_if, instruction_if;
    wire branchTaken_if;
    
    wire[31:0] pc_id, instruction_id, valRn_id, valRm_id;
    wire[23:0] imm24_id;
    wire[11:0] shiftOperand_id;
    wire[3:0] status_id, executionCommand_id, destination_id, src1_id, src2_id;
    wire hazard_id, writebackEnabled_id, memoryReadEnabled_id, memoryWriteEnabled_id, b_id, s_id, imm_id, twoSrc_id;
    
    wire[31:0] pc_exe;
    wire writebackEnabled_exe, memoryReadEnabled_exe, memoryWriteEnabled_exe, b_exe, s_exe;
    wire [3:0] executionCommand_exe;
    wire [31:0] valRn_exe, valRm_exe;
    wire imm_exe;
    wire [11:0] shiftOperand_exe;
    wire [23:0] imm24_exe;
    wire [3:0] destination_exe;
    wire [3:0] src1_exe, src2_exe;
    wire twoSrc_exe;
    wire [3:0] status_exe, statusOut_exe;
    wire [31:0] aluResult_exe, branchAddress_exe;
    
    wire[31:0] writebackValue_wb;
    wire[3:0] writebackDestination_wb;
    wire writebackEnabled_wb;
    
    assign {
    branchAddress_if,
    branchTaken_if,
    freeze_if,
    
    hazard_id,
    
    writebackDestination_wb,
    writebackEnabled_wb,
    writebackValue_wb
    } = 0; // initialization
    
    InstructionFetchStage ifStage (
    clk, rst,
    freeze, branchTaken_if,
    branchAddress_if,
    
    pc_if, instruction_if,
    flush
    );
    
    InstructionFetchStageReg ifStageReg (
    clk, rst,
    freeze, flush,
    pc_if, instruction_if,
    
    pc_id, instruction_id
    );
    
    InstructionDecodeStage idStage(
    clk, rst,
    instruction_id,
    writebackValue_wb,
    writebackEnabled_wb,
    writebackDestination_wb,
    hazard_id,
    status_id,
    
    writebackEnabled_id,
    memoryReadEnabled_id,
    memoryWriteEnabled_id,
    s_id,
    b_id,
    executionCommand_id,
    valRn_id, valRm_id,
    imm_id,
    shiftOperand_id,
    imm24_id,
    destination_id,
    src1_id, src2_id,
    twoSrc_id
    );
    
    InstructionDecodeStageReg u_InstructionDecodeStageReg(
    .clk                   (clk),
    .rst                   (rst),
    .flush                 (flush),
    .writeBackEnabled_in   (writeBackEnabled_id),
    .memoryReadEnabled_in  (memoryReadEnabled_id),
    .memoryWriteEnabled_in (memoryWriteEnabled_id),
    .b_in                  (b_id),
    .s_in                  (s_id),
    .executionCommand_in   (executionCommand_id),
    .pc_in                 (pc_id),
    .valRn_in              (valRn_id),
    .valRm_in              (valRm_id),
    .imm_in                (imm_id),
    .shiftOperand_in       (shiftOperand_id),
    .imm24_in              (imm24_id),
    .destination_in        (destination_id),
    .status_in             (status_id),
    .writeBackEnabled      (writeBackEnabled_exe),
    .memoryReadEnabled     (memoryReadEnabled_exe),
    .memoryWriteEnabled    (memoryWriteEnabled_exe),
    .b                     (b_exe),
    .s                     (s_exe),
    .executionCommand      (executionCommand_exe),
    .pc                    (pc_exe),
    .valRn                 (valRn_exe),
    .valRm                 (valRm_exe),
    .imm                   (imm_exe),
    .shiftOperand          (shiftOperand_exe),
    .imm24                 (imm24_exe),
    .destination           (destination_exe),
    .status                (status_exe)
    );
    
    ExecutionStage u_ExecutionStage(
    .clk                (clk),
    .executionCommand   (executionCommand_exe),
    .memoryReadEnabled  (memoryReadEnabled_exe),
    .memoryWriteEnabled (memoryWriteEnabled_exe),
    .pc                 (pc_exe),
    .valRn              (valRn_exe),
    .valRm              (valRm_exe),
    .imm                (imm_exe),
    .shiftOperand       (shiftOperand_exe),
    .imm24              (imm24_exe),
    .status             (status_exe),
    .aluResult          (aluResult_exe),
    .branchAddress      (branchAddress_exe),
    .statusOut          (statusOut_exe)
    );
    
    StatusRegister u_StatusRegister(
    .clk (clk),
    .rst (rst),
    .s   (s_exe),
    .in  (statusOut_exe),
    .out (status_id)
    );
    
    initial begin
        clk             = 0;
        forever #10 clk = ~clk;
    end
    
    initial begin
        rst = 1'b0;
        #10;
        rst = 1'b1;
        #30
        rst = 1'b0;
        #500;
        $stop;
    end
endmodule
