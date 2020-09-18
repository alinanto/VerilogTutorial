//Full incomplete function generation using UDP
primitive fn (out,a,b,c);
	input a,b,c;
	output out;
	table
	// a b c   out
	   0 0 0 : 0;
		 0 0 1 : 0;
		 0 1 0 : 0;
		 0 1 1 : 0;
		 1 0 0 : 1;
		 1 0 1 : 1;
		 1 1 0 : 1;
	endtable
endprimitive

module testbench;
	reg a,b,c;
	wire out;
	fn DUT (out,a,b,c);

	initial begin
		$dumpfile ("waveform.vcd");
		$dumpvars (0,testbench);
		$monitor ($time," out=%b,a=%b,b=%b,c=%b",out,a,b,c);
		#1 a=0 ; b=0; c=0;
		#1 a=0 ; b=0; c=1;
		#1 a=0 ; b=1; c=0;
		#1 a=0 ; b=1; c=1;
		#1 a=1 ; b=0; c=0;
		#1 a=1 ; b=0; c=1;
		#1 a=1 ; b=1; c=0;
		#1 a=1 ; b=1; c=1;
	end
	initial #1000 $finish;
endmodule
