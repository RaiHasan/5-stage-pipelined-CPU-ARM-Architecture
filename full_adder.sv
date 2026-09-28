`timescale 1ns/10ps
//input A 
// input B to turn into -B for subtractor)
module full_adder (A,B,Cin, Cout, Out);
	input logic A,B,Cin;
	output logic Cout, Out;
	logic AB, AC, BC;
	 
	 xor #(0.05) logicOut (Out, A, B, Cin);
	 
	 and #(0.05) gate1 (AB, A, B);
	 
	 and #(0.05) gate2 (AC, A, Cin);
	 
	 and #(0.05) gate3 (BC, B, Cin);
	 
	 or #(0.05) logicCarryOut (Cout, AB, AC, BC);
	 
endmodule 
	 
