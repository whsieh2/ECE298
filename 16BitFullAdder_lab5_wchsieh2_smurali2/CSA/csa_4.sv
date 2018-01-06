module csa_4	 (	input logic [3:0] A, B,
						output  logic [3:0] S,
						input Cin,
						output Cout );		//each module the carry select. It's called 3 times.
			
			logic [3:0] S0, S1; // S0 is the sum for the top adder, and S1 is the bottom
			logic [4:0] C0, C1; // Carry bits for each adder. Need an extra bit for the final carry.
			
			assign S0[0] = A[0]^B[0]^0; //adder of the least significant bit for S0
			assign S1[0] = A[0]^B[0]^1; //adder of the least significant bit for S1
			
			
			assign C0[1] = (A[0]&B[0])|(B[0]&0)|(A[0]&0);	//calculates the carry bit from the previous sum. 
			assign C1[1] = (A[0]&B[0])|(B[0]&1)|(A[0]&1);		//Takes into account the initial carry bit condition.
			assign S0[1] = A[1]^B[1]^C0[1];					//Adds the previous carry bit to the 2nd input bit. 
			assign S1[1] = A[1]^B[1]^C1[1];					//rest of code is repetition
			
			assign C0[2] = (A[1]&B[1])|(B[1]&C0[1])|(A[1]&C0[1]);
			assign C1[2] = (A[1]&B[1])|(B[1]&C1[1])|(A[1]&C1[1]);
			assign S0[2] = A[2]^B[2]^C0[2];
			assign S1[2] = A[2]^B[2]^C1[2];
			
			assign C0[3] = (A[2]&B[2])|(B[2]&C0[2])|(A[2]&C0[2]);
			assign C1[3] = (A[2]&B[2])|(B[2]&C1[2])|(A[2]&C1[2]);
			assign S0[3] = A[3]^B[3]^C0[3];
			assign S1[3] = A[3]^B[3]^C1[3];

			always_comb		//this is our 2x1 multipluxer based on the Cin value.
				case(Cin)
						1'b0: S[3:0] = S0[3:0];	//If Cin is 0, then S0 is the output sum
						1'b1: S[3:0] = S1[3:0];	//If Cin is 1, then S1 is the output sum
				endcase
				
			assign C0[4] = (A[3]&B[3])|(B[3]&C0[3])|(A[3]&C0[3]);		//last carry bit from the 4th adder.
			assign C1[4] = (A[3]&B[3])|(B[3]&C1[3])|(A[3]&C1[3]);
 			
			assign Cout = (C1[4]&Cin)|C0[4];	//Cout is the OR of the final carry bit of S0 and the AND of the final			
														//carry bit of S1 and Cin.
			
endmodule 