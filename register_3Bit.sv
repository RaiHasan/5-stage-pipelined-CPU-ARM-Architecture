
`timescale 1ns/10ps

module register_3Bit(dataIn, enable, reset, clk, dataOut);
	input logic [2:0] dataIn;
	input logic enable, reset, clk;
	output logic [2:0] dataOut;
	
	
	logic [2:0] dataEnabled;
	
	
	
	
	
	genvar i;
	
	generate
		for (i = 0; i < 3; i++) begin : flip_flop_arrays
			 mux_2_1 enableMux (.out(dataEnabled[i]), .in1(dataIn[i]), 
				.in0(dataOut[i]), .sel(enable)); 
			 D_FF flip_flop (.q(dataOut[i]), .d(dataEnabled[i]), .reset, .clk);
		end
	endgenerate 


endmodule 