

`timescale 1ns/10ps
module forwarding_unit(aluA, aluB,rdMem, rdWB, readData1, readData2,
	rnEX, rmEX, aluMem, aluWB, regWriteMem, regWriteWB);
	input logic [4:0] rdMem, rdWB, rnEX, rmEX;
	input logic [63:0]  readData1, readData2,  aluMem, aluWB;
	input logic regWriteMem, regWriteWB;
	output logic [63:0] aluA, aluB;
	
	logic case1rn, case2rn, case1rm, case2rm;
	
	always_comb begin
		case1rn = 1'b0;
		case2rn = 1'b0;
		case1rm = 1'b0;
		case2rm = 1'b0;
		
		if(regWriteMem && (rdMem != 5'd31) && (rdMem == rnEX)) begin
			case1rn = 1'b1;
		end
		
		if(regWriteMem && (rdMem != 5'd31) && (rdMem == rmEX)) begin
			case1rm = 1'b1;
		end
		
		if(regWriteWB && (rdWB != 5'd31) && (rdWB == rnEX)) begin
			case2rn = 1'b1;
		end
		
		if(regWriteWB && (rdWB != 5'd31) && (rdWB == rmEX)) begin
			case2rm = 1'b1;
		end
	end
	
	//rn
	mux_4_64_1 aluAInput (.dataIn({aluMem, aluMem, aluWB, readData1}),.selectors({case1rn,case2rn}),.dataOut(aluA));
	
	//rm or rd
	
	mux_4_64_1 aluBInput (.dataIn({aluMem, aluMem, aluWB, readData2}),.selectors({case1rm,case2rm}),.dataOut(aluB));
endmodule 
	
		

		
		
		
		
		 
		