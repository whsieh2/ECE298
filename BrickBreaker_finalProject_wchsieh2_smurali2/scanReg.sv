module scanReg(input  logic Clk, Reset, Din, shiftEn,
					output logic [10:0] Data_Out);

always_ff @ (posedge Clk or posedge Reset)
	begin
		if (Reset)
			Data_Out <= 11'b0;
		else if (shiftEn)
			Data_Out <= {Din, Data_Out[10:1]};
	end

endmodule
		