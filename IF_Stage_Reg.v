
module IF_Stage_Reg (
    input clk, rst,
    input freeze_in, flush_in,
    input[31:0] PC_in, Instruction_in,
    output reg freeze_out, flush_out,
    output reg[31:0] PC_out, Instruction_out
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            PC_out <= 32'b0;
            Instruction_out <= 32'b0;
            freeze_out <= 1'b0;
            flush_out <= 1'b0;
        end else begin
            PC_out <= PC_in;
            Instruction_out <= Instruction_in;
            freeze_out <= freeze_in;
            flush_out <= flush_in;
        end
    end
endmodule