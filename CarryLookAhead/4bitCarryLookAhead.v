module adder4bitLookAhead (S,Cout,A,B,Cin);
  input [3:0] A,B;
  input Cin;
  output [3:0]S;
  output Cout;
  wire [3:0] p,g;
  wire [3:1]c;

  assign {p,g} = {A^B,A&B};
  assign c[3:1] = { g[2] | (p[2]&g[1]) | (p[2]&p[1]&g[0]) | (p[2]&p[1]&p[0]&Cin) ,
                    g[1] | (p[1]&g[0]) | (p[1]&p[0]&Cin) ,
                    g[0] | (p[0]&Cin) };
  assign Cout = g[3] | (p[3]&g[2]) | (p[3]&p[2]&g[1]) | (p[3]&p[2]&p[1]&g[0]) | (p[3]&p[2]&p[1]&p[0]&Cin);
  assign S = p^{c[3:1],Cin};
endmodule

module adder4 (S,Cout,A,B,Cin);
  input [3:0] A,B;
  input Cin;
  output [3:0] S;
  output Cout;

  assign {Cout,S} = A+B+Cin;
endmodule

module testbench ;
  reg [3:0] A,B;
  reg Cin;
  wire [3:0] S,SAux;
  wire Cout,CoutAux;
  adder4bitLookAhead DUT(S,Cout,A,B,Cin);
  adder4 AUX(SAux,CoutAux,A,B,Cin);

  initial begin
    $dumpfile("carrylookahead.vcd");
    $dumpvars(0,testbench);
    $monitor($time," A=%b,B=%b,Cin=%b,S=%b,SAux=%b,Cout=%b,CoutAux=%b",A,B,Cin,S,SAux,Cout,CoutAux);
    #1 A = 4'b1111; B = 4'b1111; Cin = 1'b0;
    #1 A = 4'b0001;
    #1 B = 4'b0111;
    #1 A = 4'b1011;
    #1 B = 4'b1100;
    #1 $finish;
  end
endmodule
