module testbench;
  reg [7:0] A,B;
  wire [7:0] Wand,Wor,Wxor,Wxnor;
  assign Wand = A & B ;
  assign Wor = A | B ;
  assign Wxor = A ^ B ;
  assign Wxnor = A ~^ B ;
  initial begin
    $dumpfile ("example.vcd");
    $dumpvars (0,testbench);
    $monitor($time," A = %b, B = %b, AND = %b, OR = %b, XOR = %b, XNOR = %b",A,B,Wand,Wor,Wxor,Wxnor);
    #1   A = 8'hFF; B = 8'h0F;
    #1   A = 8'hFF; B = 8'hFF;
    #1   A = 8'h00; B = 8'h0F;
    #1   A = 8'hCC; B = 8'h55;
    #1   A = 8'h55; B = 8'h55;
    $finish;
  end
endmodule
