
`timescale 1ns/10ps
module register_1Bit (dataIn, enable, reset, clk, dataOut);
		input logic dataIn, enable, reset, clk;
		output logic dataOut;
		
		logic dataEnabled;
		
		 mux_2_1 enableMux (.out(dataEnabled), .in1(dataIn), 
				.in0(dataOut), .sel(enable)); 
			 D_FF flip_flop (.q(dataOut), .d(dataEnabled), .reset, .clk);
endmodule
