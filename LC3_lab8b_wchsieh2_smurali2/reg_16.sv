module Reg_16 (input logic Clk, Reset, Load, 
					input logic [15:0] D,
					output logic [15:0]Data_Out);
always_ff @ (posedge Clk or posedge Reset)
		
	begin
	if (Reset)	//Asynchronous Reset
		Data_Out <= 16'b0;	//First we check if the Reset input is high, if it is, we will fill the register with 0, thus resetting it.
	else if(Load)		
		Data_Out <= D; //When load is on, the data is put into the output of the register
	end
endmodule