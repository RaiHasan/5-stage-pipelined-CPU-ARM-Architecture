`timescale 1ns/10ps
//A mux that selects 8 of the options 
module mux_8_1 (dataIn, selectors, dataOut);
	input logic [7:0] dataIn;
	input logic [2:0] selectors;
	output logic dataOut;
	
	logic [3:0] selectedOne;
	logic [1:0] selectedTwo;
	
	genvar i;
	
	generate
		for (i = 0; i < 4; i ++) begin : selectedOneLoop
			mux_2_1 m1 (.out(selectedOne[i]), .in1(dataIn[2*i+1]), .in0(dataIn[2*i]), .sel(selectors[0]));
		end
	endgenerate 
	
	genvar j;
	
	generate
		for (j = 0; j < 2; j ++) begin : selectedTwoLoop
			mux_2_1 m2 (.out(selectedTwo[j]), .in1(selectedOne[2*j+1]), .in0(selectedOne[2*j]),
				.sel(selectors[1]));
		end
	endgenerate
	
	
	mux_2_1 m3 (.out(dataOut), .in1(selectedTwo[1]), .in0(selectedTwo[0]), .sel(selectors[2]));
endmodule
	
	