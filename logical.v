module logical(A, B, OP, Y); // add all inputs and outputs inside parentheses

  // inputs
  input [7:0] A, B;
  input OP;
  
  // outputs
  output [7:0] Y;
  
  // reg and internal variable definitions
  
  
  // implement module here
  assign Y[0] = OP ? A[0] && B[0] : A[0] || B[0];
  assign Y[1] = OP ? A[1] && B[1] : A[1] || B[1];
  assign Y[2] = OP ? A[2] && B[2] : A[2] || B[2];
  assign Y[3] = OP ? A[3] && B[3] : A[3] || B[3];
  assign Y[4] = OP ? A[4] && B[4] : A[4] || B[4];
  assign Y[5] = OP ? A[5] && B[5] : A[5] || B[5];
  assign Y[6] = OP ? A[6] && B[6] : A[6] || B[6];
  assign Y[7] = OP ? A[7] && B[7] : A[7] || B[7];
  
endmodule