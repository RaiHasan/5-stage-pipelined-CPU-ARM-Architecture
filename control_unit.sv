
`timescale 1ns/10ps
// Control unit for CPU
// instructio is 11 bit signal as input
// all else are output
module control_unit(instruction, reg2Loc, Branch,
	condBranch, ALUsrc, memAddr, loadReg, memRead, memWrite, aluCtrl, setFlag,
	regWrite, zeroSel, branchReg, branchLink);
	input logic [10:0] instruction;
	output logic reg2Loc, Branch, condBranch, ALUsrc, memAddr, loadReg, memRead, memWrite,
		setFlag, regWrite, zeroSel, branchReg, branchLink;
	output logic [2:0] aluCtrl;
	
	always_comb begin
			// ADD
			if(instruction == 11'h458) begin
				reg2Loc = 1'b0;
				Branch = 1'b0;
				condBranch = 1'b0;
				ALUsrc = 1'b0;
				memAddr = 1'b0;
				loadReg = 1'b0;
				memRead = 1'b0;
				memWrite = 1'b0;
				setFlag = 1'b0;
				regWrite = 1'b1;
				zeroSel = 1'b0;
				aluCtrl = 3'b010;
				branchReg = 1'b0;
				branchLink = 1'b0;
			end
		   //ADD and Set flags
			else if(instruction == 11'h558) begin
				reg2Loc = 1'b0;
				Branch = 1'b0;
				condBranch = 1'b0;
				ALUsrc = 1'b0;
				memAddr = 1'b0;
				loadReg = 1'b0;
				memRead = 1'b0;
				memWrite = 1'b0;
				regWrite = 1'b1;
				setFlag = 1'b1;
				zeroSel = 1'b0;
				aluCtrl = 3'b010;
				branchReg = 1'b0;
				branchLink = 1'b0;
			end
			//branch to reg
			else if(instruction == 11'h6B0) begin
				reg2Loc = 1'b1;
				Branch = 1'b0;
				condBranch = 1'b0;
				ALUsrc = 1'b0;
				memAddr = 1'b0;
				loadReg = 1'b0;
				memRead = 1'b0;
				memWrite = 1'b0;
				regWrite = 1'b0;
				setFlag = 1'b0;
				zeroSel = 1'b0;
				aluCtrl = 3'b000;
				branchReg = 1'b1;
				branchLink = 1'b0;
			end
			//load to reg
			else if(instruction == 11'h7C2) begin
				reg2Loc = 1'b0;
				Branch = 1'b0;
				condBranch = 1'b0;
				ALUsrc = 1'b1;
				memAddr = 1'b1;
				loadReg = 1'b1;
				memRead = 1'b1;
				memWrite = 1'b0;
				regWrite = 1'b1;
				setFlag = 1'b0;
				zeroSel = 1'b0;
				aluCtrl = 3'b010;
				branchReg = 1'b0;
				branchLink = 1'b0;
			end
			
			//load to mem (stur)
			else if(instruction == 11'h7C0) begin
				reg2Loc = 1'b1;
				Branch = 1'b0;
				condBranch = 1'b0;
				ALUsrc = 1'b1;
				memAddr = 1'b1;
				loadReg = 1'b0;
				memRead = 1'b0;
				regWrite = 1'b0;
				memWrite = 1'b1;
				setFlag = 1'b0;
				zeroSel = 1'b0;
				aluCtrl = 3'b010;
				branchReg = 1'b0;
				branchLink = 1'b0;
			end
			
			//SUBS
			else if(instruction == 11'h758) begin
				reg2Loc = 1'b0;
				Branch = 1'b0;
				condBranch = 1'b0;
				ALUsrc = 1'b0;
				memAddr = 1'b0;
				loadReg = 1'b0;
				memRead = 1'b0;
				memWrite = 1'b0;
				setFlag = 1'b1;
				aluCtrl = 3'b011;
				zeroSel = 1'b0;
				regWrite = 1'b1;
				branchReg = 1'b0;
				branchLink = 1'b0;
			end
			
			//10 bit instruction I type
			//ADDI
			else if (instruction[10:1] == 10'b1001000100) begin
				reg2Loc = 1'b0;
				Branch = 1'b0;
				condBranch = 1'b0;
				ALUsrc = 1'b1;
				memAddr = 1'b0;
				loadReg = 1'b0;
				memRead = 1'b0;
				memWrite = 1'b0;
				setFlag = 1'b0;
				regWrite = 1'b1;
				zeroSel = 1'b0;
				aluCtrl = 3'b010;
				branchReg = 1'b0;
				branchLink = 1'b0;
			end
		//6 bit instruction B type 
			//regular branch
			else if (instruction[10:5] == 6'b000101) begin
				reg2Loc = 1'b0;
				Branch = 1'b1;
				condBranch = 1'b0;
				ALUsrc = 1'b0;
				memAddr = 1'b0;
				loadReg = 1'b0;
				memRead = 1'b0;
				memWrite = 1'b0;
				setFlag = 1'b0;
				regWrite = 1'b0;
				zeroSel = 1'b0;
				aluCtrl = 3'b001;
				branchReg = 1'b0;
				branchLink = 1'b0;
			end
			//Branch link 
			else if (instruction[10:5] == 6'b100101) begin
				reg2Loc = 1'b0;
				Branch = 1'b1;
				condBranch = 1'b0;
				ALUsrc = 1'b0;
				memAddr = 1'b0;
				loadReg = 1'b0;
				memRead = 1'b0;
				memWrite = 1'b0;
				setFlag = 1'b0;
				regWrite = 1'b1;
				zeroSel = 1'b0;
				aluCtrl = 3'b000;
				branchReg = 1'b0;
				branchLink = 1'b1;
			end
		
		//8 bit instruction CB type 
		   //branch conditional
			else if(instruction[10:3] == 8'b01010100) begin
				reg2Loc = 1'b0;
				Branch = 1'b0;
				condBranch = 1'b1;
				ALUsrc = 1'b0;
				memAddr = 1'b0;
				loadReg = 1'b0;
				memRead = 1'b0;
				memWrite = 1'b0;
				setFlag = 1'b0;
				regWrite = 1'b0;
				zeroSel = 1'b0;
				aluCtrl = 3'b001;
				branchReg = 1'b0;
				branchLink = 1'b0;
			end
			
			//branch conditional if register is zero
			else if(instruction[10:3] == 8'b10110100) begin
				reg2Loc = 1'b1;
				Branch = 1'b0;
				condBranch = 1'b1;
				ALUsrc = 1'b0;
				memAddr = 1'b0;
				loadReg = 1'b0;
				memRead = 1'b0;
				memWrite = 1'b0;
				setFlag = 1'b0;
				regWrite = 1'b0;
				zeroSel = 1'b1;
				aluCtrl = 3'b000;
				branchReg = 1'b0;
				branchLink = 1'b0;
			end
			else begin
				reg2Loc = 1'b0;
				Branch = 1'b0;
				condBranch = 1'b0;
				ALUsrc = 1'b0;
				memAddr = 1'b0;
				loadReg = 1'b0;
				memRead = 1'b0;
				memWrite = 1'b0;
				setFlag = 1'b0;
				regWrite = 1'b0;
				zeroSel = 1'b0;
				aluCtrl = 3'b001;
				branchReg = 1'b0;
				branchLink = 1'b0;
			end
				
	end
	
endmodule 

			
			