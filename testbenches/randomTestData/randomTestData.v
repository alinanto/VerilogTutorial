//Behavioural description of adder
module ParallelAdder (sum,cout,in1,in2,cin);
    parameter N=16;  // for 32 bit adder
    input [N-1:0] in1,in2;
    input cin;
    output [N-1:0] sum;
    output cout;
    assign {cout,sum} = in1 +in2 + cin ;
endmodule

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
	parameter N = 16;  // for 32 bit Ripple Carry Adder
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
	parameter N=16;
	reg [N-1:0] A,B;
	reg Cin;
	wire [N-1:0] S,S_compare;
	wire Cout,Cout_compare;
	integer i;

	RCAdder DUT (S,Cout,A,B,Cin);
	ParallelAdder DFC (S_compare,Cout_compare,A,B,Cin);

	initial begin
		$dumpfile ("waveform.vcd");
		$dumpvars (0,testbench);
		A=32'h00000000;
		B=32'h00000000;
		Cin=1'b0;
	end

	initial begin
		for (i=0;i<10;i=i+1) begin
		 	A = $random; B = $random; Cin = $random; #5
		 	if ( (S == S_compare) && (Cout == Cout_compare) ) begin
				$display ("Test ok.(Time=%2d)",$time);
				$display ("A   = %H Cin=%b",A,Cin);
				$display ("B   = %H",B);
				$display ("--------------------------");
				$display ("S   = %H  Cout  =%b",S,Cout);
				$display ("S_c = %H  Cout_c=%b",S_compare,Cout_compare);
				$display ("\n");
			end
		end
		#5 $finish;
	end
endmodule
