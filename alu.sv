

`timescale 1ns/10ps
//Raiyan Hasan ECE 469
// 7/9/2026
// ALU that has two 64 bit inputs that do operations on them  
// inputs
// A and B 64 bits
// cntrl			Operation						
// 000:			result = B						
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		
// 101:			result = bitwise A | B		
// 110:			result = bitwise A XOR B
// if not stated result will be set to 0;
// outputs:
// result 64 bit: the result of the operation selected
// flags:
// negative: MSB is 1
// zero: Result is zero
// overflow (for addition and subtraction): overflowed occured in 64 bits
// carryout (for add and sub): There is a carryout from the 64'th bit that is 
//                              connected to the flag result
module alu (A, B, cntrl, result, negative, zero, overflow, carry_out);
	input logic	[63:0]	A, B;
	input logic	[2:0]		cntrl;
	output logic	[63:0]	result;
	output logic	negative, zero, overflow, carry_out;
	
	logic [63:0] carryOutResult;
	
	
	logic [15:0] zeroCheck;
	
	logic [3:0] andOut;
	
	
	ALU_bit_slice firstBit (.Abit(A[0]), .Bbit(B[0]), .carryIn(cntrl[0]), .ctrl(cntrl),
		.result(result[0]), .carryOut(carryOutResult[0]));
		
	genvar i;
	
	generate
		for (i = 1; i < 64; i ++) begin : aluLoop
			ALU_bit_slice m (.Abit(A[i]), .Bbit(B[i]), .carryIn(carryOutResult[i-1]), .ctrl(cntrl),
				.result(result[i]), .carryOut(carryOutResult[i]));
		end
	endgenerate 
	
	assign carry_out = carryOutResult[63];
	
	xor #(0.05) xorGate (overflow, carryOutResult[62], carryOutResult[63]);

	assign negative = result[63];
	
	//Zero check
	genvar j;
	generate
		for (j = 0; j < 16; j++) begin : norLoop
			nor #(0.05) norGate (zeroCheck[j], result[4*j+3], result[4*j+2], result[4*j+1], result[4*j]);
		end
	endgenerate 
	
	// and check to carry the signals
	genvar k;
	generate
		for (k = 0; k < 4; k++) begin : andLoop
			and #(0.05) andGate (andOut[k], zeroCheck[4*k+3],  zeroCheck[4*k+2],  zeroCheck[4*k+1], zeroCheck[4*k]);
		end
	endgenerate 
	
	and #(0.05) finalGate (zero, andOut[3], andOut[2], andOut[1], andOut[0]);

	
	
endmodule
	
	