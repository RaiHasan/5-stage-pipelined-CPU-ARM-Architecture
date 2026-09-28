`timescale 1ns/10ps

// takes 64 bit inputs and chooses one 64 bit to output
module mux64_32(dataIn, selectors, dataOut);
	input logic [31:0][63:0] dataIn;
	input logic [4:0] selectors;
	output logic [63:0] dataOut; 

	genvar i,j;
	
	generate
		for (i = 0; i < 64; i++) begin : loopOne
			wire [31:0] bits64;
			
			for(j = 0; j < 32; j++) begin : loopTwo 
				assign bits64[j] = dataIn[j][i];
			end
			
			mux_32_1 muxGate (.dataIn(bits64), .selectors, .dataOut(dataOut[i]));
			
		end
	endgenerate 
endmodule 