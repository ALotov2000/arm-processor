module ExecutionStage(clk,
                      executionCommand,
                      memoryReadEnabled,
                      memoryWriteEnabled,
                      pc,
                      valRn,
                      valRm,
                      imm,
                      shiftOperand,
                      imm24,
                      status,
                      aluResult,
                      branchAddress,
                      statusOut);
    
    input clk;
    input [3:0] executionCommand;
    input memoryReadEnabled, memoryWriteEnabled;
    input [31:0] pc;
    input [31:0] valRn, valRm;
    input imm;
    input [11:0] shiftOperand;
    input [23:0] imm24;
    input [3:0] status;
    
    output [31:0] aluResult, branchAddress;
    output [3:0] statusOut;
    
    wire memoryInstruction;
    wire[31:0] val1, val2;
    wire carryIn;
    
    assign val1    = valRn;
    assign carryIn = status[1];
    
    assign memoryInstruction = memoryReadEnabled | memoryWriteEnabled;
    
    assign branchAddress = pc + {8'b0, imm24};
    
    Val2Generator val2Generator (
    valRm,
    shiftOperand,
    imm,
    memoryInstruction,
    val2
    );
    
    ALU alu(
    val1, val2,
    executionCommand,
    carryIn,
    aluResult,
    statusOut
    );
endmodule
