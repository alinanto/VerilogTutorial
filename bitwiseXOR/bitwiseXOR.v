module bitwiseXOR (f,a,b);
	parameter N = 16;
	input [N-1:0] a,b;
	output [N-1:0] f;
	genvar p;

	generate for (p=0;p<N;p=p+1)
		begin : xorloop
			xor G (f[p],a[p],b[p]);
		end
	endgenerate
endmodule

module testbench;
	parameter N = 16;
	reg [N-1:0] a,b;
	wire [N-1:0] f;
	bitwiseXOR DUT (f,a,b);

	initial begin
		$dumpfile ("waveform.vcd");
		$dumpvars (0,testbench);
		$monitor ($time," a=%b,b=%b,f=%b",a,b,f);
		a=16'hAAAA; b=16'h00FF;
		#10 a=16'h0F0F; b=16'h3333;
	end
	initial #25 $finish;
endmodule
