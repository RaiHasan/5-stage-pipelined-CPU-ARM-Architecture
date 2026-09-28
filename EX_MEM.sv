

`timescale 1ns/10ps
// pcIN should be pcExtend and connected to current pcBy4 
module EX_MEM(reset, clk,  readData2In, aluIn, zeroIn,rdIn, pcIn, negativeIn, zeroFlagIn, overflowIn, carry_outIn,
				BranchIn, condBranchIn, loadRegIn, memReadIn, memWriteIn,
				regWriteIn, zeroSelIn, branchRegIn, branchLinkIn,
				readData2EX, aluEX, rdEX, pcEX, zeroEX, negativeEX, zeroFlagEX, overflowEX, carry_outEX,  
				BranchEX, condBranchEX, loadRegEX, memReadEX, memWriteEX,
				regWriteEX, zeroSelEX, branchRegEX, branchLinkEX);

	input logic [63:0] aluIn, pcIn, readData2In;
	
	input logic [4:0] rdIn;
	
	input logic reset, clk, zeroIn, negativeIn, zeroFlagIn, overflowIn, carry_outIn,
					BranchIn, condBranchIn, loadRegIn, memReadIn, memWriteIn,
					regWriteIn, zeroSelIn, branchRegIn, branchLinkIn;
					
	output logic [63:0] aluEX, pcEX, readData2EX;
	
	output logic [4:0] rdEX;
	
	output logic zeroEX, negativeEX, zeroFlagEX, overflowEX, carry_outEX,  
				BranchEX, condBranchEX, loadRegEX, memReadEX, memWriteEX,
				regWriteEX, zeroSelEX, branchRegEX, branchLinkEX;
	logic enable;
	
	assign enable = 1'b1;
				
	register_64Bit alu (.dataIn(aluIn), .enable, .reset, .clk, .dataOut(aluEX));
	
	register_64Bit readData2 (.dataIn(readData2In), .enable, .reset, .clk, .dataOut(readData2EX));
	
	register_64Bit pcIN  (.dataIn(pcIn), .enable, .reset, .clk, .dataOut(pcEX));
	
	register_5Bit rd (.dataIn(rdIn), .enable, .reset, .clk, .dataOut(rdEX));
	
	register_1Bit zero (.dataIn(zeroIn), .enable, .reset, .clk, .dataOut(zeroEX));
	
	register_1Bit negative (.dataIn(negativeIn), .enable, .reset, .clk, .dataOut(negativeEX));
	
	register_1Bit zeroFlag (.dataIn(zeroFlagIn), .enable, .reset, .clk, .dataOut(zeroFlagEX));
	
	register_1Bit overflow (.dataIn(overflowIn), .enable, .reset, .clk, .dataOut(overflowEX));
	
	register_1Bit carry_out (.dataIn(carry_outIn), .enable, .reset, .clk, .dataOut(carry_outEX));
	
	register_1Bit Branch (.dataIn(BranchIn), .enable, .reset, .clk, .dataOut(BranchEX));
	
	register_1Bit condBranch (.dataIn(condBranchIn), .enable, .reset, .clk, .dataOut(condBranchEX));
	
	register_1Bit loadReg (.dataIn(loadRegIn), .enable, .reset, .clk, .dataOut(loadRegEX));
	
	register_1Bit memRead (.dataIn(memReadIn), .enable, .reset, .clk, .dataOut(memReadEX));
	
	register_1Bit memWrite (.dataIn(memWriteIn), .enable, .reset, .clk, .dataOut(memWriteEX));
	
	register_1Bit regWrite (.dataIn(regWriteIn), .enable, .reset, .clk, .dataOut(regWriteEX));
	
	register_1Bit zeroSel (.dataIn(zeroSelIn), .enable, .reset, .clk, .dataOut(zeroSelEX));
	
	register_1Bit branchReg (.dataIn(branchRegIn), .enable, .reset, .clk, .dataOut(branchRegEX));
	
	register_1Bit branchLink (.dataIn(branchLinkIn), .enable, .reset, .clk, .dataOut(branchLinkEX));
	
endmodule 
				
	
	
	
				
				