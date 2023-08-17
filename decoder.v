module decoder(INST, DR, SA, SB, IMM, MB, FS, MD, LD, MW, BS, OFF, HALT);

	input [15:0] INST;
	output reg [2:0] DR, SA, SB, FS, BS;
	output reg [5:0] IMM, OFF;
	output reg MB, MD, LD, MW, HALT;
	wire [2:0] BS_NB, BS_EQ, BS_NE, BS_GEZ, BS_LTZ;
	
	assign BS_NB = 3'b100;
	assign BS_EQ = 3'b000;
	assign BS_NE = 3'b001;
	assign BS_GEZ = 3'b010;
	assign BS_LTZ = 3'b011;
	
	parameter [3:0] 	OP_NOP = 4'd0,
							OP_LB  = 4'd2,
							OP_SB  = 4'd4,
							OP_ADDI= 4'd5,
							OP_ANDI= 4'd6,
							OP_ORI = 4'd7,
							OP_BEQ = 4'd8,
							OP_BNE = 4'd9,
							OP_BGEZ= 4'd10,
							OP_BLTZ= 4'd11,
							OP_NIMM= 4'b1111;
							
	parameter [2:0]	FS_ADD = 3'b000,
							FS_SUB = 3'b001,
							FS_SRA = 3'b010,
							FS_SRL = 3'b011,
							FS_SLL = 3'b100,
							FS_AND = 3'b101,
							FS_OR  = 3'b110;
							
	always@(*) begin
		case(INST[15:12]) 
			OP_NOP: begin
			// INST[2:0] = FUNCT
			if (INST[2:0]== 3'b000) begin DR = INST[5:3]; SA = INST[11:9]; SB = INST[8:6]; IMM = 6'b000000; MB = 1'b0; FS = FS_ADD; MD = 1'b0; LD = 1'b0; MW = 1'b0; BS = 3'b000; OFF = 6'd0; HALT = 0; end
			else begin DR = INST[5:3]; SA = INST[11:9]; SB = INST[8:6]; IMM = 6'b000000; MB = 1'b0; FS = FS_SUB; MD = 1'b0; LD = 1'b0; MW = 1'b0; BS = 3'b000; OFF = 6'd0; HALT = 1; end
		end
			// INST[11:9] = RS, INST[8:6] = RT, INST[5:0] = IMM
			OP_LB: begin DR = INST[8:6]; SA = INST[11:9]; SB = 3'd0; IMM = INST[5:0]; MB = 1'b1; FS = FS_ADD; MD = 1'b1; LD = 1'b1; MW = 1'b0; BS = BS_NB; OFF = 6'd0; HALT = 0; end
			OP_SB: begin DR = 3'd0; SA = INST[11:9]; SB = INST[8:6]; IMM = INST[5:0]; MB = 1'b1; FS = FS_ADD; MD = 1'b0; LD = 1'b0; MW = 1'b1; BS = BS_NB; OFF = 6'd0; HALT = 0; end
			OP_ADDI: begin DR = INST[8:6]; SA = INST[11:9]; SB = 3'd0; IMM = INST[5:0]; MB = 1'b1; FS = FS_ADD; MD = 1'b0; LD = 1'b1; MW = 1'b0; BS = BS_NB; OFF = 6'd0; HALT = 0; end
			OP_ANDI: begin DR = INST[8:6]; SA = INST[11:9]; SB = 3'd0; IMM = INST[5:0]; MB = 1'b1; FS = FS_AND; MD = 1'b0; LD = 1'b1; MW = 1'b0; BS = BS_NB; OFF = 6'd0; HALT = 0; end
			OP_ORI: begin DR = INST[8:6]; SA = INST[11:9]; SB = 3'd0; IMM = INST[5:0]; MB = 1'b1; FS = FS_OR; MD = 1'b0; LD = 1'b1; MW = 1'b0; BS = BS_NB; OFF = 6'd0; HALT = 0; end
			OP_BEQ: begin DR = 3'd0; SA = INST[11:9]; SB = INST[8:6]; IMM = 6'd0; MB = 1'b0; FS = FS_SUB; MD = 1'b0; LD = 1'b0; MW = 1'b0; BS = BS_EQ; OFF = INST[5:0]; HALT = 0; end
			OP_BNE: begin DR = 3'd0; SA = INST[11:9]; SB = INST[8:6]; IMM = 6'd0; MB = 1'b0; FS = FS_SUB; MD = 1'b0; LD = 1'b0; MW = 1'b0; BS = BS_NE; OFF = INST[5:0]; HALT = 0; end
			OP_BGEZ: begin DR = 3'd0; SA = INST[11:9]; SB = 3'd0; IMM = 6'd0; MB = 1'b1; FS = FS_ADD; MD = 1'b0; LD = 1'b0; MW = 1'b0; BS = BS_GEZ; OFF = INST[5:0]; HALT = 0; end
			OP_BLTZ: begin DR = 3'd0; SA = INST[11:9]; SB = 3'd0; IMM = 6'd0; MB = 1'b1; FS = FS_ADD; MD = 1'b0; LD = 1'b0; MW = 1'b0; BS = BS_LTZ; OFF = INST[5:0]; HALT = 0; end
		
			OP_NIMM: begin
				case(INST[2:0])
					// INST[11:9] = RS, INST[8:6] = RT, INST[5:3] = RD, INST[2:0] = FUNCT
					FS_ADD: begin DR = INST[5:3]; SA = INST[11:9]; SB = INST[8:6]; IMM = 6'b000000; MB = 1'b0; FS = FS_ADD; MD = 1'b0; LD = 1'b1; MW = 1'b0; BS = BS_NB; OFF = 6'd0; HALT = 0; end
					FS_SUB: begin DR = INST[5:3]; SA = INST[11:9]; SB = INST[8:6]; IMM = 6'b000000; MB = 1'b0; FS = FS_SUB; MD = 1'b0; LD = 1'b1; MW = 1'b0; BS = BS_NB; OFF = 6'd0; HALT = 0; end
					FS_SRA: begin DR = INST[5:3]; SA = INST[11:9]; SB = INST[8:6]; IMM = 6'b000000; MB = 1'b0; FS = FS_SRA; MD = 1'b0; LD = 1'b1; MW = 1'b0; BS = BS_NB; OFF = 6'd0; HALT = 0; end
					FS_SRL: begin DR = INST[5:3]; SA = INST[11:9]; SB = INST[8:6]; IMM = 6'b000000; MB = 1'b0; FS = FS_SRL; MD = 1'b0; LD = 1'b1; MW = 1'b0; BS = BS_NB; OFF = 6'd0; HALT = 0; end
					FS_SLL: begin DR = INST[5:3]; SA = INST[11:9]; SB = INST[8:6]; IMM = 6'b000000; MB = 1'b0; FS = FS_SLL; MD = 1'b0; LD = 1'b1; MW = 1'b0; BS = BS_NB; OFF = 6'd0; HALT = 0; end
					FS_AND: begin DR = INST[5:3]; SA = INST[11:9]; SB = INST[8:6]; IMM = 6'b000000; MB = 1'b0; FS = FS_AND; MD = 1'b0; LD = 1'b1; MW = 1'b0; BS = BS_NB; OFF = 6'd0; HALT = 0; end
					FS_OR: begin DR = INST[5:3]; SA = INST[11:9]; SB = INST[8:6]; IMM = 6'b000000; MB = 1'b0; FS = FS_OR; MD = 1'b0; LD = 1'b1; MW = 1'b0; BS = BS_NB; OFF = 6'd0; HALT = 0; end
					
					default: begin DR = INST[5:3]; SA = INST[11:9]; SB = INST[8:6]; IMM = 6'b000000; MB = 1'b0; FS = FS_ADD; MD = 1'b0; LD = 1'b0; MW = 1'b0; BS = BS_NB; OFF = 6'd0; HALT = 0; end
				endcase
			end
			default: begin DR = INST[5:3]; SA = INST[11:9]; SB = INST[8:6]; IMM = 6'b000000; MB = 1'b0; FS = FS_ADD; MD = 1'b0; LD = 1'b0; MW = 1'b0;  BS = BS_NB; OFF = 6'd0; HALT = 0;end
		endcase
	end
	
	
endmodule