


`timescale 1ns/10ps
// mux 2 by 1 for 11 bit inputs 
module mux_2_11_1 (out, in1, in0, sel);
	input logic [10:0] in1, in0;
	input logic sel;
	output logic [10:0] out;
	
	genvar i;
	generate 
		for(i = 0; i < 11; i++) begin : muxLoop
			mux_2_1 m (.out(out[i]), .in1(in1[i]), .in0(in0[i]), .sel);
		end
	endgenerate 
endmodule 