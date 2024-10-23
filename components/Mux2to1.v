
module Mux2to1(
	input in0, in1,
	input selector,
	output out
);
	assign out = ~selector ? in0 : in1;
endmodule