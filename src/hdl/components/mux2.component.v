module Mux2 #(parameter N = 32) (
    input [N-1:0] in0, in1,
    input selector,
    output [N-1:0] out
);
    assign out = ~selector ? in0 : in1;
endmodule
