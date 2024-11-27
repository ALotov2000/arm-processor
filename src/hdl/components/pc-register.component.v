
module PCRegister (clk,
                   rst,
                   in,
                   freeze,
                   out);
    input clk, rst;
    input [31:0] in;
    input freeze;
    output reg [31:0] out;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out <= 32'b0;
        end
        else begin
            if (~freeze) begin
                out <= in;
            end
        end
    end
endmodule
