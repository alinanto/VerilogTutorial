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

module testbench;
	reg A,B,Cin;
	wire S,Cout;
	integer i;
	fullAdder DUT (S,Cout,A,B,Cin);

	initial begin
		$dumpfile ("waveform.vcd");
		$dumpvars (0,testbench);
		for (i=0;i<8;i=i+1) begin
			{A,B,Cin} = i;
			#5 $display ("Time=%2d A=%b B=%b Cin=%b S=%b Cout=%b",$time,A,B,Cin,S,Cout);
		end
		#5 $finish;
	end
endmodule
