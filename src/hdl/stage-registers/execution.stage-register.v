module ExecutionStageReg(clk,
                         rst,
                         writebackEnabledIn,
                         memoryReadEnabledIn,
                         memoryWriteEnabledIn,
                         aluResultIn,
                         valRmIn,
                         destinationIn,
                         writebackEnabled,
                         memoryReadEnabled,
                         memoryWriteEnabled,
                         aluResult,
                         valRm,
                         destination);
    input clk, rst;
    input writebackEnabledIn, memoryReadEnabledIn, memoryWriteEnabledIn;
    input[31:0] aluResultIn, valRmIn;
    input[3:0] destinationIn;
    
    output writebackEnabled, memoryReadEnabled, memoryWriteEnabled;
    output[31:0] aluResult, valRm;
    output[3:0] destination;
    
    Register #(1) writebackEnabledReg(
    clk, rst,
    writebackEnabledIn,
    writebackEnabled
    );
    
    Register #(1) memoryReadEnabledReg(
    clk, rst,
    memoryReadEnabledIn,
    memoryReadEnabled
    );
    
    Register #(1) memoryWriteEnabledReg(
    clk, rst,
    memoryWriteEnabledIn,
    memoryWriteEnabled
    );
    
    Register #(32) aluResultReg(
    clk, rst,
    aluResultIn,
    aluResult
    );
    
    Register #(32) valRmReg(
    clk, rst,
    valRmIn,
    valRm
    );
    
    Register #(4) destinationReg(
    clk, rst,
    destinationIn,
    destination
    );
endmodule
