
module InstructionFetchStageReg (input clk,
                                 rst,
                                 input freeze,
                                 flush,
                                 input[31:0] PC_in,
                                 Instruction_in,
                                 output [31:0] PC_out,
                                 Instruction_out);
    RegisterWithFreeze #(2*32) u_Register(
        .clk (clk ),
        .rst (rst ),
        .freeze(freeze),
        .in  ({PC_in, Instruction_in}),
        .out ({PC_out, Instruction_out})
    );
    
endmodule
