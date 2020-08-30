module testbench;
  reg A,B,C,D,E,F;
  wire Y;
  example DUT (A,B,C,D,E,F,Y);
  initial
    begin
      $dumpfile ("example.vcd");
      $dumpvars (0,testbench);
      $monitor ($time," A=%b, B=%b, C=%b, D=%b, E=%b, F=%b, Y=%b",
              A,B,C,D,E,F,Y);
      #5 A=1;B=0;C=0;D=1;E=0;F=0;
      #5 A=0;B=0;C=1;D=1;E=0;F=0;
      #5 A=1;C=0;
      #5 F=1;
      #5 $finish;
    end
endmodule
