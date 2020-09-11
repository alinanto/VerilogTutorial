module ring_counter (clk,init,count);
  input clk,init;
  output reg [7:0] count;

  always @ (posedge clk,posedge init) begin
    if (init) count = 8'b10000000;
    else begin
      count <= count<<1;
      count[0] <= count[7];   //equalent to count = {count[6:0],count[7]};
    end
  end
endmodule

module testbench;
  reg clk,init;
  wire [7:0] count;
  ring_counter DUT(clk,init,count);

  initial begin
    $dumpfile ("example.vcd");
    $dumpvars (0,testbench);
    $monitor ($time," count = %b",count);
    clk=0;init=0;
    #1 init=1;
    #1 init=0;
    forever
      #5 clk = ~clk;
  end
  initial begin
    #100 $finish;
  end
endmodule
