module Register #(parameter WIDTH = 32)
                 (clk,
                  rst,
                  in,
                  out);
    input clk, rst;
    input[WIDTH-1:0] in;
    output reg[WIDTH-1:0] out;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out <= {WIDTH{1'b0}};
        end
        else begin
            out <= in;
        end
    end
    
endmodule
