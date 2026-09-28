
`timescale 1ns/10ps
module D_FF_enable (q, d, reset, clk, enable);
	input logic d, reset, clk, enable; 
	output logic q;
	
	wire enableInversed;
	wire oldDataEnabled;
	wire newDataEnabled;
	
	wire dataOut;
	wire dataIn;
	
	D_FF flip_flop (.q(dataOut), .d(dataIn), .reset, .clk);
	
	not #(0.05) gateOne (enableInversed, enable);
	
	and #(0.05) gateTwo (oldDataEnabled, enableInversed, dataOut);
	
	and #(0.05) gateThree (newDataEnabled, enable, d);
	
	or #(0.05) gateFour (dataIn, oldDataEnabled, newDataEnabled);
	
	assign q = dataOut;

	
endmodule 