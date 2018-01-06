module lab_5_csa ( input [15:0] A, B,
						output [16:0] S);
			logic C4, C8, C12;	//Used logically for each module's Cout.
			
			logic [15:0] Anew, Bnew;	//Used because we can only access 8 bits on the DE2 board.
			assign Anew = {8'h0, A[7:0]};
			assign Bnew = {8'h0, B[7:0]};
			
			ra ra_instance_1(.*, .A(Anew[3:0]), .B(Bnew[3:0]), .S(S[3:0]), //CSA uses a ripple carry adder for the first 4 bits.
			.Cin(0), .Cout(C4) );
			
			csa_4 csa_4_instance_2(.*, .A(Anew[7:4]), .B(Bnew[7:4]), .S(S[7:4]), //First CSA module, calls this 2 more times s.
			.Cin(C4), .Cout(C8) );																//with different inputs.
			
			csa_4 csa_4_instance_3(.*, .A(Anew[11:8]), .B(Bnew[11:8]), .S(S[11:8]), 
			.Cin(C8), .Cout(C12) );
			
			csa_4 csa_4_instance_4(.*, .A(Anew[15:12]), .B(Bnew[15:12]), .S(S[15:12]), 
			.Cin(C12), .Cout(S[16]));	

			
endmodule
