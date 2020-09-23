module serialParity(O,D,clk);
	output reg O;
	input D,clk;
	parameter EVEN = 0, ODD = 1;

	always @ (posedge clk) begin
		case (O)
			EVEN : O <= D ? ODD : EVEN;
			ODD : O <= D ? EVEN : ODD;
			default : O <= EVEN;
		endcase
	end
endmodule

module testbench;
	reg D,clk;
	wire O;
	integer i;
	serialParity DUT (O,D,clk);

	always #5 clk = ~clk;

	initial begin
		$dumpfile ("waveform.vcd");
		$dumpvars (0,testbench);
		clk = 0;
		
		begin
			$display ("error"); #10
		end
	  #100 $finish;
	end
endmodule
