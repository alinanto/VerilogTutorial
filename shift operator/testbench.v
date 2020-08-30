module testbench;
  reg signed [7:0] A,B;
  wire [7:0] C,D,E,F;
  assign C = A>>2 ;
  assign D = B<<3 ;
  assign E = A>>>3 ;
  assign F = B<<<2 ;
  initial begin
    $dumpfile ("example.vcd");
    $dumpvars (0,testbench);
    $monitor($time," A = %b, B = %b, A>>2 = %b, B<<3 = %b, A>>>3 = %b, B<<<2 = %b",A,B,C,D,E,F);
    #1   A = 8'h11; B = 8'h81;
    #1   A = 8'h07; B = 8'hF0;
    #1   A = 8'h80; B = 8'h01;
    #1   A = 8'hCC; B = 8'h55;
    #1   A = 8'h55; B = 8'h55;
    $finish;
  end
endmodule
