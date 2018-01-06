module dflip(input  logic Clk, Reset, D, Load,
			    output logic Q);

always @ (posedge Clk or posedge Reset) 
	begin 
		if (Reset) 
			Q = 1'b0;
		else if (Load) 
			Q = D;
	end
	
endmodule
