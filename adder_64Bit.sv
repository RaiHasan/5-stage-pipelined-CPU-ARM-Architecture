
`timescale 1ns/10ps
module adder_64Bit (A, B, Out);
	input logic [63:0] A, B;
	output logic [63:0] Out;
	
	logic [63:0] carryOut;
	
	genvar i;
	
	full_adder gate (.A(A[0]),.B(B[0]),.Cin(1'b0), .Cout(carryOut[0]), .Out(Out[0]));
	
	generate 
		for(i = 1; i < 64; i++) begin : adderLoop
			full_adder m1 (.A(A[i]),.B(B[i]),.Cin(carryOut[i-1]), .Cout(carryOut[i]), .Out(Out[i]));
		end
	endgenerate 
endmodule 