module testbench;
  reg [15:0] X,Y;
  wire [15:0] Z;
  wire S,ZR,C,P,O;
  ALU DUT (X,Y,Z,S,ZR,C,P,O);

  initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0,testbench);
    $monitor($time," X=%b,Y=%b,Z=%b,S=%b,ZR=%b,C=%b,P=%b,O=%b",X,Y,Z,S,ZR,C,P,O);
    #1 X=16'H8FFF; Y=16'H8000;
    #1 X=16'HFFFE; Y=16'H0002;
    #1 X=16'HAAAA; Y=16'H5555;
    #1 $finish;
  end
endmodule
