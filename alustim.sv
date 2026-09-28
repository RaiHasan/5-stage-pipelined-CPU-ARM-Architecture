// Test bench for ALU
`timescale 1ns/10ps

// Meaning of signals in and out of the ALU:

// Flags:
// negative: whether the result output is negative if interpreted as 2's comp.
// zero: whether the result output was a 64-bit zero.
// overflow: on an add or subtract, whether the computation overflowed if the inputs are interpreted as 2's comp.
// carry_out: on an add or subtract, whether the computation produced a carry-out.

// cntrl			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant

module alustim();

	parameter delay = 100000;

	logic		[63:0]	A, B;
	logic		[2:0]		cntrl;
	logic		[63:0]	result;
	logic					negative, zero, overflow, carry_out ;

	parameter ALU_PASS_B=3'b000, ALU_ADD=3'b010, ALU_SUBTRACT=3'b011, ALU_AND=3'b100, ALU_OR=3'b101, ALU_XOR=3'b110;
	

	alu dut (.A, .B, .cntrl, .result, .negative, .zero, .overflow, .carry_out);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	integer i;
	logic [63:0] test_val;
	initial begin
	
		$display("%t testing PASS_A operations", $time);
		cntrl = ALU_PASS_B;
		for (i=0; i<100; i++) begin
			A = $random(); B = $random();
			#(delay);
			assert(result == B && negative == B[63] && zero == (B == '0));
		end
		
		$display("%t testing addition", $time);
		cntrl = ALU_ADD;
		A = 64'h0000000000000001; B = 64'h0000000000000001;
		#(delay);
		assert(result == 64'h0000000000000002 && carry_out == 0 && overflow == 0 && negative == 0 && zero == 0);
		
		//adding negative values
		$display("%t testing addition with subtraction", $time);
		cntrl = ALU_SUBTRACT;
		A = 64'd3; B = 64'd10;
		#(delay);
		assert(result == -64'd7 && negative == 1'b1 && zero == 1'b0) begin
			$display("%t passed 3 - 10 = result=%d", $time, $signed(result));
		end else begin 
			$display("%t fail result=%d", $time,$signed(result));
		end 
		#(delay);
		
		//testing zero with subtraction to zero 
		$display("%t testing subtraction to zero", $time);
		cntrl = ALU_SUBTRACT;
		A = 64'd100; B = 64'd100;
		#(delay);
		assert(result == 64'd0 && negative == 1'b0 && zero == 1'b1) begin
			$display("%t passed 100 - 100 = result=%d", $time, $signed(result));
		end else begin 
			$display("%t fail result=%d", $time, $signed(result));
		end 
		#(delay);
		
		
		//testing zero with subtraction of positive numbers 
		$display("%t testing subtraction of positive", $time);
		cntrl = ALU_SUBTRACT;
		A = 64'd1050; B = 64'd49;
		#(delay);
		assert(result == 64'd1001 && negative == 1'b0 && zero == 1'b0) begin
			$display("%t passed 1050 - 49 = result=%d", $time, $signed(result));
		end else begin 
			$display("%t fail result=%d", $time, $signed(result));
		end 
		#(delay);
		
		//testing subtraction overflow 
		$display("%t testing subtraction overflow", $time);
		cntrl = ALU_SUBTRACT;
		A = -64'd3; B = 64'd9223372036854775807;
		#(delay);
		assert(negative == result[63] && zero == 1'b0 && overflow == 1'b1) begin
			$display("overflow occured %t", $time, $signed(result));
		end else begin 
			$display("%t fail result=%d", $time, $signed(result));
		end 
		#(delay);
		
		//testing carry_out 
		
		$display("%t testing subtraction carry_out", $time);
		cntrl = ALU_SUBTRACT;
		A = 64'd5; B = 64'd3;
		#(delay);
		assert(result == 64'd2 && negative == 1'b0 && zero == 1'b0 && carry_out == 1'b1) begin
			$display("%t passed carry_out result=%d", $time, $signed(result));
		end else begin 
			$display("%t fail result=%d", $time, $signed(result));
		end 
		#(delay);
		
		//testing no carry_out
		
		$display("%t testing subtraction no carry_out", $time);
		cntrl = ALU_SUBTRACT;
		A = 64'd2; B = 64'd4;
		#(delay);
		assert(result == -64'd2 && negative == 1'b1 && zero == 1'b0 && carry_out == 1'b0) begin
			$display("%t passed no carry out carry_out result=%d", $time, $signed(result));
		end else begin 
			$display("%t fail result=%d", $time, $signed(result));
		end 
		#(delay);
		
		//testing additon with subtraction 
		$display("%t testing subtraction no carry_out", $time);
		cntrl = ALU_SUBTRACT;
		A = 64'd20; B = -64'd4;
		#(delay);
		assert(result == 64'd24 && negative == 1'b0 && zero == 1'b0) begin
			$display("%t passed 20 - -4 = result=%d", $time, $signed(result));
		end else begin 
			$display("%t fail result=%d", $time, $signed(result));
		end 
		#(delay);
		
		////////////////// adding check 
		
		//add check 
		
		$display("%t testing addition with negatives", $time);
		cntrl = ALU_ADD;
		A = -64'd10; B = -64'd15;
		#(delay);
		assert(result == -64'd25 && negative == 1'b1 && zero == 1'b0) begin
			$display("%t passed -10 + -15 = result=%d", $time, $signed(result));
		end else begin 
			$display("%t fail result=%d", $time,$signed(result));
		end 
		#(delay);
		
		
		
		//
		$display("%t testing addition to zero and carry out test ", $time);
		cntrl = ALU_ADD;
		A = -64'd10; B = 64'd10;
		#(delay);
		assert(result == 64'd0 && negative == 1'b0 && zero == 1'b1 && carry_out == 1'b1) begin
			$display("%t passed -10 + 10 = result=%d", $time, $signed(result));
		end else begin 
			$display("%t fail result=%d", $time,$signed(result));
		end 
		#(delay);
		
		
		//
		$display("%t testing addition no carry out test", $time);
		cntrl = ALU_ADD;
		A = 64'd20; B = 64'd30;
		#(delay);
		assert(result == 64'd50 && negative == 1'b0 && zero == 1'b0 && carry_out == 1'b0) begin
			$display("%t passed 20 + 30 = result=%d", $time, $signed(result));
		end else begin 
			$display("%t fail result=%d", $time,$signed(result));
		end 
		#(delay);
		
		$display("%t testing addition no carry out test", $time);
		cntrl = ALU_ADD;
		A = 64'd20; B = 64'd30;
		#(delay);
		assert(result == 64'd50 && negative == 1'b0 && zero == 1'b0 && carry_out == 1'b0) begin
			$display("%t passed 20 + 30 = result=%d", $time, $signed(result));
		end else begin 
			$display("%t fail result=%d", $time,$signed(result));
		end 
		#(delay);
		
		
		//testing addition overflow 
		$display("%t testing additon overflow", $time);
		cntrl = ALU_ADD;
		A = 64'd30909124; B = 64'd9223372036854775807;
		#(delay);
		assert(negative == result[63] && zero == 1'b0 && overflow == 1'b1) begin
			$display("overflow occured %t", $time, $signed(result));
		end else begin 
			$display("%t fail result=%d", $time, $signed(result));
		end 
		#(delay);
		
		
		//general AND testcase 
		$display("%t general AND testcase", $time);
		cntrl = ALU_AND;
		A = 64'd10; B = 64'd10;
		#(delay);
		assert(result == (64'd10 & 64'd10) && zero == 1'b0) begin
			$display("result is correctly AND  %t", $time, $signed(result));
		end else begin 
			$display("%t fail result=%d", $time, $signed(result));
		end 
		#(delay);
		
		
		$display("%t general AND testcase", $time);
		cntrl = ALU_AND;
		A = 64'd10; B = 64'd12;
		#(delay);
		assert(result == (64'd10 & 64'd12) && zero == 1'b0) begin
			$display(" %t result is correctly AND", $time, $signed(result));
		end else begin 
			$display("%t fail result=%d", $time, $signed(result));
		end 
		#(delay);
		
		$display("%t zero AND testcase", $time);
		cntrl = ALU_AND;
		A = 64'h00F0F; B = 64'hFF0F0;
		#(delay);
		assert(result == 64'd0 && zero == 1'b1) begin
			$display("%t result is correctly zero result=%d", $time, $signed(result));
		end else begin 
			$display("%t fail result=%d", $time, $signed(result));
		end 
		#(delay);
		
		
		$display("%t negative AND testcase", $time);
		cntrl = ALU_AND;
		A = 64'h800000000000010F; B = 64'h800100000000000F;
		#(delay);
		assert(zero == 1'b0 && negative == 1'b1) begin
			$display("%t result is correctly negative result=%h", $time, (result));
		end else begin 
			$display("%t fail result=%d", $time, $signed(result));
		end 
		#(delay);
		
		
		$display("%t general OR testcase", $time);
		cntrl = ALU_OR;
		A = -64'd10; B = 64'd130;
		#(delay);
		assert(result == (A | B)) begin
			$display("%t result is correctly or'd result=%d", $time, $signed(result));
		end else begin 
			$display("%t fail result=%d", $time, $signed(result));
		end 
		#(delay);
		
		//can only be zero if everything is zero
		$display("%t zero OR testcase", $time);
		cntrl = ALU_OR;
		A = 64'd0; B = 64'd0;
		#(delay);
		assert(result == (64'd0 | 64'd0) && zero == 1'b1) begin
			$display("%t result is correctly or'd and zero result=%d", $time, $signed(result));
		end else begin 
			$display("%t fail result=%d", $time, $signed(result));
		end 
		#(delay);
		
		
		
		$display("%t or Negative test testcase", $time);
		cntrl = ALU_OR;
		A = -64'd1; B = 64'd0;
		#(delay);
		assert(result == (-64'd1 | 64'd0) && negative == 1'b1) begin
			$display("%t result is correctly or'd and negative result=%d", $time, $signed(result));
		end else begin 
			$display("%t fail result=%d", $time, $signed(result));
		end 
		#(delay);
		
		$display("%t general OR testcase all 1's", $time);
		cntrl = ALU_OR;
		A = '1; B = '1;
		#(delay);
		assert(result == (A | B)) begin
			$display("%t result is correctly or'd result=%d", $time, $signed(result));
		end else begin 
			$display("%t fail result=%d", $time, $signed(result));
		end 
		#(delay);
		
		
		$display("%t general XOR testcase", $time);
		cntrl = ALU_XOR;
		A = 64'd105; B = 64'd30;
		#(delay);
		assert(result == (64'd105 ^ 64'd30)) begin
			$display("%t result is correctly xor'd result=%d", $time, $signed(result));
		end else begin 
			$display("%t fail result=%d", $time, $signed(result));
		end 
		#(delay);
		
		
		$display("%t zero XOR testcase", $time);
		cntrl = ALU_XOR;
		A = 64'hA000000000000A00; B = 64'hA000000000000A00;
		#(delay);
		assert(result == (64'h0) && zero == 1'b1 ) begin
			$display("%t result is correctly xor'd result=%h", $time, $signed(result));
		end else begin 
			$display("%t fail result=%h", $time, $signed(result));
		end 
		#(delay);
		
		
		$display("%t negative XOR testcase", $time);
		cntrl = ALU_XOR;
		A = '0; B = '1;
		#(delay);
		assert(result == (A^B) && negative == 1'b1) begin
			$display("%t result is correctly xor'd result=%h", $time, $signed(result));
		end else begin 
			$display("%t fail result=%h", $time, $signed(result));
		end 
		#(delay);
		
		
		
		$display("%t random tests of everything", $time);
		for (i=0; i<100; i++) begin
			cntrl = $urandom_range(0, 7); 
			A = $random(); B = $random();
			case (cntrl)
				3'b000: test_val = B;
				3'b001: test_val = 64'd0;
				3'b010: test_val = A+B;
				3'b011: test_val = A-B;
				3'b100: test_val = A & B;
				3'b101: test_val = A | B;
				3'b110: test_val = A ^ B;
				3'b111: test_val = 64'd0;
			endcase 
			
				
			#(delay);
			assert(result == test_val) 
			else begin
				$display("%t fail result=%d, cntrl set to cntrl=%b", $time, result, cntrl);
		 end
		end
		
		
	end
endmodule
