module serialParity(z,x,clk);
	output reg z;
	input x,clk;
	parameter EVEN = 0, ODD = 1;

	always @ (posedge clk) begin
		case (z)
			EVEN : z <= x ? ODD : EVEN;
			ODD : z <= x ? EVEN : ODD;
			default : z <= EVEN;
		endcase
	end
endmodule

module testbench;
	reg x,clk;
	wire z;
	integer i;
	reg [7:0] const;
	serialParity DUT (z,x,clk);

	always #5 clk = ~clk;

	initial begin
		$dumpfile ("waveform.vcd");
		$dumpvars (0,testbench);
		clk = 0;
		const = 8'hBC;
		for (i=0;i<8;i=i+1) begin
			x = const[i]; #10
			if (z == 0) $display ($time,": %b : x = %b, state = EVEN",const,x);
			else $display ($time,": %b : x = %b, state = ODD",const,x);
		end
	  #100 $finish;
	end
endmodule
