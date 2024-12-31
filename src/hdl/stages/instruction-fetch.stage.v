module InstructionFetchStage (clk,
                              rst,
                              freeze,
                              Branch_taken,
                              BranchAddr,
                              PC,
                              Instruction);
    
    input clk, rst;
    input freeze, Branch_taken;
    input[31:0] BranchAddr;
    output[31:0] PC, Instruction;
    
    wire[31:0] PC_next, PC_current;
    
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

    always @(posedge clk) begin
        if (~rst) begin
            $display("instruction fetch stage: PC_current=%b", PC_current);
            $display("instruction fetch stage: PC=%b", PC);
            $display("instruction fetch stage: PC_next=%b", PC_next);
            $display("instruction fetch stage: Branch_Taken=%b", Branch_taken);
        end
    end
endmodule
