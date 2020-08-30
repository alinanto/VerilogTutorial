module simpleCounter (clk,rst,count);
  input clk,rst;
  output [7:0] count;
  reg [7:0] count;

  always @ (posedge clk or posedge rst) begin
    if (rst)
      count = 8'b0;
    else
      count = count + 1;
  end
endmodule
