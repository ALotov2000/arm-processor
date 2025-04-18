`define EQ 4'b0000 // Equal
`define NE 4'b0001 // Not Equal
`define CS 4'b0010 // Carry Set
`define CC 4'b0011 // Carry Clear
`define MI 4'b0100 // Negative
`define PL 4'b0101 // Positive or Zero
`define VS 4'b0110 // Overflow
`define VC 4'b0111 // No Overflow
`define HI 4'b1000 // Unsigned Higher
`define LS 4'b1001 // Unsigned Lower or Same
`define GE 4'b1010 // Signed Greater or Equal
`define LT 4'b1011 // Signed Less Than
`define GT 4'b1100 // Signed Greater Than
`define LE 4'b1101 // Signed Less Than or Equal
`define AL 4'b1110 // Always

module ConditionCheck(input [3:0] COND,
                      input [3:0] STATUS,
                      output reg RESULT);
    wire N, Z, C, V;
    assign {N, Z, C, V} = STATUS;
    
    always @(COND, N, Z, C, V) begin
        RESULT = 1'b0;
        case (COND)
            `EQ: RESULT     = Z;                  // Equal
            `NE: RESULT     = ~Z;                 // Not Equal
            `CS: RESULT     = C;                  // Carry Set
            `CC: RESULT     = ~C;                 // Carry Clear
            `MI: RESULT     = N;                  // Negative
            `PL: RESULT     = ~N;                 // Positive or Zero
            `VS: RESULT     = V;                  // Overflow
            `VC: RESULT     = ~V;                 // No Overflow
            `HI: RESULT     = C & ~Z;             // UNsigNed Higher
            `LS: RESULT     = ~C | Z;             // UNsigNed Lower or Same
            `GE: RESULT     = (N == V);           // SigNed Greater or Equal
            `LT: RESULT     = (N != V);      // SigNed Less ThaN
            `GT: RESULT     = ~Z & (N == V);      // SigNed Greater ThaN
            `LE: RESULT     = Z | (N != V);  // SigNed Less ThaN or Equal
            `AL: RESULT     = 1'b1;               // Always
        endcase
    end
endmodule
