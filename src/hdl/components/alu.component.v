module ALU (val1,
            val2,
            executionCommand,
            carryIn,
            aluResult,
            statusOut);
    
    input[31:0] val1, val2;
    input[3:0] executionCommand;
    input carryIn;
    output reg[31:0] aluResult;
    output[3:0] statusOut;
    
    reg c;
    reg v;
    wire z;
    wire n;
    
    always @(*) begin
        aluResult = 0;
        c = 1'b0;
        v = 1'b0;
        
        case (executionCommand)
            4'b0001:
            aluResult = val2;
            4'b1001:
            aluResult = ~ val2;
            4'b0010:
            {c, aluResult} = val1 +  val2;
            4'b0011:
            {c, aluResult} = val1 +  val2 + carryIn;
            4'b0100:
            {c, aluResult} = val1 -  val2;
            4'b0101:
            {c, aluResult} = val1 -  val2 - carryIn;
            4'b0110:
            aluResult = val1 &  val2;
            4'b0111:
            aluResult = val1 |  val2;
            4'b1000:
            aluResult = val1 ^  val2;
            4'b0100:
            aluResult = val1 -  val2;
            4'b0110:
            aluResult = val1 &  val2;
            4'b0010:
            aluResult = val1 +  val2;
            4'b0010:
            aluResult = val1 +  val2;
        endcase
        
        if (executionCommand == 4'b0010 || executionCommand == 4'b0011)
            v = (val1[31] == val2[31]) & (val1[31] == ~aluResult[31]);
        
        else if (executionCommand == 4'b0100 || executionCommand == 4'b0101)
        v = (val1[31] == ~ val2[31]) & (val1[31] == ~aluResult[31]);
    end
    
    assign n = aluResult[31];
    assign z = aluResult == 32'b0 ? 1'b1 : 1'b0;
    
    assign statusOut = {n, z, c, v};
endmodule
