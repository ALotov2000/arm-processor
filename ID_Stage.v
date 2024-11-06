module ID_Stage(
	input clk, rst,
	input [31:0] PC_in, Instruction_in,
	output WB_EN, MEM_R_EN, MEM_W_EN, EXE_CMD, B, S, Val_Rn, Val_Rm, Shift_operand, imm, Signed_imm_24, Dest,
	output[31:0] PC
);

endmodule