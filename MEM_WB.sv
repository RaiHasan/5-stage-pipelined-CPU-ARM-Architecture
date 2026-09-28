`timescale 1ns/10ps
module MEM_WB(clk, reset, memDataIn, rdIn, aluIn, memRegIn,regWriteIn,
					memDataWB, rdWB, aluWB, memRegWB,regWriteWB);

	input logic memRegIn, clk, reset, regWriteIn;
	input logic [63:0] aluIn, memDataIn;
	input logic [4:0] rdIn;
	
	output logic memRegWB, regWriteWB;
	output logic [63:0] aluWB, memDataWB;
	output logic [4:0] rdWB;
	
	logic enable;
	
	assign enable = 1'b1;
	
	register_64Bit alu (.dataIn(aluIn), .enable, .reset, .clk, .dataOut(aluWB));
	
	register_64Bit memData (.dataIn(memDataIn), .enable, .reset, .clk, .dataOut(memDataWB));
	
	register_1Bit regWrite (.dataIn(regWriteIn), .enable, .reset, .clk, .dataOut(regWriteWB));
	
	register_1Bit memReg (.dataIn(memRegIn), .enable, .reset, .clk, .dataOut(memRegWB));
	
	register_5Bit rd (.dataIn(rdIn), .enable, .reset, .clk, .dataOut(rdWB));
endmodule 
	

	
	
	
	
	
	