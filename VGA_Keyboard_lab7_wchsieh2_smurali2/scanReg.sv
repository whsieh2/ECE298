module scanReg (input logic	Clk,Shift_In,Load,Shift_En, //load 
				input logic [10:0] D,
				output logic Shift_Out,
				output logic [10:0] Data_out);

always_ff @ (posedge Clk/* or posedge Load or posedge Reset*/)
begin
	if (Load)
		Data_out = D;
	else if(Shift_En)
		Data_out = {Shift_In,Data_out[10:1]};
	if(Data_out[0] == 0)
		Data_out=Data_out;
		
	Shift_Out = Data_out[0];
	
end
endmodule