module ra_4	 (	input [3:0] A, B,
					output [3:0] S,
					input Cin,
					output Cout );
			
			logic [3:0] C;
			assign C[0] = Cin;	//the carry in bit 
			assign S[0] = A[0]^B[0]^C[0];		//sums the first bit of A, B, C
			
			assign C[1] = (A[0]&B[0])|(B[0]&C[0])|(A[0]&C[0]);		//To see if the sum above causes a carry bit to exist
			assign S[1] = A[1]^B[1]^C[1];
			
			assign C[2] = (A[1]&B[1])|(B[1]&C[1])|(A[1]&C[1]);	//rest is repeat
			assign S[2] = A[2]^B[2]^C[2];
			
			assign C[3] = (A[2]&B[2])|(B[2]&C[2])|(A[2]&C[2]);
			assign S[3] = A[3]^B[3]^C[3];
			
			assign Cout = (A[3]&B[3])|(B[3]&C[3])|(A[3]&C[3]);		//keeps track is this modules last carry bit
	
endmodule
