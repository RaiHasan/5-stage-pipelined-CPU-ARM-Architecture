

// Data is a concatanation of inputs
// msb is 11, lsb is 00.
 
`timescale 1ns/10ps
module mux_4_64_1 (dataIn, selectors, dataOut);
	input logic [3:0] [63:0] dataIn;
	input logic [1:0] selectors;
	output logic [63:0] dataOut; 
	logic [1:0] [63:0] selectedOne;
	
	mux_2_64_1 zeroSelect (.out(selectedOne[0]), .in1(dataIn[1]), .in0(dataIn[0]), .sel(selectors[0]));
	 
	mux_2_64_1 oneSelect (.out(selectedOne[1]), .in1(dataIn[3]), .in0(dataIn[2]), .sel(selectors[0]));
	 
	mux_2_64_1 finalSelect (.out(dataOut), .in1(selectedOne[1]), .in0(selectedOne[0]), .sel(selectors[1]));
endmodule 
	 
	 
	
              