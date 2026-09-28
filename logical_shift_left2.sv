

`timescale 1ns/10ps
module logical_shift_left2 (dataIn, dataOut);
	input logic [63:0] dataIn;
	output logic [63:0] dataOut;
	
	
	assign dataOut[0] = 1'b0;
	assign dataOut[1] = 1'b0;
	
	genvar i;
	
	generate 
		for(i=2; i < 64; i++) begin : shiftLoop
			assign dataOut[i] = dataIn[i-2];
		end
	endgenerate
endmodule 
	
	