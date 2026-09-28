

///TEMP MODULE CHECK TO SEE IF IT IS ALLOWED OR ALLOWED IN RTL)
// rdID is regisgter in execution stage
// rdEx is register in memory stage
// rt is the register branch register wants
// aluId is alu in exectuion stage
// aluEx is alu in Mem stage

`timescale 1ns/10ps
module BR_forwarding( rdId, rdEx, regWriteId, regWriteEx, rt, aluId, aluEx, ReadData2, BR);
	input logic [4:0] rdId, rdEx, rt;
	input logic regWriteId, regWriteEx;
	input logic [63:0] aluEx, aluId, ReadData2;
	output logic [63:0] BR;
	
	logic case1,case2;
	
	always_comb begin
		case1 = 1'b0;
		case2 = 1'b0;
		if( regWriteId && (rdId != 5'd31) && (rdId == rt)) begin
			case1 = 1'b1;
		end
		
		if( regWriteEx && (rdEx != 5'd31) && (rdEx == rt)) begin
			case2 = 1'b1;
		end
	end
	
	mux_4_64_1 aluAInput (.dataIn({aluId, aluEx, aluId, ReadData2}),.selectors({case2,case1}),.dataOut(BR));
	
endmodule

		