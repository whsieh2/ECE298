module MDR(input logic Clk, LD_MDR, Reset,
				inout logic  [15:0] dataIn,
				output logic [15:0] dataOut);
logic[15:0] MDRout;
always_ff @ (posedge Clk or posedge Reset)
		
	begin
	if (Reset)	//Asynchronous Reset
		MDRout <= 16'bZZZZZZZZZZZZZZZZ;	//First we check if the Reset input is high, if it is, we will fill the register with 0, thus resetting it.
	else if(LD_MDR)		
		MDRout <= dataIn; //When load is on, the data is put into the output of the register
	else
		MDRout <=16'bZZZZZZZZZZZZZZZZ;
	end
assign dataOut = MDRout;
endmodule
