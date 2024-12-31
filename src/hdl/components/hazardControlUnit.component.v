module HazardControlUnit (twoSrc,
                          src1,
                          src2,
                          destination_exe,
                          writeBackEnabled_exe,
                          destination_mem,
                          writeBackEnabled_mem,
                          hazard);
    input twoSrc;
    input [3:0] src1, src2;
    input [3:0] destination_exe, destination_mem;
    input writeBackEnabled_exe, writeBackEnabled_mem;
    
    output reg hazard;
    
    always @(*) begin
        hazard = 1'b0;
        
        $display("hazard control: writeBackEnabled_exe = %b", writeBackEnabled_exe);
        $display("hazard control: writeBackEnabled_mem = %b", writeBackEnabled_mem);
        if (writeBackEnabled_exe) begin
            if (src1 == destination_exe || (twoSrc && src2 == destination_exe)) begin
                hazard = 1'b1;
            end
        end
        
        if (writeBackEnabled_mem) begin
            if (src1 == destination_mem || (twoSrc && src2 == destination_mem)) begin
                hazard = 1'b1;
            end
        end
    end
endmodule
