module muxMD(MD, DataALU, DataD, DataC);

  input  MD;
  input [7:0] DataALU;
  input [7:0] DataD;
  
  output [7:0] DataC;

  assign DataC = (MD == 1'b0) ? DataD : DataALU ;

endmodule