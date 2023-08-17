module lab5hrm(CLK, RESET, ADDR, Q);
  input         CLK;
  input         RESET;
  input  [7:0]  ADDR;
  output [15:0] Q;

  reg    [15:0] mem[0:127]; // instruction memory with 16 bit entries

  wire   [6:0]  saddr;
  integer       i;

  assign saddr = ADDR[7:1];
  assign Q = mem[saddr];

  always @(posedge CLK) begin
    if(RESET) begin
      mem[0]  <= 16'b1111000000000001; //SUB   R0, R0, R0
      mem[1]  <= 16'b0000000000000001; //HALT
      mem[2]  <= 16'b0010000010111010; //LB    R2, -6(R0)
      mem[3]  <= 16'b0101010100100010; //ADDI  R4, R2, -30
      mem[4]  <= 16'b1011100000000001; //BLTZ  R4, 1
      mem[5]  <= 16'b0101000010011101; //ADDI  R2, R0, 29
      mem[6]  <= 16'b1111010000010100; //SLL   R2, R2
      mem[7]  <= 16'b0010010011000000; //LB    R3, 0(R2)
      mem[8]  <= 16'b0100000011111110; //SB    R3, -2(R0)
      mem[9]  <= 16'b0010010011000001; //LB    R3, 1(R2)
      mem[10]  <= 16'b0100000011111111; //SB    R3, -1(R0)
      mem[11]  <= 16'b1111111111111001; //SUB   R7, R7, R7
      mem[12]  <= 16'b0101111111111111; //ADDI  R7, R7, -1
      mem[13]  <= 16'b0101011011100010; //ADDI  R3, R3, -30
      mem[14]  <= 16'b0101011011100010; //ADDI  R3, R3, -30
      mem[15]  <= 16'b1011011000000111; //BLTZ  R3, 7
      mem[16]  <= 16'b1000000011000110; //BEQ   R3, R0, 6
      mem[17]  <= 16'b1111111000110011; //SRL   R6, R7
      mem[18]  <= 16'b1111111110111000; //ADD   R7, R7, R6
      mem[19]  <= 16'b0101011011110110; //ADDI  R3, R3, -10
      mem[20]  <= 16'b1111110000110011; //SRL   R6, R6
      mem[21]  <= 16'b1000000110000001; //BEQ   R6, R0, 1
      mem[22]  <= 16'b1010011000111011; //BGEZ  R3, -5
      mem[23]  <= 16'b0100000111111100; //SB    R7, -4(R0)

    
      for(i = 24; i < 128; i = i + 1) begin
        mem[i] <= 16'b0000000000000000;
      end
    end
  end

endmodule
