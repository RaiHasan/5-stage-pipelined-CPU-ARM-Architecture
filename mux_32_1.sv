`timescale 1ns/10ps
// mux 32_1 takes 32 single bit input and choose 1 to output
module mux_32_1 (dataIn, selectors, dataOut);
	input logic [31:0] dataIn;
	input logic [4:0] selectors;
	output logic dataOut; 
	wire [15:0] selectedOne;
	wire [7:0] selectedTwo;
	wire [3:0] selectedThree;
	wire [1:0] selectedFour;
	
	
	
	genvar i;
	
	generate
		for (i = 0; i < 16; i ++) begin : selectedOneLoop
			mux_2_1 m1 (.out(selectedOne[i]), .in1(dataIn[2*i+1]), .in0(dataIn[2*i]), .sel(selectors[0]));
		end
	endgenerate 
	
	
	genvar j;
	
	generate
		for (j = 0; j < 8; j ++) begin : selectedTwoLoop
			mux_2_1 m2 (.out(selectedTwo[j]), .in1(selectedOne[2*j+1]), .in0(selectedOne[2*j]), .sel(selectors[1]));
		end
	endgenerate 
	
	
	genvar k;
	
	generate
		for (k = 0; k < 4; k ++) begin : selectedThreeLoop
			mux_2_1 m3 (.out(selectedThree[k]), .in1(selectedTwo[2*k+1]), .in0(selectedTwo[2*k]), .sel(selectors[2]));
		end
	endgenerate 
	
	
	genvar a;
	
	generate
		for (a = 0; a < 2; a ++) begin : selectedFourLoop
			mux_2_1 m4 (.out(selectedFour[a]), .in1(selectedThree[2*a+1]), .in0(selectedThree[2*a]), .sel(selectors[3]));
		end
	endgenerate 
	
	mux_2_1 m4 (.out(dataOut), .in1(selectedFour[1]), .in0(selectedFour[0]), .sel(selectors[4]));
	
endmodule 
	
	
	
	
	