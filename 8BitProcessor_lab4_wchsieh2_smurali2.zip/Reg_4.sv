module reg_4 (input logic 			Clk, Reset, Shift_In, Load, Shift_En, 
				  input logic [7:0]	D,
				  output logic 		Shift_Out,
				  output logic [7:0]	Data_Out);
always_ff @ (posedge Clk or posedge Load or posedge Reset)
begin
	if (Reset)	//Asynchronous Reset
		Data_Out <= 8'b0;	//First we check if the Reset input is high, if it is, we will fill the register with 0, thus resetting it.
	else if(Load)		
		Data_Out <= D; //When load is on, the data is put into the output of the register
	else if(Shift_En)	//If this is on then you have the 1 input bit data from the Shift_In, and the rest from the old data.
		Data_Out <= {Shift_In, Data_Out[7:1]};

end

assign Shift_Out = Data_Out[0]; //Shift out is now assigned the least significant bit of data out.


endmodule			