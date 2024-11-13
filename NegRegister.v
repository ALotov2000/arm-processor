module NegRegister #(parameter WIDTH) (
    clk, rst,
    in,
    out
);

    input clk, rst;
    input[WIDTH-1:0] in;
    output[WIDTH-1:0] out;


    always @(negedge clk or posedge rst) begin
        if (rst) begin
            out <= {WIDTH{1'b0}};
        end
        else begin
            out <= in;
        end
    end
endmodule