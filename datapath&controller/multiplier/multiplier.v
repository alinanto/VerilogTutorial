module multiplier_datapath (eqz,dataBus,LdA,LdB,LdP,clrP,decB,clk);
	input [15:0] dataBus;
	input LdA,LdB,LdP,clrP,decB,clk;
	output eqz;
	wire [15:0] Aout,Pout,Sum,Bout;

	PIPOreg A (Aout,dataBus,LdA,1'b0,1'b0,clk);
	PIPOreg B (Bout,dataBus,LdB,decB,1'b0,clk);
	PIPOreg P (Pout,Sum,LdP,1'b0,clrP,clk);
	ADDER add (Sum,Aout,Pout);
	EQZ comp (eqz,Bout);
endmodule

module PIPOreg (out,in,Ld,dec,clr,clk);
	input [15:0] in;
	input Ld,dec,clr,clk;
	output reg [15:0] out;

	always @ (negedge clk)
		if (Ld) out <= in;
		else if (dec) out <= out-1;
		else if (clr) out <= 16'b0;
endmodule

module ADDER (Sum,A,B);
	input [15:0] A,B;
	output [15:0] Sum;

	assign Sum = A+B;
endmodule

module EQZ (eqz,in);
	input [15:0] in;
	output eqz;

	assign eqz = (in==0);
endmodule

module multiplier_controller (LdA,LdB,LdP,clrP,decB,done,eqz,start,clk);
	input eqz,start,clk;
	output reg LdA,LdB,LdP,clrP,decB,done;
	reg [2:0] state;
	parameter S0=0,S1=1,S2=2,S3=3,S4=4;

	always @ (posedge clk) case (state)
		S0 : if (start) state <= S1;
		S1 : state <= S2;
		S2 : state <= S3;
		S3 : if (eqz) state <= S4;
		S4 : state <= S4;
		default : state <= S0;
 	endcase

	always @ (state) case (state)
		S0: begin LdA=0;LdB=0;LdP=0;clrP=0;decB=0;done=0; end
		S1: LdA=1;
		S2: begin LdA=0;LdB=1;clrP=1; end
		S3: begin LdB=0;LdP=1;clrP=0;decB=1; end
		S4: begin LdP=0;decB=0;done=1; end
		default : begin LdA=0;LdB=0;LdP=0;clrP=0;decB=0;done=0; end
	endcase
endmodule

module testbench;
	reg [15:0] dataBus;
	reg clk,start;
	wire LdA,LdB,LdP,clrP,decB,done,eqz;
	multiplier_controller MC (LdA,LdB,LdP,clrP,decB,done,eqz,start,clk);
	multiplier_datapath MD (eqz,dataBus,LdA,LdB,LdP,clrP,decB,clk);

	always #5 clk = ~clk;
	always #5 if (done) $finish;

	initial begin
		$dumpfile ("waveform.vcd");
		$dumpvars (0,testbench);
		$monitor ($time," product = %2d, done = %b",MD.Pout,done);
	end

	initial begin
		clk = 0;
		start = 0;
		dataBus = 7;
		#1 start = 1;
		#24 dataBus = 15;
	end
endmodule
