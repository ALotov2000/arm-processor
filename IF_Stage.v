module IF_Stage (
	input clk, rst, freeze, Branch_taken,
	input[31:0] BranchAddr,
	output[31:0] PC, Instruction
);

	wire[31:0] PC_next, PC_current;

	Mux2to1 pc_mux (
		.in0(PC),
		.in1(BranchAddr),
		.selector(Branch_taken),
		.out(PC_next)
	);
	
	PC_Reg pc_reg(
		.clk(clk), .rst(rst),
		.in(PC_next),
		.freeze(freeze),
		.out(PC_current)
	);

	PC_Adder pc_addr(
		.in0(32'd4),
		.in1(PC_current),
		.out(PC)
	);

	Instruction_Memory ins_mem(
		.pc(PC_current),
		.instruction(Instruction)
	);

	
	assign Branch_taken = 1'b0;
	assign freeze = 1'b0;
	assign BranchAddr = 32'b0;
endmodule