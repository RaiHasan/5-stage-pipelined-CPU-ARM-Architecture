`timescale 1ns/10ps
// inputs
// dataIn 64 bit: dataIn for the register
// enable: Enable for the register to change the output
// reset: resets the register to 0
// dataOut: register output, will stay the same unless new data is written in when enable is active
module register_64Bit(dataIn, enable, reset, clk, dataOut);
	input logic [63:0] dataIn;
	input logic enable, reset, clk;
	output logic [63:0] dataOut;
	
	
	wire [63:0] dataEnabled;
	
	
	
	
	
	genvar i;
	
	generate
		for (i = 0; i < 64; i++) begin : flip_flop_arrays
			 mux_2_1 enableMux (.out(dataEnabled[i]), .in1(dataIn[i]), 
				.in0(dataOut[i]), .sel(enable)); 
			 D_FF flip_flop (.q(dataOut[i]), .d(dataEnabled[i]), .reset, .clk);
		end
	endgenerate 


endmodule 


			
	