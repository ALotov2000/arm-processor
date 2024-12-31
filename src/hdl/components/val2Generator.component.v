`define LSL 2'b00
`define LSR 2'b01
`define ASR 2'b10
`define ROR 2'b11

module Val2Generator(valRm,
                     shiftOperand,
                     imm,
                     memoryInstruction,
                     val2);
    
    input [31:0] valRm;
    input [11:0] shiftOperand;
    input imm;
    input memoryInstruction;
    output [31:0] val2;
    
    
    reg [31:0] immediate32bit;
    reg [31:0] rotatedValRm;
    
    integer i = 0;
    
    wire [4:0] shiftImmediate;
    wire [3:0] rotateImmediate;
    wire [1:0] shift;
    wire [7:0] immediate8bit;
    
    assign shiftImmediate  = shiftOperand[11:7];
    assign rotateImmediate = shiftOperand[11:8];
    assign shift           = shiftOperand[6:5];
    assign immediate8bit   = shiftOperand[7:0];
    
    assign val2 = (memoryInstruction == 1'b1)  ? { {20{shiftOperand[11]}}, shiftOperand} :
    (imm == 1'b1) ? immediate32bit :
    (shift == `LSL) ? valRm <<  {shiftImmediate} :
    (shift == `LSR) ? valRm >>  {shiftImmediate} :
    (shift == `ASR) ? valRm >>> {shiftImmediate} :
    rotatedValRm; // shift == `ROR  
    
    always@(*) begin
        
        immediate32bit = {24'b0, immediate8bit};
        
        for(i = 0; i < rotateImmediate; i = i + 1) begin
            immediate32bit = {immediate32bit[1:0], immediate32bit[31:2]};
        end
        
        rotatedValRm = valRm;
        
        for(i = 0; i <= shiftOperand[11:7]; i = i + 1) begin
            rotatedValRm = {rotatedValRm[0], rotatedValRm[31:1]};
        end
    end
endmodule
