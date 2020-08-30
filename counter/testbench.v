module testbench;
  reg clk,rst;
  wire [7:0] count;
  simpleCounter DUT(clk,rst,count);

  initial begin
    $dumpfile ("example.vcd");
    $dumpvars (0,testbench);
    $monitor ($time," count = %b, clock = %b, Reset = %b",count,clk,rst);
    rst = 0;
    clk = 0;
    #1 rst = 1;
    #1 rst = 0;
    repeat (1000) begin
      #1 clk = ~clk;
    end
    #1 $finish;
  end
endmodule
