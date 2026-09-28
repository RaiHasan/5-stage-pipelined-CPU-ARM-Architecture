
`timescale 1ns/10ps
// 3_8 decoder which selects which output is active if dataIn is true
module decoder3_8 (dataInput, dataOutput, selectors);
	input logic dataInput;
	input logic [2:0] selectors;
	output logic [7:0] dataOutput;
	
	wire invertedselector2;
	wire invertedselector1;
	wire invertedselector0;
	
	not #(0.05) gate1 (invertedselector2, selectors[2]);
	not #(0.05) gate2 (invertedselector1, selectors[1]);
	not #(0.05) gate3 (invertedselector0, selectors[0]);
	
	wire [7:0] decoderOutput;
	
	and #(0.05) gate4 (decoderOutput[0], invertedselector2, invertedselector1, invertedselector0);
	
	and #(0.05) gate5 (decoderOutput[1], invertedselector2, invertedselector1, selectors[0]);
	
	and #(0.05) gate6 (decoderOutput[2], invertedselector2, selectors[1], invertedselector0);
	
	and #(0.05) gate7 (decoderOutput[3], invertedselector2, selectors[1], selectors[0]);
	
	and #(0.05) gate8 (decoderOutput[4], selectors[2],invertedselector1, invertedselector0);
	
	and #(0.05) gate9 (decoderOutput[5], selectors[2],invertedselector1, selectors[0]);
	
	and #(0.05) gate10 (decoderOutput[6], selectors[2],selectors[1], invertedselector0);
	
	and #(0.05) gate11 (decoderOutput[7], selectors[2],selectors[1], selectors[0]);
	
	genvar i;
	
	generate 
		for(i = 0; i < 8; i++) begin : loop
			and #(0.05) gatem (dataOutput[i], decoderOutput[i], dataInput);
		end
	endgenerate 
	
	
	
endmodule 
	
	
	