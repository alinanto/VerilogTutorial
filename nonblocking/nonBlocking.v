module nonBlocking(clk,in,out);
  input clk;
  input [7:0] in;
  output reg [7:0] out;

  initial out = 8'hFF;

  always @ (posedge clk) begin
    out <= ~out;
    out <= in;
  end
endmodule

module testbench;
  reg clk;
  reg [7:0] in;
  wire [7:0] out;
  nonBlocking DUT(clk,in,out);

  initial begin
    $monitor ($time," out = %b",out);
    clk=0;in=8'hFF;
    forever
      #5 clk = ~clk;
  end
  initial #100 $finish;
endmodule
