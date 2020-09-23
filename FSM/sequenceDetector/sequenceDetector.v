module seqDec (z,x,clk,reset);
	input x,clk,reset;
	output reg z;
	reg [1:0] state;
	parameter S0=0,S1=1,S2=2,S3=3;

	always @(posedge clk or posedge reset) begin
		if (reset) state = S0;
		else case (state)
			S0 : begin state = x ? S0 : S1; z = 0; end
			S1 : begin state = x ? S2 : S1; z = 0; end
			S2 : begin state = x ? S3 : S1; z = 0; end
			S3 : begin
				state = x ? S0 : S1;
				if (~x) z = 1;
				else z = 0;
			end
			default : begin state = S0; z = 0; end
		endcase
	end
endmodule

module testbench;
	integer i;
	wire z;
	reg x,clk,reset;
	reg [31:0] constant;
	seqDec DUT (z,x,clk,reset);

	initial begin
		clk = 0;
		reset = 0;
		constant = 32'b01101100111000101101001110101010;
		#1 reset = 1;
		#1 reset = 0;
		for (i=0;i<32;i=i+1)	begin
			x = constant[i]; #10
			$display ($time," : const=%b : i=%2d : x=%b : z = %b",constant,i,x,z);
		end
	end

	always #5 clk = ~clk;

	initial begin
		$dumpfile ("waveform.vcd");
		$dumpvars (0,testbench);
	end

	initial #1000 $finish;
endmodule
