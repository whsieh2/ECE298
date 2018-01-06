module InvAddRoundKey(input Clk,
							 input [127:0] state,
							 input [1407:0] KeySchedule,
							 input [3:0] Round,
							 output [127:0]outstate);

logic [127:0] roundkey1, roundkey2, roundkey3, roundkey4, roundkey5, roundkey6, roundkey7, roundkey8,
					roundkey9, roundkey10, roundkey11;
		assign roundkey11 = KeySchedule[127:0];
		assign roundkey10 = KeySchedule[256:128];
		assign roundkey9 = KeySchedule[384:257];
		assign roundkey8 = KeySchedule[512:385];
		assign roundkey7 = KeySchedule[640:513];
		assign roundkey6 = KeySchedule[768:641];
		assign roundkey5 = KeySchedule[896:769];
		assign roundkey4 = KeySchedule[1024:897];
		assign roundkey3 = KeySchedule[1151:1025];
		assign roundkey2 = KeySchedule[1279:1152];
		assign roundkey1 = KeySchedule[1407:1280];
		
		always_ff @ (posedge Clk)
		begin
		case(Round)
		
		4'b0000: outstate = state ^ roundkey1;
		4'b0001: outstate = state ^ roundkey2;
		4'b0010: outstate = state ^ roundkey3;
		4'b0011: outstate = state ^ roundkey4;
		4'b0100: outstate = state ^ roundkey5;
		4'b0101: outstate = state ^ roundkey6;
		4'b0110: outstate = state ^ roundkey7;
		4'b0111: outstate = state ^ roundkey8;
		4'b1000: outstate = state ^ roundkey9;
		4'b1001: outstate = state ^ roundkey10;
		4'b1010: outstate = state ^ roundkey11;
		endcase
		
end

endmodule