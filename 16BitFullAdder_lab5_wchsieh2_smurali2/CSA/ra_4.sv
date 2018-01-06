module ra	 (	input logic [3:0] A, B,
					output logic [3:0] S,
					input Cin,
					output Cout );
			//Ripple carry adder. Commented version in the Ripple Carry Adder implementation in the other folder.

			logic [3:0] C;
			assign C[0] = Cin;
			assign S[0] = A[0]^B[0]^C[0];
			
			assign C[1] = (A[0]&B[0])|(B[0]&C[0])|(A[0]&C[0]);
			assign S[1] = A[1]^B[1]^C[1];
			
			assign C[2] = (A[1]&B[1])|(B[1]&C[1])|(A[1]&C[1]);
			assign S[2] = A[2]^B[2]^C[2];
			
			assign C[3] = (A[2]&B[2])|(B[2]&C[2])|(A[2]&C[2]);
			assign S[3] = A[3]^B[3]^C[3];
			
			assign Cout = (A[3]&B[3])|(B[3]&C[3])|(A[3]&C[3]);
endmodule
