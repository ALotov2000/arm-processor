module NegRegister #(parameter N)
                    (clk,
                     rst,
                     ld,
                     in,
                     out);
    
    input clk, rst;
    input ld;
    input[N-1:0] in;
    output reg[N-1:0] out;
    
    
    always @(negedge clk or posedge rst) begin
        if (rst) begin
            out <= {N{1'b0}};
        end
        else if(ld) begin
            out <= in;
        end
    end
endmodule
