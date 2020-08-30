module testbench;
  reg [15:0] I;
  reg [3:0] S;
  wire O;

  mux16to1 DUT(I,S,O);
  initial begin
    $dumpfile("example.vcd");
    $dumpvars(0,testbench);
    $monitor($time," I = %b, S = %d, O = %b", I,S,O);
    #1 I = 16'h3F0A; S = 4'h0;
    repeat (15) #1 S = S + 1;
    #1 $finish;
  end
endmodule
