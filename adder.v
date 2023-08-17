module adder(A, B, CI, Y, C, V); // add all inputs and outputs inside parentheses

  // inputs
  input [7:0] A, B;
  input CI;
  
  // outputs
  output reg [7:0] Y;
  output reg C, V;
  
  // reg and internal variale definitions
  reg C_TEMP;
  
  // implement module here
  always @(A, B, CI) begin
    C_TEMP = CI;

    Y[0] = C_TEMP ? ~(A[0] ^ B[0]) : (A[0] ^ B[0]);
    C_TEMP = C_TEMP ? A[0] || B[0] : (A[0] && B[0]);
    
    Y[1] = C_TEMP ? ~(A[1] ^ B[1]) : (A[1] ^ B[1]);
    C_TEMP = C_TEMP ? A[1] || B[1] : (A[1] && B[1]);

    Y[2] = C_TEMP ? ~(A[2] ^ B[2]) : (A[2] ^ B[2]);
    C_TEMP = C_TEMP ? A[2] || B[2] : (A[2] && B[2]);

    Y[3] = C_TEMP ? ~(A[3] ^ B[3]) : (A[3] ^ B[3]);
    C_TEMP = C_TEMP ? A[3] || B[3] : (A[3] && B[3]);

    Y[4] = C_TEMP ? ~(A[4] ^ B[4]) : (A[4] ^ B[4]);
    C_TEMP = C_TEMP ? A[4] || B[4] : (A[4] && B[4]);

    Y[5] = C_TEMP ? ~(A[5] ^ B[5]) : (A[5] ^ B[5]);
    C_TEMP = C_TEMP ? A[5] || B[5] : (A[5] && B[5]);

    Y[6] = C_TEMP ? ~(A[6] ^ B[6]) : (A[6] ^ B[6]);
    C_TEMP = C_TEMP ? A[6] || B[6] : (A[6] && B[6]);

    Y[7] = C_TEMP ? ~(A[7] ^ B[7]) : (A[7] ^ B[7]);
    C = C_TEMP ? A[7] || B[7] : (A[7] && B[7]);

    V = C ^ C_TEMP;

  end
  
endmodule