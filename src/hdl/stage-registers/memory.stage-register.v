
module MemoryStageReg (clk,
                       rst,
                       destination_in,
                       data_in,
                       aluResult_in,
                       memoryReadEnabled_in,
                       writeBackEnabled_in,
                       destination,
                       data,
                       aluResult,
                       memoryReadEnabled,
                       writeBackEnabled);
    
    input clk, rst;
    input[3:0] destination_in;
    input[31:0] data_in, aluResult_in;
    input memoryReadEnabled_in, writeBackEnabled_in;
    
    output [3:0] destination;
    output [31:0] data, aluResult;
    output memoryReadEnabled, writeBackEnabled;
    
    Register #(1*4 + 2*32 + 2*1) register (
    .clk (clk),
    .rst (rst),
    .in  ({
    destination_in,
    data_in,
    aluResult_in,
    memoryReadEnabled_in,
    writeBackEnabled_in
    }),
    .out ({
    destination,
    data,
    aluResult,
    memoryReadEnabled,
    writeBackEnabled
    })
    );
endmodule
