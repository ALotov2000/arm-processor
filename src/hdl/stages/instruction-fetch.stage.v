module InstructionFetchStage (input clk,
                              rst,
                              freeze,
                              Branch_taken,
                              input[31:0] BranchAddr,
                              output[31:0] PC,
                              Instruction,
                              output flush);
    
    wire[31:0] PC_next, PC_current;
    
    assign flush = Branch_taken;
    
    Mux2 #(32) pc_mux (
    .in0(PC),
    .in1(BranchAddr),
    .selector(Branch_taken),
    .out(PC_next)
    );
    
    PCRegister pc_reg(
    .clk(clk), .rst(rst),
    .in(PC_next),
    .freeze(freeze),
    .out(PC_current)
    );
    
    PCAdder pc_addr(
    .in0(32'd4),
    .in1(PC_current),
    .out(PC)
    );
    
    InstructionMemory ins_mem(
    .pc(PC_current),
    .instruction(Instruction)
    );
endmodule
