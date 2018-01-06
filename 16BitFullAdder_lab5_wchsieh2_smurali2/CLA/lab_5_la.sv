module lab_5_la ( input [15:0] A, B,
						output [16:0] S, P, G);
			logic C4, C8, C12;
			
			logic [15:0] Anew, Bnew;
			assign Anew = {8'h0, A[7:0]};	//use this because we only use 8 bits for our DE2 board
			assign Bnew = {8'h0, B[7:0]};
			
			la_4 la_4_instance_1(.*, .A(Anew[3:0]), .B(Bnew[3:0]), .S(S[3:0]), .P(P[3:0]), .G(G[3:0]), //repeatedly calls the look ahead modules
			.Cin(0), .Cout(C4) );
			la_4 la_4_instance_2(.*, .A(Anew[7:4]), .B(Bnew[7:4]), .S(S[7:4]), .P(P[7:4]), .G(G[7:4]), 
			.Cin(C4), .Cout(C8) );
			
			la_4 la_4_instance_3(.*, .A(Anew[11:8]), .B(Bnew[11:8]), .S(S[11:8]), .P(P[11:8]), .G(G[11:8]),
			.Cin(C8), .Cout(C12) );
			la_4 la_4_instance_4(.*, .A(Anew[15:12]), .B(Bnew[15:12]), .S(S[15:12]), .P(P[15:12]), .G(G[15:12]),
			.Cin(C12), .Cout(S[16]));	

endmodule