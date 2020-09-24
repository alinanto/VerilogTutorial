module GCD_datapath (lt,gt,eq,data,LdA,LdB,selIn,sel,clk);
	input [15:0] data;
	input LdA,LdB,selIn,sel,clk;
	output lt,gt,eq;
	wire [15:0] Aout,Bout,Bus,X,Y,SubOut;

	PIPO A (Aout,Bus,LdA,clk);
	PIPO B (Bout,Bus,LdB,clk);
	MUX M1 (X,Aout,Bout,sel);
	MUX M2 (Y,Bout,Aout,sel);
	MUX Min (Bus,data,SubOut,selIn);
	SUB sub (SubOut,X,Y);
	COMP comp (lt,gt,eq,Aout,Bout);
endmodule

module GCD_controller (LdA,LdB,selIn,sel,done,lt,gt,eq,start,clk);
	input lt,gt,eq,start,clk;
	output reg LdA,LdB,selIn,sel,done;
	reg [2:0] state,nextState;
	parameter S0=0,S1=1,S2=2,S3=3,S4=4,S5=5;

	always @ (posedge clk) state <= nextState;

	always @ (state,lt,gt,eq,start) case (state)
		S0 : begin
				 if(start) nextState = S1;
				 else nextState = S0;
				 LdA=0;LdB=0;selIn=0;sel=0;done=0;
				 end
		S1 : begin
				 nextState = S2;
				 LdA=1; //load A from data
				 end
		S2 : begin
				 if (lt) nextState = S3;
				 else if (gt) nextState = S4;
				 else if (eq) nextState = S5;
				 LdA=0;LdB=1; //load B from data
				 end
	  S3 : begin
				 if (lt) nextState = S3;
				 else if (gt) nextState = S4;
				 else if (eq) nextState = S5;
				 LdA=0;LdB=1;sel=1;selIn=1;  // A<B so B=B-A
				 end
		S4 : begin
				 if (lt) nextState = S3;
				 else if (gt) nextState = S4;
				 else if (eq) nextState = S5;
				 LdA=1;LdB=0;sel=0;selIn=1;	// A>B so A=A-B
				 end
		S5 : begin
				 nextState = S5;
				 LdA=0;LdB=0;done=1;
				 end
		default : begin
							nextState = S0;
							LdA=0;LdB=0;selIn=0;sel=0;done=0;
							end
	endcase
endmodule

module PIPO (out,in,Ld,clk);
	input [15:0] in;
	input Ld,clk;
  output reg [15:0] out;

	always @ (negedge clk)
		if (Ld) out <= in;
endmodule

module MUX (out,in0,in1,sel);
	input [15:0] in0,in1;
	input sel;
	output [15:0] out;

	assign out = sel ? in1 : in0;
endmodule

module SUB (out,in0,in1);
	input [15:0] in0,in1;
	output [15:0] out;

	assign out = in0-in1;
endmodule

module COMP (lt,gt,eq,in0,in1);
	input [15:0] in0,in1;
	output lt,gt,eq;

	assign lt = (in0<in1);
	assign gt = (in0>in1);
	assign eq = (in0==in1);
endmodule

module testbench;
	reg [15:0] data;
	reg clk,start;
	wire LdA,LdB,selIn,sel,done,lt,gt,eq;
	GCD_controller CT (LdA,LdB,selIn,sel,done,lt,gt,eq,start,clk);
	GCD_datapath DP (lt,gt,eq,data,LdA,LdB,selIn,sel,clk);

	always #5 clk = ~clk;
	always #20 if (done) $finish;

	initial begin
		$dumpfile ("waveform.vcd");
		$dumpvars (0,testbench);
		$monitor ($time," : A = %2d, B = %2d, done = %b",DP.Aout,DP.Bout,done);
	end

	initial begin
		clk = 0;
		start = 0;
		data = 39;
		#1 start = 1;
		#24 data = 65;
	end
endmodule
