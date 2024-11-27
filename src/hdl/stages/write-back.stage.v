module WriteBackStage(clk,
                      rst,
                      data,
                      aluResult,
                      memoryReadEnabled,
                      writeBackValue);
    
    input clk, rst;
    input [31:0] data, aluResult;
    input memoryReadEnabled;
    output [31:0] writeBackValue;
    
    Mux2 u_Mux2(
    .in0      (aluResult),
    .in1      (data),
    .selector (memoryReadEnabled),
    .out      (writeBackValue)
    );
    
endmodule
