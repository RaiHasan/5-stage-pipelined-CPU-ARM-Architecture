`timescale 1ns/10ps
// default value will be aluImm
module sign_extender (instruction, out, memAddr, branch, condORBranch);
	input logic [31:0] instruction;
	input logic memAddr, branch, condORBranch;
	output logic [63:0] out;
	
	logic [63:0] aluExtend, DTaddrExtend, condBranchExtend, branchExtend;
	logic [63:0] aluOrMem, condORBranchVal;
	
	assign aluExtend = {52'b0, instruction[21:10]};
	assign DTaddrExtend = {{55{instruction[20]}}, instruction[20:12]};
	assign branchExtend = {{36{instruction[25]}},instruction[25:0], 2'b0};
	assign condBranchExtend = {{43{instruction[23]}}, instruction[23:5], 2'b0}; 
	
	mux_2_64_1 selectALUOrMemAddr (.out(aluOrMem), .in1(DTaddrExtend), .in0(aluExtend), .sel(memAddr));
	
	mux_2_64_1 selectBranchOrCond (.out(condORBranchVal), .in1(branchExtend), .in0(condBranchExtend), .sel(branch));
	
	mux_2_64_1 selectOut (.out, .in1(condORBranchVal), .in0(aluOrMem), .sel(condORBranch));
	
endmodule 
	
	
	
	