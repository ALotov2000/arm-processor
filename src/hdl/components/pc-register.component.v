
module PCRegister (clk,
                   rst,
                   in,
                   freeze,
                   out);
    input clk, rst;
    input [31:0] in;
    input freeze;
    output [31:0] out;
    
    RegisterWithFreezeAndFlush #(32) u_RegisterWithFreezeAndFlush(
    .clk    (clk),
    .rst    (rst),
    .freeze (freeze),
    .flush  (1'b0),
    .in     (in),
    .out    (out)
    );

    always @(out) begin
        $display("pc register: freeze = %b", freeze);
        $display("pc register: in = %h", in);
        $display("pc register: out = %h", out);
    end
    
endmodule
