//behavioural description of Serial Adder
/*
module serialAdder(S,Cout,A,B,clk,reset);
	input A,B,clk,reset;
	output reg S,Cout;

	always @ (posedge clk , posedge reset) begin
		if (reset) begin
			Cout <= 0;
			S <= 0;
		end
		else {Cout,S} <= A+B+Cout;
	end
endmodule
*/

//mealy state diagram for a serial serialAdder
module serialAdder(S,Cout,A,B,clk,reset);
	input A,B,clk,reset;
	output reg S,Cout;

	always @ (posedge clk , posedge reset) begin
	if (reset) begin
		Cout <= 0;
		S <= 0;
	end
	else
		case (Cout)
			0 : case ({A,B})
						2'b00 : begin Cout <= 0; S <= 0; end
						2'b01 : begin Cout <= 0; S <= 1; end
						2'b10 : begin Cout <= 0; S <= 1; end
						2'b11 : begin Cout <= 1; S <= 0; end
						default : begin Cout <= 0; S <= 0; end
					endcase
			1 : case ({A,B})
			 			2'b00 : begin Cout <= 0; S <= 1; end
						2'b01 : begin Cout <= 1; S <= 0; end
						2'b10 : begin Cout <= 1; S <= 0; end
						2'b11 : begin Cout <= 1; S <= 1; end
						default : begin Cout <= 0; S <= 0; end
					endcase
			default : begin Cout <= 0; S <= 0; end
		endcase
	end
endmodule

module testbench;
	reg A,B,clk,reset;
	wire S,Cout;
	reg [7:0] inputA = 8'b00100110;
	reg [7:0] inputB = 8'b10111011;
	integer i;
	serialAdder DUT (S,Cout,A,B,clk,reset);

 	always #5 clk = ~clk;

	initial begin
		$dumpfile ("waveform.vcd");
		$dumpvars (0,testbench);
		clk=0;
		reset=0;
		#1 reset=1;
		#1 reset=0;
		$display("InputA=%b",inputA);
		$display("InputB=%b",inputB);
		$display("------------------------");
		for (i=0;i<8;i=i+1) begin
			A = inputA[i];
			B = inputB[i];
			#10 $display ("time = %2d : i= %1d : A=%b : B=%b : S=%b : Cout=%b",$time,i,A,B,S,Cout);
		end
	end
	initial #100 $finish;
endmodule
