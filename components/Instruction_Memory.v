
module Instruction_Memory (
    input[31:0] pc,
    output reg[31:0] instruction
);
    always @(pc) begin
        case (pc) 
            32'd0: instruction = 32'b000000_00001_00010_00000_00000000000;
            32'd4: instruction = 32'b000000_00011_00100_00000_00000000000;
            32'd8: instruction = 32'b000000_00101_00110_00000_00000000000;
            32'd12: instruction = 32'b000000_00111_01000_00010_00000000000;
            32'd16: instruction = 32'b000000_01001_01010_00011_00000000000;
            32'd20: instruction = 32'b000000_01011_01100_00000_00000000000;
            32'd24: instruction = 32'b000000_01101_01110_00000_00000000000;
            default: instruction = 32'b0;
        endcase
    end

endmodule