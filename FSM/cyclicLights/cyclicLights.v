module cyclicLights (clk,light);
	input clk;
	output reg [2:0] light;
	reg [1:0] state;
 	parameter S0 = 0, S1 = 1, S2 = 2;
 	parameter RED = 3'b100, YELLOW = 3'b010, GREEN = 3'b001;

	always @(state) begin
		case (state)
			S0 : light = RED;
			S1: light = YELLOW;
			S2 : light = GREEN;
			default : light = RED;
		endcase
	end

	always @ (posedge clk) begin
		case (state)
			S0 : state <= S1;
			S1 : state <= S2;
			S2 : state <= S0;
			default : state <= S0;
		endcase
	end
endmodule

module testbench;
	wire [2:0] light;
	reg clk;
	cyclicLights DUT (clk,light);

  always #5 clk = ~clk;

	initial begin
		clk = 0;
		$dumpfile ("waveform.vcd");
		$dumpvars (0,testbench);
		$monitor ($time," lights = %b",light);
	end

	initial #100 $finish;
endmodule
