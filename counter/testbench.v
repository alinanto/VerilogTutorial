module testbench;
  wire clk;
  reg rst;
  wire [7:0] count;
  simpleCounter DUT(clk,rst,count);
  clock genclk(clk);

  initial begin
    $dumpfile ("example.vcd");
    $dumpvars (0,testbench);
    $monitor ($time," count = %d, clock = %b, Reset = %b",count,clk,rst);
    rst = 0;
    #1 rst = 1;
    #1 rst = 0;
    #1000 $finish;
  end
endmodule
