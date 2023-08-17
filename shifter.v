module shifter(A, LA, LR, Y, C); // add all inputs and outputs inside parentheses

  // inputs
  input [7:0] A;
  input LA;
  input LR;

  // outputs
  output [7:0] Y;
  output reg C;

  // reg and internal variable definitions
  reg [7:0] TEMP;

  // implement module here
  always @(*) begin
    // SLL (100) LR = 0, LA = 0
    if (~LR) begin
      TEMP[0] = 0;
      TEMP[7:1] = A[6:0];
      C = A[7];
    end
    // SRA (010) LR = 1, LA = 1
    else if (LA) begin
      TEMP[7] = A[7];
      TEMP[6:0] = A[7:1];
      C = A[0];
    end
    // SRL (011) LR = 1, LA = 1
    else begin
      TEMP[7] = 0;
      TEMP[6:0] = A[7:1];
      C = A[0];
    end
  end

  assign Y = TEMP;
  
endmodule
