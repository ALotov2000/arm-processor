module ARMModuleTest();
    reg clk, rst;
    
    ARMModule u_ARMModule(
    .clk (clk),
    .rst (rst)
    );
    
    initial begin
        clk             = 0;
        forever begin
            #10 clk = ~clk;
            if (clk) begin
                $display("posedge clk");
            end else begin
                $display("negedge clk");
            end
        end
    end
    
    initial begin
        rst = 1'b0;
        #5;
        rst = 1'b1;
        #20
        rst = 1'b0;
        #10000;
        $stop;
    end
endmodule
