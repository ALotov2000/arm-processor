module PCAdder (in0,
                in1,
                out);
    input[31:0] in0, in1;
    output[31:0] out;
    
    assign out = in0 + in1;
endmodule
