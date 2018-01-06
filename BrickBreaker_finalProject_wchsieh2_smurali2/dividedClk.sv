module dClk(input  logic Clk, Reset,
				output logic [8:0] dClock);

	always_ff @ (posedge Clk or posedge Reset)
		begin
			if (Reset)
				dClock <= 9'b0;
			else if (dClock == 9'b11111111)
				dClock <= 9'b0;
			else
				dClock <= dClock + 1'b1;
		end

endmodule