module StatusRegister(clk,
                      rst,
                      s,
                      in,
                      out);
    
    input clk, rst;
    input s;
    input[3:0] in;
    output[3:0] out;
    
    
    NegRegister #(4) negRegister (
    .clk(clk),
    .rst(rst),
    .ld(s),
    .in(in),
    .out(out)
    );
    
endmodule
