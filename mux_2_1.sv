`timescale 1ns/10ps
//Mux 2 by 1 
// in1 is value chosen if sel is 1 
// in0 is value chosen  if sel 0
module mux_2_1 (out, in1, in0, sel);
	input logic in1, in0, sel;
	output logic out;
	
	wire selInversed;
	
	wire in0DataEnabled;
	
	wire in1DataEnabled;
	
	
	
	not #(0.05) gateOne (selInversed, sel);
	
	and #(0.05) gateTwo (in0DataEnabled, selInversed, in0);
	
	and #(0.05) gateThree (in1DataEnabled, sel, in1);
	
	or #(0.05) gateFour (out, in1DataEnabled, in0DataEnabled);
	
endmodule 