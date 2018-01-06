module MAR (input logic Clk, LD_MAR, 
				inout logic [15:0] dataIn,
				output logic [17:0] dataOut);
			
logic [15:0] MARout;			
always_ff @ (posedge Clk)
begin 
	if(LD_MAR)
	begin
		MARout <= dataIn; //When load is on, the data is put into the output of the register
	end
	else
		dataOut <= {2'b0, MARout};
end
endmodule 