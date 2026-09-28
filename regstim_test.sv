

// Test bench for Register file
`timescale 1ns/10ps

module regstim_test(); 		

	parameter ClockDelay = 5000;

	logic	[4:0] 	ReadRegister1, ReadRegister2, WriteRegister;
	logic [63:0]	WriteData;
	logic 			RegWrite, clk;
	logic [63:0]	ReadData1, ReadData2;

	integer i;

	// Your register file MUST be named "regfile".
	// Also you must make sure that the port declarations
	// match up with the module instance in this stimulus file.
	regfile dut (.ReadData1, .ReadData2, .WriteData, 
					 .ReadRegister1, .ReadRegister2, .WriteRegister,
					 .RegWrite, .clk);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

	initial begin
			
			//Tests to see if 31 is zero.
			RegWrite <= 0; ReadRegister1 <= 5'd0; ReadRegister2 <= 5'd0; 
				WriteRegister <= 5'd0; WriteData <= 64'd0; @(posedge clk);
				
			RegWrite <= 1; ReadRegister1 <= 5'd0; ReadRegister2 <= 5'd0; 
				WriteRegister <= 5'd31; WriteData <= 64'd469; @(posedge clk);
				
			RegWrite <= 1; ReadRegister1 <= 5'd31; ReadRegister2 <= 5'd0; 
				WriteRegister <= 5'd31; WriteData <= 64'd76981; @(posedge clk);
				
			RegWrite <= 1; ReadRegister1 <= 5'd31; ReadRegister2 <= 5'd0; 
				WriteRegister <= 5'd31; WriteData <= 64'd4012; repeat(2) @(posedge clk);
				
			RegWrite <= 0; ReadRegister1 <= 5'd31; ReadRegister2 <= 5'd10; 
				WriteRegister <= 5'd10; WriteData <= 64'd4012; @(posedge clk);
				
			RegWrite <= 0; ReadRegister1 <= 5'd31; ReadRegister2 <= 5'd10; 
				WriteRegister <= 5'd10; WriteData <= 64'd4012; @(posedge clk);
				
			RegWrite <= 1; ReadRegister1 <= 5'd31; ReadRegister2 <= 5'd10; 
				WriteRegister <= 5'd10; WriteData <= 64'd4012; @(posedge clk);
			
			RegWrite <= 0; ReadRegister1 <= 5'd10; ReadRegister2 <= 5'd11; 
				WriteRegister <= 5'd10; WriteData <= 64'd4012; @(posedge clk);
				
			RegWrite <= 0; ReadRegister1 <= 5'd10; ReadRegister2 <= 5'd11; 
				WriteRegister <= 5'd10; WriteData <= 64'd4012; @(posedge clk);	
		
			RegWrite <= 1; ReadRegister1 <= 5'd10; ReadRegister2 <= 5'd11; 
				WriteRegister <= 5'd11; WriteData <= 64'd7012; @(posedge clk);
			
			RegWrite <= 1; ReadRegister1 <= 5'd10; ReadRegister2 <= 5'd11; 
				WriteRegister <= 5'd23; WriteData <= 64'd4501; @(posedge clk);
			
		  RegWrite <= 1; ReadRegister1 <= 5'd11; ReadRegister2 <= 5'd23; 
				WriteRegister <= 5'd0; WriteData <= 64'd0012; @(posedge clk);
		
			RegWrite <= 0; ReadRegister1 <= 5'd2; ReadRegister2 <= 5'd0; 
				WriteRegister <= 5'd0; WriteData <= 64'd0012; @(posedge clk);
			
		$stop;
	end
endmodule
