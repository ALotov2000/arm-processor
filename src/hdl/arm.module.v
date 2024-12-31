module ARMModule (clk,
                  rst);
    input clk, rst;
    
    wire freeze, flush, hazard;
    wire twoSrc;
    wire [3:0] src1, src2;
    
    wire [31:0] pc_if, instruction_if;
    
    wire writeBackEnabled_id, memoryReadEnabled_id, memoryWriteEnabled_id;
    wire b_id, s_id;
    wire [3:0] executionCommand_id;
    wire [31:0] pc_id, instruction_id;
    wire [31:0] valRn_id, valRm_id;
    wire imm_id;
    wire [11:0] shiftOperand_id;
    wire [23:0] imm24_id;
    wire [3:0] destination_id;
    wire [3:0] status_id;
    
    wire writeBackEnabled_exe, memoryReadEnabled_exe, memoryWriteEnabled_exe;
    wire b_exe, s_exe;
    wire [3:0] executionCommand_exe;
    wire [31:0] pc_exe;
    wire [31:0] valRn_exe, valRm_exe;
    wire imm_exe;
    wire [11:0] shiftOperand_exe;
    wire [23:0] imm24_exe;
    wire [3:0] destination_exe;
    wire [3:0] status_exe;
    wire [31:0] aluResult_exe, branchAddress_exe;
    wire [3:0] statusOut_exe;
    
    wire writeBackEnabled_mem, memoryReadEnabled_mem, memoryWriteEnabled_mem;
    wire [31:0] aluResult_mem, valRm_mem;
    wire [3:0] destination_mem;
    wire [31:0] data_mem;
    
    wire writeBackEnabled_wb, memoryReadEnabled_wb;
    wire [31:0] aluResult_wb, data_wb, writeBackValue_wb;
    wire [3:0] destination_wb;
    
    wire [3:0] status_in, status;
    
    assign flush  = b_exe;
    assign freeze = hazard;
    
    InstructionFetchStage u_InstructionFetchStage(
    .clk          (clk),
    .rst          (rst),
    .freeze       (freeze),
    .Branch_taken (b_exe),
    .BranchAddr   (branchAddress_exe),
    .PC           (pc_if),
    .Instruction  (instruction_if)
    );
    
    InstructionFetchStageReg u_InstructionFetchStageReg(
    .clk             (clk),
    .rst             (rst),
    .freeze          (freeze),
    .flush           (flush),
    .PC_in           (pc_if),
    .Instruction_in  (instruction_if),
    .PC_out          (pc_id),
    .Instruction_out (instruction_id)
    );
    
    assign status_id = status;
    
    InstructionDecodeStage u_InstructionDecodeStage(
    .clk           (clk),
    .rst           (rst),
    .INSTRUCTION   (instruction_id),
    .RESULT_WB     (writeBackValue_wb),
    .WB_EN_IN      (writeBackEnabled_wb),
    .DEST_WB       (destination_wb),
    .HAZARD        (hazard),
    .SR            (status),
    .WB_EN         (writeBackEnabled_id),
    .MEM_R_EN      (memoryReadEnabled_id),
    .MEM_W_EN      (memoryWriteEnabled_id),
    .B             (b_id),
    .S             (s_id),
    .EXE_CMD       (executionCommand_id),
    .VAL_RN        (valRn_id),
    .VAL_RM        (valRm_id),
    .IMM           (imm_id),
    .SHIFT_OPERAND (shiftOperand_id),
    .SIGNED_IMM_24 (imm24_id),
    .DEST          (destination_id),
    .SRC1          (src1),
    .SRC2          (src2),
    .TWO_SRC       (twoSrc)
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
    
    assign status_in = statusOut_exe;
    
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
    
    ExecutionStageReg u_ExecutionStageReg(
    .clk                  (clk),
    .rst                  (rst),
    .writebackEnabledIn   (writeBackEnabled_exe),
    .memoryReadEnabledIn  (memoryReadEnabled_exe),
    .memoryWriteEnabledIn (memoryWriteEnabled_exe),
    .aluResultIn          (aluResult_exe),
    .valRmIn              (valRm_exe),
    .destinationIn        (destination_exe),
    .writebackEnabled     (writeBackEnabled_mem),
    .memoryReadEnabled    (memoryReadEnabled_mem),
    .memoryWriteEnabled   (memoryWriteEnabled_mem),
    .aluResult            (aluResult_mem),
    .valRm                (valRm_mem),
    .destination          (destination_mem)
    );
    
    MemoryStage u_MemoryStage(
    .clk                (clk),
    .rst                (rst),
    .memoryReadEnabled  (memoryReadEnabled_mem),
    .memoryWriteEnabled (memoryWriteEnabled_mem),
    .aluResult          (aluResult_mem),
    .valRm              (valRm_mem),
    .data               (data_mem)
    );
    
    MemoryStageReg u_MemoryStageReg(
    .clk                  (clk),
    .rst                  (rst),
    .destination_in       (destination_mem),
    .data_in              (data_mem),
    .aluResult_in         (aluResult_mem),
    .memoryReadEnabled_in (memoryReadEnabled_mem),
    .writeBackEnabled_in  (writeBackEnabled_mem),
    .destination          (destination_wb),
    .data                 (data_wb),
    .aluResult            (aluResult_wb),
    .memoryReadEnabled    (memoryReadEnabled_wb),
    .writeBackEnabled     (writeBackEnabled_wb)
    );
    
    WriteBackStage u_WriteBackStage(
    .clk               (clk),
    .rst               (rst),
    .data              (data_wb),
    .aluResult         (aluResult_wb),
    .memoryReadEnabled (memoryReadEnabled_wb),
    .writeBackValue    (writeBackValue_wb)
    );
    
    StatusRegister u_StatusRegister(
    .clk (clk),
    .rst (rst),
    .s   (s_exe),
    .in  (status_in),
    .out (status)
    );
    
    HazardControlUnit u_HazardControlUnit(
    .twoSrc               (twoSrc),
    .src1                 (src1),
    .src2                 (src2),
    .destination_exe      (destination_exe),
    .destination_mem      (destination_mem),
    .writeBackEnabled_exe (writeBackEnabled_exe),
    .writeBackEnabled_mem (writeBackEnabled_mem),
    .hazard               (hazard)
    );
    
endmodule
