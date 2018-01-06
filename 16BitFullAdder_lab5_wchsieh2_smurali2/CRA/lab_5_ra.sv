module lab_5_ra ( input [15:0] A, B,
						output [16:0] S);
			logic C4, C8, C12;
			
			logic [15:0] Anew, Bnew;
			assign Anew = {8'h0, A[7:0]};	//we use this because we are only implementing 8 bits on our DE2 boards
			assign Bnew = {8'h0, B[7:0]};
			
			ra_4 ra_4_instance_1(.*, .A(Anew[3:0]), .B(Bnew[3:0]), .S(S[3:0]), //continuously calls our ripple adder modules
			.Cin(0), .Cout(C4) );
			
			ra_4 ra_4_instance_2(.*, .A(Anew[7:4]), .B(Bnew[7:4]), .S(S[7:4]), 
			.Cin(C4), .Cout(C8) );
			
			ra_4 ra_4_instance_3(.*, .A(Anew[11:8]), .B(Bnew[11:8]), .S(S[11:8]), 
			.Cin(C8), .Cout(C12) );
			ra_4 ra_4_instance_4(.*, .A(Anew[15:12]), .B(Bnew[15:12]), .S(S[15:12]), 
			.Cin(C12), .Cout(S[16]));	

endmodule