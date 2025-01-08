module ARMModuleTest ();
  reg clk, rst;
  reg forwardingEnabled;

  wire [17:0] addr;
  wire [15:0] data;
  wire we;

  SRAM u_SRAM (
      .clk (clk),
      .addr(addr),
      .we  (we),
      .data(data)
  );


  ARMModule u_ARMModule (
      .clk              (clk),
      .rst              (rst),
      .forwardingEnabled(forwardingEnabled),
      .SRAMData         (data),
      .SRAMAddress      (addr),
      .SRAMUB           (),
      .SRAMLB           (),
      .SRAMOE           (),
      .SRAMCE           (),
      .SRAMWE           (we)
  );


  initial begin
    clk = 0;
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
    forwardingEnabled = 1'b1;
    #5;
    rst = 1'b1;
    #20 rst = 1'b0;
    #10000;
    $stop;
  end
endmodule
