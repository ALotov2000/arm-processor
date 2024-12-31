module Memory(clk,
              rst,
              memoryRead,
              memoryWrite,
              address,
              data_in,
              data);
    input clk, rst;
    input memoryRead, memoryWrite;
    input[31:0] address;
    input[31:0] data_in;
    output reg [31:0] data;
    
    reg [31:0] registers[0:63];
    
    reg[5:0] trueAddress;
    
    integer i;
    
    always @(address) begin
        trueAddress = (address - 32'd1024) >> 2;
    end
    
    always @(*) begin
        data = (memoryRead) ? registers[trueAddress] : 32'b0; // zero if not read
    end
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 64; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end
        else if (memoryWrite) begin
            $display("memory component: trueAddress=%d, givenAddress=%d, data_in=%d", trueAddress, address, data_in);
            registers[trueAddress] = data_in;
        end
    end
endmodule
