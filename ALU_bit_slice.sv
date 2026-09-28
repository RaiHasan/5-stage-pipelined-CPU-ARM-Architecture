

`timescale 1ns/10ps

// ALU bit slice
// Note doesn't include any flags
// Handeles all the bit operations of control
module ALU_bit_slice (Abit, Bbit, carryIn, ctrl, result, carryOut);
	input logic Abit, Bbit, carryIn;
	input logic [2:0] ctrl;
	output logic result, carryOut;
	
	logic xorResult, andResult, orResult, bAddInput, adderVal;
	
	xor #(0.05) xorGate (xorResult, Abit, Bbit);
	
	and #(0.05) andGate (andResult, Abit, Bbit);
	
	or #(0.05) orGate (orResult, Abit, Bbit);
	
	xor #(0.05) bXor (bAddInput, Bbit, ctrl[0]);
	
	full_adder adderModule (.A(Abit),.B(bAddInput),.Cin(carryIn), .Cout(carryOut), .Out(adderVal));
	
	mux_8_1 selector (.dataIn({1'b0, xorResult, orResult, andResult, adderVal, adderVal, 1'b0, Bbit})
		,.selectors(ctrl), .dataOut(result));
	
	
	//{1'b0, xorResult, orResult, andResult, adderVal, adderVal, 1'b0, B}
endmodule 
	
	
	
	