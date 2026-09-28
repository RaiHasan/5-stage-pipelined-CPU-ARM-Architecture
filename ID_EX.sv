
`timescale 1ns/10ps
module ID_EX(reset, clk, readData1In, readData2In, ImmValIn, rdIn, rnIn, rmIn, pcIn,
				BranchIn, condBranchIn, ALUsrcIn, loadRegIn, memReadIn, memWriteIn, aluCtrlIn, setFlagIn,
				regWriteIn, zeroSelIn, branchRegIn, branchLinkIn,
				readData1ID, readData2ID, ImmValID, rdID, rnID, rmID, pcID,
				BranchID, condBranchID, ALUsrcID, loadRegID, memReadID, memWriteID, aluCtrlID, setFlagID,
				regWriteID, zeroSelID, branchRegID, branchLinkID);
			
	input logic [63:0] readData1In, readData2In, ImmValIn, pcIn;
	input logic [4:0] rdIn, rnIn, rmIn;
	input logic BranchIn, condBranchIn, ALUsrcIn, loadRegIn, memReadIn, memWriteIn, setFlagIn,
					regWriteIn, zeroSelIn, branchRegIn, branchLinkIn, reset, clk;
					
	input logic [2:0] aluCtrlIn;
	
	output logic [63:0] readData1ID, readData2ID, ImmValID, pcID;
	
	output logic [4:0] rdID, rnID, rmID;
	
	output logic BranchID, condBranchID, ALUsrcID, loadRegID, memReadID, memWriteID, setFlagID,
				regWriteID, zeroSelID, branchRegID, branchLinkID;
				
	output logic [2:0] aluCtrlID;
	
	logic enable;
	
	assign enable = 1'b1;
	
	register_3Bit aluReg (.dataIn(aluCtrlIn), .enable, .reset, .clk, .dataOut(aluCtrlID));
	
	register_64Bit readData1 (.dataIn(readData1In), .enable, .reset, .clk, .dataOut(readData1ID));
	
	register_64Bit readData2 (.dataIn(readData2In), .enable, .reset, .clk, .dataOut(readData2ID));
	
	register_64Bit pcIN  (.dataIn(pcIn), .enable, .reset, .clk, .dataOut(pcID));
	
	register_64Bit immVal  (.dataIn(ImmValIn), .enable, .reset, .clk, .dataOut(ImmValID));
	
	register_5Bit rd (.dataIn(rdIn), .enable, .reset, .clk, .dataOut(rdID));
	
	register_5Bit rn (.dataIn(rnIn), .enable, .reset, .clk, .dataOut(rnID));
	
	register_5Bit rm (.dataIn(rmIn), .enable, .reset, .clk, .dataOut(rmID));
	
	register_1Bit Branch (.dataIn(BranchIn), .enable, .reset, .clk, .dataOut(BranchID));
	
	register_1Bit condBranch (.dataIn(condBranchIn), .enable, .reset, .clk, .dataOut(condBranchID));
	
	register_1Bit ALUsrc (.dataIn(ALUsrcIn), .enable, .reset, .clk, .dataOut(ALUsrcID));
	
	register_1Bit loadReg (.dataIn(loadRegIn), .enable, .reset, .clk, .dataOut(loadRegID));
	
	register_1Bit memRead (.dataIn(memReadIn), .enable, .reset, .clk, .dataOut(memReadID));
	
	register_1Bit memWrite (.dataIn(memWriteIn), .enable, .reset, .clk, .dataOut(memWriteID));
	
	register_1Bit setFlag (.dataIn(setFlagIn), .enable, .reset, .clk, .dataOut(setFlagID));
	
	register_1Bit regWrite (.dataIn(regWriteIn), .enable, .reset, .clk, .dataOut(regWriteID));
	
	register_1Bit zeroSel (.dataIn(zeroSelIn), .enable, .reset, .clk, .dataOut(zeroSelID));
	
	register_1Bit branchReg (.dataIn(branchRegIn), .enable, .reset, .clk, .dataOut(branchRegID));
	
	register_1Bit branchLink (.dataIn(branchLinkIn), .enable, .reset, .clk, .dataOut(branchLinkID));
	
endmodule 
	
	
	
	
	
	
	
	
	
	
	
	
	
				
	

	
				