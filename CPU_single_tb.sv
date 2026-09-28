
`timescale 1ns/10ps
module CPU_single_tb();
	logic reset, clk;
	
	parameter ClockDelay = 20;	
	CPU_single dut (.*);
	
	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

	initial $timeformat(-9, 2, " ns", 10);
	
	logic [63:0] mem0, mem8, mem16;
	
	initial begin
	/*	$display("ARM Test One");
		reset <= 1'b1; @(posedge clk);
		 reset <= 1'b0; @(posedge clk);
		 //#10000000;
		 repeat(9) @(posedge clk);
	  assert (dut.reggie.registerOut[0] === 64'd0) begin 
			$display("X0 is correct");
		end else begin
				$display("X0 is incorrect, should be 0, got %d",dut.reggie.registerOut[0]);
		end
		
		assert(dut.reggie.registerOut[1] === 64'd1) begin
			$display("X1 is correct");
		end else begin
			$display("X1 is incorrect, should be 0, got %d",dut.reggie.registerOut[1]);
		end
		assert (dut.reggie.registerOut[2] === 64'd2) begin
			$display("X2 is correct");
		end else begin
			$display("X2 is incorrect, should be 0, got %d",dut.reggie.registerOut[2]);
		end
		assert (dut.reggie.registerOut[3] === 64'd3) begin
			$display("X3 is correct");
		end else begin
			$display("X3 is incorrect, should be 0, got %d",dut.reggie.registerOut[3]);
		end
		assert (dut.reggie.registerOut[4] === 64'd4) begin
			$display("X4 is correct"); 
		end else begin
			$display("X4 is incorrect, should be 0, got %d",dut.reggie.registerOut[4]);
		end
	*/	

	/*	$display("ARM TEST TWO SUBS and Flags");
		reset <= 1'b1; @(posedge clk);
		reset <= 1'b0; @(posedge clk);
		repeat (30) @(posedge clk);
		assert (dut.reggie.registerOut[0] == 64'd1
				&& dut.reggie.registerOut[1] == -64'd1 
				&& dut.reggie.registerOut[2] == 64'd2
				&& dut.reggie.registerOut[3] == -64'd3 
				&& dut.reggie.registerOut[4] == -64'd2
				&& dut.reggie.registerOut[5] == -64'd5
				&& dut.reggie.registerOut[6] == 64'd0 
				&& dut.reggie.registerOut[7] == -64'd6
				&& dut.negativeFlag == 1'b1
				&& dut.carry_outFlag == 1'b1) begin
					$display("All values is correct"); 
		end else begin
			$display("X0 should be 1 got %d",dut.reggie.registerOut[0]);
			$display("X1 should be -1 got %d",dut.reggie.registerOut[1]);
			$display("X2 should be 2 got %d",dut.reggie.registerOut[2]);
			$display("X3 should be -3 got %d",dut.reggie.registerOut[3]);
			$display("X4 should be -2 got %d",dut.reggie.registerOut[4]);
			$display("X5 should be -5 got %d",dut.reggie.registerOut[5]);
			$display("x6 should be 0 got %d",dut.reggie.registerOut[6]);
			$display("X7 should be -6 got %d",dut.reggie.registerOut[7]);
			$display("Negative flag should be true %b", dut.negativeFlag);
			$display("Carry_out flag should be true %b", dut.carry_outFlag);
		end
	*/


	
   	/*$display("ARM TEST THREE CBZ and B and ADDi");
				reset <= 1'b1; @(posedge clk);
				reset <= 1'b0; @(posedge clk);
				repeat (80) @(posedge clk);
				assert (dut.reggie.registerOut[0] == 64'd1
						&& dut.reggie.registerOut[1] == 64'd0 
						&& dut.reggie.registerOut[2] == 64'd4
						&& dut.reggie.registerOut[3] == 64'd1 
						&& dut.reggie.registerOut[4] == 64'd31
						&& dut.reggie.registerOut[5] == 64'd0) begin
							$display("All values is correct"); 
				end else begin
					$display("X0 should be 1 got %d",dut.reggie.registerOut[0]);
					$display("X1 should be 0 got %d",dut.reggie.registerOut[1]);
					$display("X2 should be 4 got %d",dut.reggie.registerOut[2]);
					$display("X3 should be 1 got %d",dut.reggie.registerOut[3]);
					$display("X4 should be 31 got %d",dut.reggie.registerOut[4]);
					$display("X5 should be 0 got %d",dut.reggie.registerOut[5]);
				end
			*/



	/*	$display("ARM TEST FOUR LDUR and STUR");
					reset <= 1'b1; @(posedge clk);
					reset <= 1'b0; @(posedge clk);
					repeat (20) @(posedge clk);
					assign mem0 = {
						 dut.dataMemory.mem[7],
						 dut.dataMemory.mem[6],
						 dut.dataMemory.mem[5],
						 dut.dataMemory.mem[4],
						 dut.dataMemory.mem[3],
						 dut.dataMemory.mem[2],
						 dut.dataMemory.mem[1],
						 dut.dataMemory.mem[0]
					};
					
					assign mem8 = {
						 dut.dataMemory.mem[15],
						 dut.dataMemory.mem[14],
						 dut.dataMemory.mem[13],
						 dut.dataMemory.mem[12],
						 dut.dataMemory.mem[11],
						 dut.dataMemory.mem[10],
						 dut.dataMemory.mem[9],
						 dut.dataMemory.mem[8]
					};
					
					assign mem16 = {
						 dut.dataMemory.mem[23],
						 dut.dataMemory.mem[22],
						 dut.dataMemory.mem[21],
						 dut.dataMemory.mem[20],
						 dut.dataMemory.mem[19],
						 dut.dataMemory.mem[18],
						 dut.dataMemory.mem[17],
						 dut.dataMemory.mem[16]
					};
					
				assert (dut.reggie.registerOut[0] == 64'd1
				&& dut.reggie.registerOut[1] == 64'd2 
				&& dut.reggie.registerOut[2] == 64'd3
				&& dut.reggie.registerOut[3] == 64'd8 
				&& dut.reggie.registerOut[4] == 64'd11
				&& dut.reggie.registerOut[5] == 64'd1
				&& dut.reggie.registerOut[6] == 64'd2 
				&& dut.reggie.registerOut[7] == 64'd3
				&& mem0 == 64'd1
				&& mem8 == 64'd2
				&& mem16 == 64'd3) begin
					$display("All values is correct"); 
		end else begin
			$display("X0 should be 1 got %d",dut.reggie.registerOut[0]);
			$display("X1 should be 2 got %d",dut.reggie.registerOut[1]);
			$display("X2 should be 3 got %d",dut.reggie.registerOut[2]);
			$display("X3 should be 8 got %d",dut.reggie.registerOut[3]);
			$display("X4 should be 11 got %d",dut.reggie.registerOut[4]);
			$display("X5 should be 1 got %d",dut.reggie.registerOut[5]);
			$display("x6 should be 2 got %d",dut.reggie.registerOut[6]);
			$display("X7 should be 3 got %d",dut.reggie.registerOut[7]);
			$display("mem0 should be 1 %d", mem0);
			$display("mem8 should be 2 %d", mem8);
			$display("mem16 should be 3 %d", mem16);
		end
	*/

	/*	$display("ARM TEST FIVE B.LT and SUBS");
			reset <= 1'b1; @(posedge clk);
			reset <= 1'b0; @(posedge clk);
			repeat (30) @(posedge clk);
			assert (dut.reggie.registerOut[0] == 64'd1
					&& dut.reggie.registerOut[1] == 64'd1)begin
						$display("All values is correct"); 
			end else begin
				$display("X0 should be 1 got %d",dut.reggie.registerOut[0]);
				$display("X1 should be 1 got %d",dut.reggie.registerOut[1]);
			end
		*/

	/*	$display("ARM TEST SIX BL and Br");
			reset <= 1'b1; @(posedge clk);
			reset <= 1'b0; @(posedge clk);
			repeat (60) @(posedge clk);
			assert (dut.reggie.registerOut[0] == 64'd1
					&& dut.reggie.registerOut[1] == 64'd0 
					&& dut.reggie.registerOut[2] == 64'd0
					&& dut.reggie.registerOut[3] == 64'd1 
					&& dut.reggie.registerOut[4] == 64'd52
					&& dut.reggie.registerOut[5] == 64'd64
					&& dut.reggie.registerOut[29] == 64'd20
					&& dut.reggie.registerOut[30] == 64'd68) begin
						$display("All values is correct"); 
			end else begin
				$display("X0 should be 1 got %d",dut.reggie.registerOut[0]);
				$display("X1 should be 0 got %d",dut.reggie.registerOut[1]);
				$display("X2 should be 0 got %d",dut.reggie.registerOut[2]);
				$display("X3 should be 1 got %d",dut.reggie.registerOut[3]);
				$display("X4 should be 52 got %d",dut.reggie.registerOut[4]);
				$display("X5 should be 64 got %d",dut.reggie.registerOut[5]);
				$display("X29 should be 20 got %d",dut.reggie.registerOut[29]);
				$display("X30 should be 68 got %d",dut.reggie.registerOut[30]);
			end
		*/



		/*$display("ARM TEST 10 forward");
			reset <= 1'b1; @(posedge clk);
			reset <= 1'b0; @(posedge clk);
			repeat (90) @(posedge clk);
			assign mem0 = {
						 dut.dataMemory.mem[7],
						 dut.dataMemory.mem[6],
						 dut.dataMemory.mem[5],
						 dut.dataMemory.mem[4],
						 dut.dataMemory.mem[3],
						 dut.dataMemory.mem[2],
						 dut.dataMemory.mem[1],
						 dut.dataMemory.mem[0]
					};
			assign mem8 = {
						 dut.dataMemory.mem[15],
						 dut.dataMemory.mem[14],
						 dut.dataMemory.mem[13],
						 dut.dataMemory.mem[12],
						 dut.dataMemory.mem[11],
						 dut.dataMemory.mem[10],
						 dut.dataMemory.mem[9],
						 dut.dataMemory.mem[8]
					};
					
			assert (dut.reggie.registerOut[0] == 64'd0
					&& dut.reggie.registerOut[1] == 64'd8 
					&& dut.reggie.registerOut[2] == 64'd4
					&& dut.reggie.registerOut[3] == 64'd5 
					&& dut.reggie.registerOut[4] == 64'd7
					&& dut.reggie.registerOut[5] == 64'd2
					&& dut.reggie.registerOut[6] == -64'd2
					&& dut.reggie.registerOut[7] == -64'd2
					&& dut.reggie.registerOut[8] == 64'd0
					&& dut.reggie.registerOut[9] == 64'd1
					&& dut.reggie.registerOut[10] == -64'd4
					&& dut.reggie.registerOut[14] == 64'd5
					&& dut.reggie.registerOut[15] == 64'd8
					&& dut.reggie.registerOut[16] == 64'd9
					&& dut.reggie.registerOut[17] == 64'd1
					&& dut.reggie.registerOut[18] == 64'd99
					&& mem0 == 64'd8
					&& mem8 == 64'd5) begin
						$display("All values is correct"); 
			end else begin
				$display("X0 should be 0 got %d",dut.reggie.registerOut[0]);
				$display("X1 should be 8 got %d",dut.reggie.registerOut[1]);
				$display("X2 should be 4 got %d",dut.reggie.registerOut[2]);
				$display("X3 should be 5 got %d",dut.reggie.registerOut[3]);
				$display("X4 should be 7 got %d",dut.reggie.registerOut[4]);
				$display("X5 should be 2 got %d",dut.reggie.registerOut[5]);
				$display("X6 should be -2 got %d",dut.reggie.registerOut[6]);
				$display("X7 should be -2 got %d",dut.reggie.registerOut[7]);
				$display("X8 should be 0 got %d",dut.reggie.registerOut[8]);
				$display("X9 should be 1 got %d",dut.reggie.registerOut[9]);
				$display("X10 should be -4 got %d",dut.reggie.registerOut[10]);
				$display("X14 should be 5 got %d",dut.reggie.registerOut[14]);
				$display("X15 should be 8 got %d",dut.reggie.registerOut[15]);
				$display("X16 should be 9 got %d",dut.reggie.registerOut[16]);
				$display("X17 should be 1 got %d",dut.reggie.registerOut[17]);
				$display("X18 should be 99 got %d",dut.reggie.registerOut[18]);
			end
		*/
	



	/*$display("ARM TEST 11 sort");
			reset <= 1'b1; @(posedge clk);
			reset <= 1'b0; @(posedge clk);
			repeat (850) @(posedge clk);
			assert (dut.reggie.registerOut[11] == 64'd1
					&& dut.reggie.registerOut[12] == 64'd2 
					&& dut.reggie.registerOut[13] == 64'd3
					&& dut.reggie.registerOut[14] == 64'd4 
					&& dut.reggie.registerOut[15] == 64'd5
					&& dut.reggie.registerOut[16] == 64'd6
					&& dut.reggie.registerOut[17] == 64'd7
					&& dut.reggie.registerOut[18] == 64'd8
					&& dut.reggie.registerOut[19] == 64'd9
					&& dut.reggie.registerOut[20] == 64'd10) begin
						$display("All values is correct"); 
			end else begin
				$display("X11 should be 1 got %d",dut.reggie.registerOut[11]);
				$display("X12 should be 2 got %d",dut.reggie.registerOut[12]);
				$display("X13 should be 3 got %d",dut.reggie.registerOut[13]);
				$display("X14 should be 4 got %d",dut.reggie.registerOut[14]);
				$display("X15  should be 5 got %d",dut.reggie.registerOut[15]);
				$display("X16  should be 6 got %d",dut.reggie.registerOut[16]);
				$display("X17 should be 7 got %d",dut.reggie.registerOut[17]);
				$display("X18 should be 8 got %d",dut.reggie.registerOut[18]);
				$display("X19 should be 9 got %d",dut.reggie.registerOut[19]);
				$display("X20 should be 10 got %d",dut.reggie.registerOut[20]);
			end
		*/



		 $display("ARM TEST FIBS");
			reset <= 1'b1; @(posedge clk);
			reset <= 1'b0; @(posedge clk);
			repeat (400) @(posedge clk);
			assert (dut.reggie.registerOut[0] == 64'd6
					&& dut.reggie.registerOut[1] == 64'd8 
					&& dut.reggie.registerOut[28] == 64'd8
					&& dut.reggie.registerOut[30] == 64'd196) begin
						$display("All values is correct"); 
			end else begin
				$display("X0 should be 6 got %d",dut.reggie.registerOut[0]);
				$display("X1 should be 8 got %d",dut.reggie.registerOut[1]);
				$display("X28 should be 8 got %d",dut.reggie.registerOut[28]);
				$display("X30 should be 196 got %d",dut.reggie.registerOut[30]);
			end
		


			





		




		
					

	
			
					
				
				
				
			
		
		
		
		
		 $stop;
	end
endmodule

		