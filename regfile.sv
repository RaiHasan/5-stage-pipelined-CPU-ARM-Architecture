`timescale 1ns/10ps
//Raiyan Hasan ECE 469
// 7/3/2026
// A regfile that holds 32 65 bit registers
// Register 31 is reserved for 0 and will always be 0
// inputs
// 64 bit writeData: Data to write to a register
// 5 bit ReadRegister1, ReadRegister2, WriteRegister: Selects the register to write and read
// note if you write to a register wait a clock cycle for it to be able to be read
// RegWrite: Is true if you want to overwrite the data in the selected register via writeRegister
// output:
// 64 bit readRegister1 and 2: reads the ouput of two different registers at the same time
// chosen by the input above.  
module regfile(ReadData1, ReadData2,WriteData, ReadRegister1, 
	ReadRegister2, WriteRegister, RegWrite, clk);
	
	input logic	[4:0] 	ReadRegister1, ReadRegister2, WriteRegister;
	input logic [63:0]	WriteData;
	input logic 			RegWrite, clk;
	output logic [63:0]	ReadData1, ReadData2;
	
	wire [31:0] enableSignals;
	
	wire [31:0][63:0] registerOut;
	
	
	decoder5_32 enableSignalDecoder (.dataInput(RegWrite), .selectors(WriteRegister),
		.dataOutput(enableSignals));
		
	genvar i;
	
	generate
		for(i = 0; i < 31; i++) begin : registerLoop
			register_64Bit register (.dataIn(WriteData), .enable(enableSignals[i]),
				.reset(1'b0), .clk, .dataOut(registerOut[i]));
		end
	endgenerate 

	assign registerOut[31] = 64'b0;
	
	//output for the chosen mux
	logic [63:0] ReadData1True;
	logic [63:0] ReadData2True;
	mux64_32 readOne (.dataIn(registerOut), .selectors(ReadRegister1), .dataOut(ReadData1True));
	
	mux64_32 readTwo (.dataIn(registerOut), .selectors(ReadRegister2), .dataOut(ReadData2True));
	
	// Fixing read and write data issue
	//COMEBACK AND FIX RTL PROTOTYPE 
	
//	always_comb begin
//		ReadData1 = ReadData1True;
//		ReadData2 = ReadData2True;
//		if(ReadRegister1 != 31'd31 && (ReadRegister1 == WriteRegister)) begin
//			ReadData1 = WriteData;
//		end
//		
//		if(ReadRegister2 != 32'd31 && (ReadRegister2 == WriteRegister)) begin
//			ReadData2 = WriteData;
//		end
//	end

	//checking to see if either registers are x31 
	
	logic rd1x31Check;
	logic rd2x31Check;
	
	//for x31 check
	logic rd1Intermediate;
	logic rd2Intermediate;
	
	and #(0.05) (rd1Intermediate, ReadRegister1[0],ReadRegister1[1],ReadRegister1[2],ReadRegister1[3]);
	
	and #(0.05) (rd1x31Check,rd1Intermediate, ReadRegister1[4]);
	
	and #(0.05) (rd2Intermediate, ReadRegister2[0],ReadRegister2[1],ReadRegister2[2],ReadRegister2[3]);
	
	and #(0.05) (rd2x31Check,rd2Intermediate, ReadRegister2[4]);
	
	// check to see if they are equal to write register
	logic [4:0] rd1SameCheck; // this has to be all 1's for them to be equal
	logic [4:0] rd2SameCheck; 
	
	logic rd1SameInter;
	logic rd2SameInter;
	
	logic rd1Same;
	logic rd2Same;
	
	genvar k;
	
	generate
		for(k = 0; k < 5; k++) begin : equalCheck1
			xnor #(0.05) (rd1SameCheck[k], ReadRegister1[k], WriteRegister[k]);
		end
	endgenerate 
	
	and #(0.05) gate1 (rd1SameInter,rd1SameCheck[0],rd1SameCheck[1],rd1SameCheck[2],rd1SameCheck[3]);
	
	and #(0.05) gate2 (rd1Same,rd1SameInter,rd1SameCheck[4]);
	
	
	genvar j;
	
	generate
		for(j = 0; j < 5; j++) begin : equalCheck2
			xnor #(0.05) gate3 (rd2SameCheck[j], ReadRegister2[j], WriteRegister[j]);
		end
	endgenerate 
	
	and #(0.05) gate4 (rd2SameInter,rd2SameCheck[0],rd2SameCheck[1],rd2SameCheck[2],rd2SameCheck[3]);
	
	and #(0.05) gate5 (rd2Same,rd2SameInter,rd2SameCheck[4]);
	
	logic changeRead1;
	
	logic changeRead2;
	
	logic rd1x31Inverse;
	
	logic rd2x31Inverse;
	
	not #(0.05) gate6 (rd1x31Inverse, rd1x31Check);
	
	not #(0.05) gate7 (rd2x31Inverse, rd2x31Check);
	
	and #(0.05) gate8 (changeRead1, rd1x31Inverse,rd1Same, RegWrite);
	
	and #(0.05) gate9 (changeRead2, rd2x31Inverse,rd2Same, RegWrite);
	
	mux_2_64_1 readOut1 (.out(ReadData1), .in1(WriteData), .in0(ReadData1True), .sel(changeRead1));
	
	mux_2_64_1 readOut2 (.out(ReadData2), .in1(WriteData), .in0(ReadData2True), .sel(changeRead2));

		
	
endmodule 
		
		
	
	