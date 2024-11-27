module RegisterFile(input clk,
                    rst,
                    input [3:0] SRC1,
                    SRC2,
                    DEST_WB,
                    input [31:0] RESULT_WB,
                    input WB_EN,
                    output [31:0] REG1,
                    REG2);

    reg [31:0] REGISTERS [0:15];
    integer i;
    
    assign REG1 = REGISTERS[SRC1];
    assign REG2 = REGISTERS[SRC2];
    
    always @(negedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 16; i = i + 1)
                REGISTERS[i] = 32'b0;
                end else if (WB_EN) begin
                REGISTERS[DEST_WB] = RESULT_WB;
        end
    end
endmodule
