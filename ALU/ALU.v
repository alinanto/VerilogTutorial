//Structural design of the ALU-16bit
module ALU (X,Y,Z,Sign,Zero,Carry,Parity,Overflow);
  input [15:0] X,Y;
  output [15:0] Z;
  output Sign,Zero,Carry,Parity,Overflow;
  wire [3:1] c;

  adder4 A0 (Z[3:0],c[1],X[3:0],Y[3:0],1'b0);
  adder4 A1 (Z[7:4],c[2],X[7:4],Y[7:4],c[1]);
  adder4 A2 (Z[11:8],c[3],X[11:8],Y[11:8],c[2]);
  adder4 A3 (Z[15:12],Carry,X[15:12],Y[15:12],c[3]);

  assign Sign = Z[15];
  assign Zero = ~|Z;
  assign Parity = ~^Z;
  assign Overflow = (X[15] & Y[15] & ~Z[15]) | (~X[15] & ~Y[15] & Z[15]);
endmodule

//Structural description of a 4bit adder
module adder4 (S,Cout,A,B,Cin);
  input [3:0] A,B;
  input Cin;
  output [3:0] S;
  output Cout;
  wire [3:1] c;

  fullAdder FA0 (S[0],c[1],A[0],B[0],Cin);
  fullAdder FA1 (S[1],c[2],A[1],B[1],c[1]);
  fullAdder FA2 (S[2],c[3],A[2],B[2],c[2]);
  fullAdder FA3 (S[3],Cout,A[3],B[3],c[3]);
endmodule

//Structural description of a fullAdder
module fullAdder (S,Cout,A,B,Cin);
  input A,B,Cin;
  output S,Cout;
  wire s1,c1,c2;

  xor G1 (s1,A,B),
      G2 (S,s1,Cin),
      G3 (Cout,c2,c1);
  and G4 (c1,A,B),
      G5 (c2,s1,Cin);
endmodule

/*

//behavioural description of a 16bit ALU
module ALU (X,Y,Z,Sign,Zero,Carry,Parity,Overflow);
  input [15:0] X,Y;
  output [15:0] Z;
  output Sign,Zero,Carry,Parity,Overflow;

  assign {Carry,Z} = X + Y;
  assign Sign = Z[15];
  assign Zero = ~|Z;
  assign Parity = ~^Z;
  assign Overflow = (X[15] & Y[15] & ~Z[15]) | (~X[15] & ~Y[15] & Z[15]);
endmodule

//behavioural description of a 4bit adder
module adder4 (S,Cout,A,B,Cin);
  input [3:0] A,B;
  input Cin;
  output [3:0] S;
  output Cout;

  assign {Cout,S} = A+B+Cin;
endmodule

//behavioural description of a fullAdder
module fullAdder (S,Cout,A,B,Cin);
  input A,B,Cin;
  output S,Cout;

  assign {Cout,S} = A+B+Cin;
endmodule

*/
