module ConditionCheck(
    input [3:0] cond,
    input [3:0] status,
    output reg result
);
    wire n, z, c, v;
    assign {n, z, c, v} = status;

    always @(cond, n, z, c, v) begin
        result = 1'b0;
        case (cond)
            4'b0000: result = z;             
            4'b0001: result = ~z;            
            4'b0010: result = c;             
            4'b0011: result = ~c;            
            4'b0100: result = n;             
            4'b0101: result = ~n;            
            4'b0110: result = v;             
            4'b0111: result = ~v;            
            4'b1000: result = c & ~z;        
            4'b1001: result = ~c | z;        
            4'b1010: result = (n == v);      
            4'b1011: result = (n != v);      
            4'b1100: result = ~z & (n == v); 
            4'b1101: result = z & (n != v);  
            4'b1110: result = 1'b1;          
            default: result = 1'b0;
        endcase
    end
endmodule