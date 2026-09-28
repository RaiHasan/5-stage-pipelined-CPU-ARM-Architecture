
`timescale 1ns/10ps
module IF_ID (reset, clk, instructionIN, PCin, instructionOut, PCout, IF_ID_Write);
	input logic [31:0] instructionIN;
	input logic [63:0] PCin;
	input logic clk, reset;
	input logic IF_ID_Write;
	output logic [31:0] instructionOut;
	output logic [63:0] PCout;
	
	
	
	register_32Bit instructionReg (.dataIn(instructionIN), .enable(IF_ID_Write), .reset, 
		.clk, .dataOut(instructionOut));
	
	register_64Bit PCValReg (.dataIn(PCin), .enable(IF_ID_Write), .reset, .clk, .dataOut(PCout));

endmodule 
	
	
	
	
	
	
	
	