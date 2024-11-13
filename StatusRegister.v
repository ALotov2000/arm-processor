module StatusRegister(
    clk, rst,
    in,
    out
);

    input clk, rst;
    input[3:0] in;
    output[3:0] out;


    NegRegister #(4) reg (
        clk, rst,
        in,
        out
    );

endmodule