
module Mux2to1(
	input[31:0] in0, in1,
	input selector,
	output[31:0] out
);
	assign out = ~selector ? in0 : in1;
endmodule