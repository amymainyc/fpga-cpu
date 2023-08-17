module halter(CLK, HALT, EN_L, H);
	input CLK, HALT, EN_L;
	output wire H;

	reg EN_L_PREV;
	reg ADVANCE;
	always @(posedge CLK) begin
		if (EN_L == 0 && EN_L_PREV == 1) ADVANCE = 1;
		else ADVANCE = 0;
		EN_L_PREV = EN_L;
	end
	
	assign H = (HALT & ~ADVANCE) ? 1'b1 : 1'b0;

endmodule