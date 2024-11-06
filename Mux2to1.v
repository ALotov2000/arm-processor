module MUX2TO1 #(parameter WIDTH = 32) (
    input [WIDTH-1:0] IN0, IN1,
    input SELECTOR,
    output [WIDTH-1:0] OUT
);
    assign OUT = ~SELECTOR ? IN0 : IN1;
endmodule
