//Full adder sum generation using UDP

primitive faSum (sum,a,b,c);
	input a,b,c;
	output sum;
	table
	// a b c   sum
	   0 0 0 : 0;
		 0 0 1 : 1;
		 0 1 0 : 1;
		 0 1 1 : 0;
		 1 0 0 : 1;
		 1 0 1 : 0;
		 1 1 0 : 0;
		 1 1 1 : 1;
	endtable
endprimitive

module testbench;
	reg a,b,c;
	wire sum;
	faSum DUT (sum,a,b,c);

	initial begin
		$dumpfile ("waveform.vcd");
		$dumpvars (0,testbench);
		$monitor ($time," sum=%b,a=%b,b=%b,c=%b",sum,a,b,c);
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
