module IMMPC(IN, OUT);
	
	input [5:0] IN;
	output [7:0]OUT;
	
	wire [7:0]OUT;
	
	assign OUT[6:1] = IN[5:0];
	
	assign OUT[0] = 0;
	
	assign OUT[7] = IN[5];

endmodule