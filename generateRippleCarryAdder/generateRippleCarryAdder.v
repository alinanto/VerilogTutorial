//Structural description of a fullAdder
module fullAdder (S,Cout,A,B,Cin);
  input A,B,Cin;
  output S,Cout;
  wire s1,c1,c2;

  xor G1 (s1,A,B),
      G2 (S,s1,Cin),
      G3 (Cout,c2,c1);
  and G4 (c1,A,B),
      G5 (c2,s1,Cin);
endmodule

module RCAdder(S,Cout,A,B,Cin);
	parameter N = 8;
	input [N-1:0] A,B;
	input Cin;
	output [N-1:0] S;
	output Cout;
	wire [N:0] carry;

	assign carry[0] = Cin;
	assign Cout = carry[N];

	genvar i;
	generate for (i=0;i<N;i=i+1)
		begin : FAloop
			fullAdder FA (S[i],carry[i+1],A[i],B[i],carry[i]);
		end
	endgenerate
endmodule

module testbench;
	parameter N = 8;
	reg [N-1:0] A,B;
	reg Cin;
	wire [N-1:0] S;
	wire Cout;
	RCAdder DUT (S,Cout,A,B,Cin);

	initial begin
		$dumpfile ("waveform.vcd");
		$dumpvars (0,testbench);
		$monitor ($time," S=%b,Cout=%b,A=%b,B=%b,Cin=%b",S,Cout,A,B,Cin);
		A = 8'h05; B = 8'h03; Cin = 0;
		#5	A = 8'h0F; B = 8'h00; Cin = 1;
		#5  A = 8'h05; B = 8'h0A; Cin = 1;
		#5  A = 8'hF0; B = 8'h0F; Cin = 1;
	end
	initial #25 $finish;
endmodule
