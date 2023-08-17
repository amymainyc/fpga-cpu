module muxMB(MB, DataB, IMMS, Bout);
	input MB;
	input [7:0] IMMS;
	input [7:0] DataB;
	
	output [7:0] Bout;
	
	assign Bout = (MB == 1'b0) ? DataB : IMMS;

endmodule