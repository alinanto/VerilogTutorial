module SRlatch (Q,Qbar,S,R);
  input S,R;
  output Q,Qbar;

  assign Q = ~(R&Qbar);
  assign Qbar = ~(S&Q);
endmodule

module testbench;
  reg S,R;
  wire Q,Qbar;
  SRlatch DUT(Q,Qbar,S,R);
  initial begin
    $dumpfile("SRlatch.vcd");
    $dumpvars(0,testbench);
    $monitor($time," S=%b,R=%b,Q=%b,Q'=%b",S,R,Q,Qbar);
    #1 S = 1'b0; R = 1'b0;
    #1 S = 1'b0; R = 1'b1;
    #1 S = 1'b1; R = 1'b0;
    #1 S = 1'b1; R = 1'b1;
    #1 S = 1'b0; R = 1'b1;
    #1 S = 1'b1; R = 1'b1;
    #1 S = 1'b0; R = 1'b0;
    #1 S = 1'b1; R = 1'b1;  //here the simulator Hangs up
    #1 $finish;
  end
endmodule
