module cpu(CLK, RESET, EN_L, Iin, Din, PC, NextPC, DataA, DataB, DataC, DataD, MW);
  input         CLK;
  input         RESET;
  input         EN_L;
  input  [15:0] Iin;
  input  [7:0]  Din;
  
  output [7:0]  PC;
  output [7:0]  NextPC;
  output [7:0]  DataA;
  output [7:0]  DataB;
  output [7:0]  DataC;
  output [7:0]  DataD;
  output        MW;
  
  // comment the two lines out below if you use a submodule to generate PC/NextPC

  reg [7:0] PC;
  wire [7:0] NextPC;
  
  // ADD YOUR CODE BELOW THIS LINE
  wire C, V, N, Z, H, MB, MD, MP, MW, LD, HALT;
  wire [2:0] BS, DR, SA, SB, FS;
  wire [5:0] IMM, OFF;
  wire [7:0] B, DataA, DataB, DataC, DataD, sextIMM, PCw0, PCw1, PCw2, sextOFF;
  
  assign PCw0 = PC + 8'd2;
  assign PCw1 = PCw0 + sextOFF;
  assign NextPC = H ? PC : (MP ? PCw1 : PCw0);
  
  always @(posedge CLK)
	begin
		if (RESET) begin
			PC <= 0;
		end
		else begin
			PC <= NextPC;
		end
	end
  
  assign MP = (BS == 3'b000) ? Z : ((BS == 3'b001) ? ~Z : ((BS == 3'b010) ? ~N : ((BS == 3'b011) ? N : 0))); 
  
  decoder decode(
	.INST(Iin),
	.DR(DR),
	.SA(SA),
	.SB(SB),
	.IMM(IMM),
	.MB(MB),
	.FS(FS),
	.MD(MD),
	.LD(LD),
	.MW(MW),
	.BS(BS),
	.OFF(OFF),
	.HALT(HALT)
  );
  
  register regF(
  .CLK(CLK),
  .RESET(RESET),
  .SA(SA),
  .SB(SB),
  .LD(LD),
  .DR(DR),
  .D_in(DataC),
  .DataA(DataA),
  .DataB(DataB)
  );
  
  signExt seIMM(
	.IMM(IMM),
	.sextIMM(sextIMM)
  );
  
  assign B = MB ? sextIMM : DataB;

  
  signExtOFF seOFF(
	.OFF(OFF),
	.sextOFF(sextOFF)
  );
  
  halter halt(
	.CLK(CLK),
	.HALT(HALT),
	.EN_L(EN_L),
	.H(H)
  );
  
  alu aluu(
	.A(DataA),
	.B(B),
	.OP(FS),
	.Y(DataD),
	.C(C),
	.V(V),
	.N(N),
	.Z(Z)
  );
  
  assign DataC = MD ? Din : DataD;


  // ADD YOUR CODE ABOVE THIS LINE

endmodule
