`define MOV_ALU 4'b0001
`define MVN_ALU 4'b1001
`define ADD_ALU 4'b0010
`define ADC_ALU 4'b0011
`define SUB_ALU 4'b0100
`define SBC_ALU 4'b0101
`define AND_ALU 4'b0110
`define ORR_ALU 4'b0111
`define EOR_ALU 4'b1000
`define CMP_ALU 4'b0100
`define TST_ALU 4'b0110
`define LDR_ALU 4'b0010
`define STR_ALU 4'b0010


`define MOV 4'b1101
`define MVN 4'b1111
`define ADD 4'b0100
`define ADC 4'b0101
`define SUB 4'b0010
`define SBC 4'b0110
`define AND 4'b0000
`define ORR 4'b1100
`define EOR 4'b0001
`define CMP 4'b1010
`define TST 4'b1000
`define LDR 4'b0100
`define STR 4'b0100

`define ARITHMATIC_INS_TYPE  2'b00
`define MEM_INS_TYPE  2'b01
`define BRANCH_INS_TYPE  2'b10
`define CO_PROC_INS_TYPE  2'b11

`define WRITE 1'b1
`define LOAD 1'b0

module ControlUnit(input [3:0] OPCODE,
                   input [1:0] MODE,
                   input S_IN,
                   output reg [3:0] EXE_CMD,
                   output reg S,
                   B,
                   MEM_W_EN,
                   MEM_R_EN,
                   WB_EN);
    
    always @(*) begin
        S        = S_IN;
        B        = 0;
        MEM_W_EN = 0;
        MEM_R_EN = 0;
        WB_EN    = 0;
        EXE_CMD  = 4'b0000;
        
        case (MODE)
            `ARITHMATIC_INS_TYPE: begin
                case (OPCODE)
                    `MOV: begin
                        WB_EN   = 1;
                        EXE_CMD = `MOV_ALU;
                    end
                    `MVN: begin
                        WB_EN   = 1;
                        EXE_CMD = `MVN_ALU;
                    end
                    `ADD: begin
                        WB_EN   = 1;
                        EXE_CMD = `ADD_ALU;
                    end
                    `ADC: begin
                        WB_EN   = 1;
                        EXE_CMD = `ADC_ALU;
                    end
                    `SUB: begin
                        WB_EN   = 1;
                        EXE_CMD = `SUB_ALU;
                    end
                    `SBC: begin
                        WB_EN   = 1;
                        EXE_CMD = `SBC_ALU;
                    end
                    `AND: begin
                        WB_EN   = 1;
                        EXE_CMD = `AND_ALU;
                    end
                    `ORR: begin
                        WB_EN   = 1;
                        EXE_CMD = `ORR_ALU;
                    end
                    `EOR: begin
                        WB_EN   = 1;
                        EXE_CMD = `EOR_ALU;
                    end
                    `CMP: begin
                        EXE_CMD = `CMP_ALU;
                    end
                    `TST: begin
                        EXE_CMD = `TST_ALU;
                    end
                endcase
            end
            `MEM_INS_TYPE: begin
                case (S_IN)
                    `LOAD: begin
                        MEM_R_EN = 1;
                        EXE_CMD  = `LDR_ALU;
                        WB_EN    = 1;
                    end
                    `WRITE: begin
                        MEM_W_EN = 1;
                        EXE_CMD  = `STR_ALU;
                    end
                endcase
            end
            `BRANCH_INS_TYPE: begin
                B = 1;
            end
        endcase
    end
    
endmodule
