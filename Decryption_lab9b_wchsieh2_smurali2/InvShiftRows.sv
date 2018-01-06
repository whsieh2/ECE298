module InvShiftRows(input Clk,
							 input [127:0] instate,
							 output[127:0] outstate);
logic [7:0] a00, a01, a02, a03, a10, a11, a12, a13, a20, a21, a22, a23, a30, a31, a32, a33;
	
	assign a00 = instate[7:0];
	assign a01 = instate[15:8];	
	assign a02 = instate[23:16];
	assign a03 = instate[31:24];
	assign a10 = instate[39:32];
	assign a11 = instate[47:40];
	assign a12 = instate[55:48];
	assign a13 = instate[63:56];
	assign a20 = instate[71:64];
	assign a21 = instate[79:72];
	assign a22 = instate[87:80];
	assign a23 = instate[95:88];
	assign a30 = instate[103:96];
	assign a31 = instate[111:104];
	assign a32 = instate[119:112];
	assign a33 = instate[127:120];
	
	assign outstate = {a00, a01, a02, a03, a13, a10, a11, a12, a22, a23, a20, a21, a31, a32, a33, a30};
	
endmodule