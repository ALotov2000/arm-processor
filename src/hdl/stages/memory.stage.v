module MemoryStage(clk,
                   rst,
                   memoryReadEnabled,
                   memoryWriteEnabled,
                   aluResult,
                   valRm,
                   data);
    input clk, rst;
    input memoryReadEnabled, memoryWriteEnabled;
    input [31:0] aluResult, valRm;
    
    output [31:0] data;
    
    Memory u_Memory(
    .clk         (clk),
    .rst         (rst),
    .memoryRead  (memoryReadEnabled),
    .memoryWrite (memoryWriteEnabled),
    .address     (aluResult),
    .data_in     (valRm),
    .data        (data)
    );
    
    
endmodule
