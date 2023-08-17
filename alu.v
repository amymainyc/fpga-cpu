module alu(A, B, OP, Y, C, V, N, Z);
  input  [7:0]  A;
  input  [7:0]  B;
  input  [2:0]  OP;

  output reg [7:0]  Y;
  output reg        C;
  output reg        V;
  output        N;
  output        Z;


  // ADD YOUR CODE BELOW THIS LINE
  wire BSEL, CISEL, SHIFT_LA, SHIFT_LR, LOGICAL_OP;
  wire [1:0] OSEL;
  control freak(
    .OP(OP),
    .BSEL(BSEL),
    .CISEL(CISEL),
    .OSEL(OSEL),
    .SHIFT_LA(SHIFT_LA),
    .SHIFT_LR(SHIFT_LR),
    .LOGICAL_OP(LOGICAL_OP)
  );

  wire [7:0] Y2;
  wire C2 = 0;
  wire V2 = 0;
  logical paradox(
    .A(A),
    .B(BSEL ? ~B : B),
    .OP(LOGICAL_OP),
    .Y(Y2)
  );  
  
  wire [7:0] Y1;
  wire C1;
  wire V1 = 0;
  shifter iDontGiveAShift(
    .A(A),
    .LA(SHIFT_LA),
    .LR(SHIFT_LR),
    .Y(Y1),
    .C(C1)
  );

  wire [7:0] Y0;
  wire C0, V0;
  adder interestingAdderName(
    .A(A),
    .B(BSEL ? ~B : B),
    .CI(CISEL ? 1 : 0),
    .Y(Y0),
    .C(C0),
    .V(V0)
  );

  assign N = Y[7];
  assign Z = ~(Y[0] || Y[1] || Y[2] || Y[3] || Y[4] || Y[5] || Y[6] || Y[7]);

  always @(*) begin
    case (OSEL)
      0: begin
        Y = Y0;
        C = C0;
        V = V0;
      end
      1: begin
        Y = Y1;
        C = C1;
        V = V1;
      end
      2: begin
        Y = Y2;
        C = C2;
        V = V2;
      end
      default: begin
        Y = Y0;
        C = C0;
        V = V0;
      end 
    endcase
  end
  
  // ADD YOUR CODE ABOVE THIS LINE

endmodule
