module reg_8 (input logic	Clk, Reset,Shift_In,Load,Shift_En,
			  input logic [7:0] D,
			  output logic Shift_Out,
			  output logic [7:0] Data_out);

always_ff @ (posedge Clk/* or posedge Load or posedge Reset*/)
begin
	if (Reset)
		Data_out = 8'b00000000;
	else if (Load)
		Data_out = D;
	else if (Shift_En)
		Data_out = {Shift_In,Data_out[7:1]};
	//else Data_out = Data_out;
	Shift_Out = Data_out[0];
end
endmodule