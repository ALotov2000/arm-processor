
module PC_Reg (
	input clk, rst,
	input [31:0] in, 
	input freeze,
	output reg [31:0] out
);
	always @(negedge clk or posedge rst) begin
        if (rst) begin
            out <= 32'b0;
        end else begin
            out <= in; 
        end
    end
endmodule