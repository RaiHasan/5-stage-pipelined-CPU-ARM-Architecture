
`timescale 1ns/10ps
// Raiyan Hasan 
// ECE 496 
// 7/17/26
// Single cycle CPU_single please refer to the diagram created
// Inputs
//  reset
// clk

module CPU_single (reset, clk);
	input logic reset, clk;
	
	logic [63:0] pcWire, IMAddr, ReadData1, ReadData2, regInput,
		immediateValue, aluBval, 
		aluOut, memOut, sign_extend , branchedPC,PCby4, writeDataInput;
	logic [31:0] instruction;
	logic reg2Loc, Branch, condBranch, ALUsrc, memAddr, loadReg, memRead, memWrite, setFlag,
		regWrite, negativeFlag, zeroFlag, overflowFlag, carry_outFlag, branchEnabled,
		negative, zero, overflow,carry_out,branch,brachedPC, zeroSel, branchReg, branchLink;
	logic [2:0] aluCtrl;
	logic [4:0] rd, rn, rm;
	logic [4:0] rtInput, rdInput;
	logic [11:0] aluImm;
	logic [8:0] dtAddr; 
	logic [25:0] br_address;
	logic [18:0] cond_branch;
	
	
	
	///ID_EX LOGIC
	logic [4:0] rdID, rnID, rmID;
	logic [63:0] readData1ID, readData2ID, ImmValID, pcID;
	logic [63:0] BRVal;
	
	
	
	logic BranchID, condBranchID, ALUsrcID, loadRegID, memReadID, memWriteID, setFlagID,
				regWriteID, zeroSelID, branchRegID, branchLinkID;
				
	logic [2:0] aluCtrlID;
	
	//EX_MEM LOGIC
	logic [63:0] aluEX, pcEX, readData2EX;
	
	logic [4:0] rdEX;
	
	logic zeroEX, negativeEX, zeroFlagEX, overflowEX, carry_outEX,  
				BranchEX, condBranchEX, loadRegEX, memReadEX, memWriteEX,
				regWriteEX, zeroSelEX, branchRegEX, branchLinkEX;
	//MEM_WB LOGIC
	logic memRegWB, regWriteWB;
	logic [63:0] aluWB, memDataWB;
	logic [4:0] rdWB;
	
	
	//INSTRUCTION FETCH STAGE//
	
	//Program controller
	
	logic pcWrite;
	register_64Bit PC (.dataIn(pcWire), .enable(pcWrite), .reset, .clk, .dataOut(IMAddr));
	
	//Instruction Memory 
	
	logic [31:0] instructionFetched;
	//logic [63:0] currPC;
	instructmem IM (.address(IMAddr), .instruction(instructionFetched), .clk);
	
	//PIPELINE REG IF_ID 
	logic [63:0] pcIF;
	logic IF_ID_Write;
	logic [31:0] instructionFetechedOrNOP;
	
	mux_2_64_1 nopOrIF (.out(instructionFetechedOrNOP), .in1(32'h910003FF), .in0(instructionFetched), .sel(branchEnabled));
	
	
	IF_ID ifIDReg (.reset, .clk, .instructionIN(instructionFetechedOrNOP), .PCin(IMAddr), 
		.instructionOut(instruction), .PCout(pcIF), .IF_ID_Write);
	
///////////////// IDENTIFICATION STAGE /////////////////////////

   
	assign rd = instruction[4:0];
	assign rn = instruction[9:5];
	assign rm = instruction[20:16];
	logic zeroCheck;
	
	logic controlZero;
	//Hazard Detection 
	hazard_detection stallUnit (.memReadEx(memReadID), .rdEx(rdID), .rnID(rn), .rmID(rtInput),
		.pcWrite, .IF_IDWrite(IF_ID_Write), .controlZero);
	
	//setting control to zero if need stall
	logic [10:0] controlIn;
	mux_2_11_1 zeroSet (.out(controlIn), .in1(11'd0), .in0(instruction[31:21]), .sel(controlZero));	
	
	
	//Control Unit
	control_unit CU(.instruction(controlIn), .reg2Loc, .Branch,
	.condBranch, .ALUsrc, .memAddr, .loadReg, .memRead, .memWrite, .aluCtrl, .setFlag, .regWrite, 
	.zeroSel, .branchReg, .branchLink);
	
	//Mux for RM (if Destination needs to be source)
	mux_2_5 reg2Logic (.out(rtInput), .in1(rd), .in0(rm), .sel(reg2Loc));
	
		
	

	//regfile
	regfile reggie (.ReadData1, .ReadData2, .WriteData(regInput), .ReadRegister1(rn), 
		.ReadRegister2(rtInput), .WriteRegister(rdWB), .RegWrite(regWriteWB), .clk);
				
	//Sign extender
	
	logic condORBranch;

	or #(0.05) (condORBranch, Branch, condBranch);

	sign_extender SignExtend (.instruction, .out(sign_extend), .memAddr, .branch(Branch), .condORBranch);
	
	
	equalToZero checkingIfZero (.dataIn(BRVal), .zeroCheck);
	
	// PC+signedAddress
	adder_64Bit branchAddr (.A(pcIF), .B(sign_extend), .Out(branchedPC));
	
	
	
	logic conditional;
	logic lessThan;
	logic condBranchEnabled;
	logic [63:0] pcPlusVal;
	logic negativeVal, overflowVal;
	
	mux_2_1 negativeChoser (.out(negativeVal), .in1(negative), .in0(negativeFlag), .sel(setFlagID));
	
	mux_2_1 overflowChoser (.out(overflowVal), .in1(overflow), .in0(overflowFlag), .sel(setFlagID));
	
	
	
	xor #(0.05) lessThanCheck (lessThan, overflowVal, negativeVal);
	
	mux_2_1 conditionalDeciderMux (.out(conditional), .in1(zeroCheck), .in0(lessThan), .sel(zeroSel));
	
	and #(0.05) condBranchAndGate (condBranchEnabled, conditional, condBranch);
	
	or #(0.05) muxSelector (branchEnabled, Branch, condBranchEnabled);
	 
	mux_2_64_1 branchOrFours
		(.out(pcPlusVal), .in1(branchedPC), .in0(PCby4), .sel(branchEnabled));
		
	//to decide if it will be ALUEX or MemDataOut if it is LDUR
	
	logic [63:0] aluExOrMemData;
	
	mux_2_64_1 memOrALU
		(.out(aluExOrMemData), .in1(memOut), .in0(aluEX), .sel(memReadEX));
		
	
	BR_forwarding branchRegForward (.rdId(rdID), .rdEx(rdEX), .regWriteId(regWriteID), .regWriteEx(regWriteEX),
		.rt(rtInput), .aluId(aluOut), .aluEx(aluExOrMemData), .ReadData2, .BR(BRVal));
		
		
	mux_2_64_1 branchOrRegVal
		(.out(pcWire), .in1(BRVal), .in0(pcPlusVal), .sel(branchReg));
		
	//for BranchLink	
	
	logic [63:0] linkAddress;
	
	//the PC for branch Link Instruction when fetched 
	adder_64Bit linkAddressAdder (.A(pcIF), .B(64'd4), .Out(linkAddress));
	
	logic [63:0] ReadData2RegInput;
	
	//muxes for branchLink to write to X30
	
	mux_2_64_1 regInputOrPCplus4if
		(.out(ReadData2RegInput), .in1(linkAddress), .in0(ReadData2), .sel(branchLink));
		
	mux_2_5 X30Addr (.out(rdInput), .in1(5'd30), .in0(rd), .sel(branchLink));
	

	
	//mux to decide which immidate 
///////////////// ID_EX REG /////////////////////////
	ID_EX idEXReg (.reset, .clk, .readData1In(ReadData1), .readData2In(ReadData2RegInput), 
						.ImmValIn(sign_extend), .rdIn(rdInput), .rnIn(rn), .rmIn(rtInput), .pcIn(pcIF),
						.BranchIn(Branch), .condBranchIn(condBranch), .ALUsrcIn(ALUsrc),
						.loadRegIn(loadReg), .memReadIn(memRead), .memWriteIn(memWrite),
						.aluCtrlIn(aluCtrl), .setFlagIn(setFlag),
						.regWriteIn(regWrite), .zeroSelIn(zeroSel), .branchRegIn(branchReg), .branchLinkIn(branchLink),
						.readData1ID, .readData2ID, .ImmValID, .rdID, .rnID, .rmID, .pcID,
						.BranchID, .condBranchID, .ALUsrcID, .loadRegID, .memReadID, .memWriteID,
						.aluCtrlID, .setFlagID,
						.regWriteID, .zeroSelID, .branchRegID, .branchLinkID);
						
	
///////////////// EXECUTATION STAGE /////////////////////////	
	
	//forwarding unit
	
	logic [63:0] aluA, aluB;
	
	forwarding_unit dataHazard (.aluA, .aluB,.rdMem(rdEX), .rdWB,
					.readData1(readData1ID), .readData2(readData2ID),
					.rnEX(rnID), .rmEX(rmID), .aluMem(aluEX), .aluWB(regInput), .regWriteMem(regWriteEX), .regWriteWB);
					
	logic [63:0] aluBorBranchLinked;
					
	//MUX to decide we are branchLinking or adding
	//because I guess branch Link was somehow matching some instruction 
	
	mux_2_64_1 deciderIfBL
		(.out(aluBorBranchLinked), .in1(readData2ID), .in0(aluB), .sel(branchLinkID));
	
	//Mux to decide if we need immediate or rn/rd/rt
	
	mux_2_64_1 deciderIfImm
		(.out(aluBval), .in1(ImmValID), .in0(aluBorBranchLinked), .sel(ALUsrcID));
		
		
	
	
	//Main ALU
	alu mainALU (.A(aluA), .B(aluBval), .cntrl(aluCtrlID), .result(aluOut),
		.negative, .zero, .overflow, .carry_out);
	
	// flag Register to store flags
	flagRegisters flagReg (.setFlags(setFlagID), .negativeIn(negative),
		.zeroIn(zero), .overflowIn(overflow), .carry_outIn(carry_out),
			.negative(negativeFlag), .zero(zeroFlag), .overflow(overflowFlag),
			.carry_out(carry_outFlag), .clk, .reset);
			
	
 
				
	///////////////// EX_MEM REG /////////////////////////
	EX_MEM exMEMReg (.reset, .clk,  .readData2In(aluB), .aluIn(aluOut), .zeroIn(zero),.rdIn(rdID), .pcIn(branchedPC),
				.negativeIn(negativeFlag), .zeroFlagIn(zeroFlag), .overflowIn(overflowFlag), .carry_outIn(carry_outFlag),
				.BranchIn(BranchID), .condBranchIn(condBranchID), .loadRegIn(loadRegID), .memReadIn(memReadID), .memWriteIn(memWriteID),
				.regWriteIn(regWriteID), .zeroSelIn(zeroSelID), .branchRegIn(branchRegID), .branchLinkIn(branchLinkID),
				.readData2EX, .aluEX, .rdEX, .pcEX, .zeroEX, .negativeEX, .zeroFlagEX, .overflowEX, .carry_outEX,  
				.BranchEX, .condBranchEX, .loadRegEX, .memReadEX, .memWriteEX,
				.regWriteEX, .zeroSelEX, .branchRegEX, .branchLinkEX);

//////////MEMORY STAGE/////////////////////////////////////////////

			
			
	//DataMemoryModule
		
	datamem dataMemory (.address(aluEX), .write_enable(memWriteEX),.read_enable(memReadEX),
		.write_data(readData2EX),
		.clk, .xfer_size(4'b1000), .read_data(memOut));
		
	
	
///NOT APART OF DATA MEMORY IS APART OF FETCH ONLY FOR ADDER/////////////////////////
	//PC + 4
	adder_64Bit pcPlus4 (.A(IMAddr), .B(64'd4), .Out(PCby4));
/////////////////////////////////////////////////////////////////////////////////////

////////////MEM STAGE CBZ OR B.LT CHECKER////////////////////
	
	//gone lmao
	
///////////////////MEM TO WB REGISTER PIPELINE//////////////////////////////////////

	MEM_WB memWBReg (.clk, .reset, .memDataIn(memOut), .rdIn(rdEX), .aluIn(aluEX), .memRegIn(loadRegEX), .regWriteIn(regWriteEX),
					.memDataWB, .rdWB, .aluWB, .memRegWB, .regWriteWB);
					

//mux to decide if alu goes into reg or memory goes to reg
		
	mux_2_64_1 dataWriteMux
		(.out(regInput), .in1(memDataWB), .in0(aluWB), .sel(memRegWB));
	
		
		
endmodule 
