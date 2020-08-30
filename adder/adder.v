module parallelAdder (sum,cout,in1,in2,cin);
    parameter N=31;  // for 32 bit adder
    input [N:0] in1,in2;
    input cin;
    output [N:0] sum;
    output cout;
    assign {cout,sum} = in1 +in2 + cin ;
endmodule

module testbench;
  parameter N=31 ; // for 32 bit adder
  reg [N:0] in1,in2;
  reg cin;
  wire [N:0] sum;
  wire cout;
  parallelAdder DUT(sum,cout,in1,in2,cin);
  initial begin
    $dumpfile ("example.vcd");
    $dumpvars (0,testbench);
    $monitor ($time," in1 = %d, in2 = %d, cin = %b, sum = %d cout = %b",in1,in2,cin,sum,cout);
    in1 = 5; in2 = 7 ; cin = 1'b0 ;
    #1 in1 = 5; in2 = 7 ; cin = 1'b0 ;
    #1 in1 = 1; in2 = 7 ; cin = 1'b0 ;
    #1 in1 = 0; in2 = 7 ; cin = 1'b0 ;
    #1 in1 = 5; in2 = 2 ; cin = 1'b1 ;
    #1 in1 = 3; in2 = 3 ; cin = 1'b0 ;
    #1 in1 = 2; in2 = 0 ; cin = 1'b1 ;
    $finish;
  end
endmodule
