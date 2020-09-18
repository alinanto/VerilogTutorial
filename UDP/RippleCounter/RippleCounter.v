//toggling flipflip on neg edge
primitive TFF(q,clk,clear);
	input clk,clear;
	output q;
	reg q;

	initial q=0;  //optional

	table
	// clk clear : q : q_new
	    ?    1   : ? : 0;
			?    *   : ? : -;
	   (10)  0   : 1 : 0;
		 (10)  0   : 0 : 1;
		 (01)  0   : ? : -;
		 endtable
endprimitive

module RippleCounter(count,clk,clear);
	parameter N=12;
	output [N-1:0] count;
	input clk,clear;
	wire [N:0] clock;

	assign clock[0] = clk;
	assign count = clock[N:1];

	genvar i;
	generate for (i=0;i<N;i=i+1)
		TFF FF (clock[i+1],clock[i],clear);
	endgenerate
endmodule

module testbench;
	parameter N=12;
	reg clk,clear;
	wire [N-1:0] count;
	RippleCounter DUT (count,clk,clear);

	initial begin
		$dumpfile ("waveform.vcd");
		$dumpvars (0,testbench);
		$monitor ($time," out=%b",count);
		clear=0; clk=0;
		#1 clear = 1;
		#1 clear = 0;
		forever
			#5 clk = ~clk;
	end
	initial #10000 $finish;
endmodule
