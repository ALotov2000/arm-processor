
`timescale 1ns / 1ps

module tb_EXE_Stage;
    reg clk;
    reg rst;

    wire[31:0] branchAddress_if, pc_if, instruction_if;
    wire branchTaken_if, freeze_if, flush_if;

    wire[31:0] pc_id, instruction_id, valRn_id, valRm_id;
    wire[23:0] imm24_id;
    wire[11:0] shiftOperand_id;
    wire[3:0] status_id, executionCommand_id, destination_id, src1_id, src2_id;
    wire flush_id, hazard_id, writebackEnabled_id, memoryReadEnabled_id, memoryWriteEnabled_id, b_id, s_id, imm_id, twoSrc_id;

    wire[31:0] writebackValue_wb;
    wire[3:0] writebackDestination_wb;
    wire writebackEnabled_wb;

    assign {
        branchAddress_if,
        branchTaken_if,
        freeze_if,

        hazard_id,
        status_id,

        writebackDestination_wb,
        writebackEnabled_wb,
        writebackValue_wb
        } = 0; // initialization

    IF_Stage if_stage (
        clk, rst,
        freeze_if, branchTaken_if,
        branchAddress_if,

        pc_if, instruction_if,
        flush_if
    );

    IF_Stage_Reg if_stage_reg (
        clk, rst,
        freeze_if, flush_if,
        pc_if, instruction_if,

        freeze_id, flush_id,
        pc_id, instruction_id
    );

    ID_STAGE id_stage(
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
	    shiftOperand_id,
	    imm_id,
	    imm24_id,
	    destination_id,
	    src1_id, src2_id,
        twoSrc_id
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        rst = 1'b1;
        #100;
        rst = 1'b0;
        #300;
        $stop;
    end
endmodule
