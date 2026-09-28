`timescale 1ns/10ps
// result, negative, zero, overflow, carry_out are flags outputs
module flagRegisters (setFlags, negativeIn, zeroIn, overflowIn, carry_outIn,
							negative, zero, overflow, carry_out, clk, reset);
	input logic setFlags, negativeIn, zeroIn, overflowIn, carry_outIn, clk, reset;
	output logic negative, zero, overflow, carry_out;
	
	logic negativeFlag, zeroFlag, overflowFlag, carry_outFlag;
	
	//Negative register
	mux_2_1 enableNegative (.out(negativeFlag), .in1(negativeIn), 
				.in0(negative), .sel(setFlags)); 
	D_FF negativeReg (.q(negative), .d(negativeFlag), .reset, .clk);
	
	//Zero register
	mux_2_1 enableZero (.out(zeroFlag), .in1(zeroIn), 
				.in0(zero), .sel(setFlags)); 
	D_FF zeroReg (.q(zero), .d(zeroFlag), .reset, .clk);
	
	//Overflow register
	mux_2_1 enableOverflow (.out(overflowFlag), .in1(overflowIn), 
				.in0(overflow), .sel(setFlags)); 
	D_FF overflowReg (.q(overflow), .d(overflowFlag), .reset, .clk);
	
	//carry_out register
	mux_2_1 Enablecarry_out (.out(carry_outFlag), .in1(carry_outIn), 
				.in0(carry_out), .sel(setFlags)); 
	D_FF carry_outReg (.q(carry_out), .d(carry_outFlag), .reset, .clk);
	
endmodule 


							
	