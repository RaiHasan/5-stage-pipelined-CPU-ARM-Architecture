`timescale 1ns/10ps
//5_32 decoder where the selectors choose which output is active if dataIn is true
module decoder5_32(dataInput, selectors, dataOutput);
	input logic dataInput;
	input logic [4:0] selectors;
	output logic [31:0] dataOutput;
	
	
	wire [3:0] decoder2Output;
	
	decoder2_4 levelOne (.dataInput, .dataOutput(decoder2Output), .selectors(selectors[4:3]));
	

	decoder3_8 levelTwo (.dataInput(decoder2Output[0]), .dataOutput(dataOutput[7:0]),
		.selectors(selectors[2:0]));
		
	decoder3_8 levelThree (.dataInput(decoder2Output[1]), .dataOutput(dataOutput[15:8]),
		.selectors(selectors[2:0]));
		
	decoder3_8 levelFour (.dataInput(decoder2Output[2]), .dataOutput(dataOutput[23:16]),
		.selectors(selectors[2:0]));
		
	decoder3_8 levelFive (.dataInput(decoder2Output[3]), .dataOutput(dataOutput[31:24]),
		.selectors(selectors[2:0]));
	
endmodule 
	
	
	