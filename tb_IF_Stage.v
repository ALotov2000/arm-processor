
`timescale 1ns / 1ps

module tb_IF_Stage;
    reg clk;
    reg rst;

    wire[31:0] branchAddress, pc, instruction;
    wire branchTaken, freeze, flush;

    IF_Stage if_stage (
        clk, rst, freeze, branchTaken,
        branchAddress,
        pc, instruction,
        flush
    );

    assign branchAddress = 32'b0;
    assign {branchTaken, freeze} = 2'b0;

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        rst = 1'b1;
        #100;
        rst = 1'b0;
        #100;
        $stop;
    end
endmodule
