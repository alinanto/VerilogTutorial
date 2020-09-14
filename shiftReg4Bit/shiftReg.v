module shiftReg4bit (clk,clear,A,out);
  input clk,clear,A;
  output reg out;
  reg B,C,D;

  always @(posedge clk or negedge clear) begin
    if(!clear) begin
      B=0;C=0;D=0;out=0;
    end
    else begin
      //out=D;D=C;C=B;B=A; order matters
      B<=A;C<=B;D<=C;out<=D; //orfer does not matter
    end
  end
endmodule

module testbench;
  reg clk,clear,A;
  wire out;
  shiftReg4bit DUT(clk,clear,A,out);

  initial begin
    $dumpfile("example.vcd");
    $dumpvars(0,testbench);
    $monitor($time," A = %b, out = %b, clk =%b, clear = %b",A,out,clk,clear);
    clear=1;clk=0;A=0;
    #1 clear=0;
    #1 clear=1;
    forever
      #5 clk = ~clk;
  end
  initial forever #10 A = ~A;
  initial #1000 $finish;
endmodule
