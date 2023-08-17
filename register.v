module register(CLK, RESET, SA, SB, LD, DR, D_in, DataA, DataB);

  input        CLK, RESET, LD;
  input 	[2:0] SA, SB, DR;
  input  [7:0] D_in;
  
  output reg [7:0] DataA, DataB; 
  reg    	 [7:0] R0, R1, R2, R3, R4, R5, R6, R7;
  
  always @(*) begin
	case(SA)
		3'b000: DataA = R0;
		3'b001: DataA = R1;
		3'b010: DataA = R2;
		3'b011: DataA = R3;
		3'b100: DataA = R4;
		3'b101: DataA = R5;
		3'b110: DataA = R6;
		3'b111: DataA = R7;
		default: DataA = 0;
	endcase
	
	case(SB)
		3'b000: DataB = R0;
		3'b001: DataB = R1;
		3'b010: DataB = R2;
		3'b011: DataB = R3;
		3'b100: DataB = R4;
		3'b101: DataB = R5;
		3'b110: DataB = R6;
		3'b111: DataB = R7;
		default: DataB = 0;
	endcase
  end
  
  always @(posedge CLK, posedge RESET) begin
		if(RESET) begin
			R0 <= 0;
			R1 <= 0;
			R2 <= 0;
			R3 <= 0;
			R4 <= 0;
			R5 <= 0;
			R6 <= 0;
			R7 <= 0;
		end
		else if (LD) begin
			case(DR)
				3'b000: R0 <= D_in;
				3'b001: R1 <= D_in;
				3'b010: R2 <= D_in;
				3'b011: R3 <= D_in;
				3'b100: R4 <= D_in;
				3'b101: R5 <= D_in;
				3'b110: R6 <= D_in;
				3'b111: R7 <= D_in;
			endcase
		end
		else begin
			R0 <= R0;
			R1 <= R1;
			R2 <= R2;
			R3 <= R3;
			R4 <= R4;
			R5 <= R5;
			R6 <= R6;
			R7 <= R7;
		end
  end

endmodule