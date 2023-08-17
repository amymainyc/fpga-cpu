module signExt(IMM, sextIMM);

	input [5:0] IMM;
	output [7:0] sextIMM;
	
	assign sextIMM[5:0] = IMM;
	assign sextIMM[7:6] = IMM[5] ? 2'b11 : 2'b00;

endmodule