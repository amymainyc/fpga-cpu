module control(OP, BSEL, CISEL, OSEL, SHIFT_LA, SHIFT_LR, LOGICAL_OP); // add other inputs and outputs here

  // inputs (add others here)
  input [2:0] OP;
  
  // outputs (add others here)
  output BSEL, CISEL, SHIFT_LA, SHIFT_LR, LOGICAL_OP;
  output reg [1:0] OSEL;

  // reg and internal variable definitions
  
  
  // implement module here (add other control signals below)
  assign BSEL = (OP == 3'b001) ? 1 : 0;
  assign CISEL = (OP == 3'b001) ? 1 : 0;

  always @(*) begin
    case (OP)
      3'b000: OSEL = 0;
      3'b001: OSEL = 0;
      3'b010: OSEL = 1;
      3'b011: OSEL = 1;
      3'b100: OSEL = 1;
      3'b101: OSEL = 2;
      3'b110: OSEL = 2;
      default: OSEL = 0;
    endcase
  end

  assign SHIFT_LA = (OP == 3'b010) ? 1 : 0;
  assign SHIFT_LR = (OP == 3'b010 || OP == 3'b011) ? 1 : 0;
  assign  LOGICAL_OP = (OP == 3'b101) ? 1 : 0;
  
endmodule