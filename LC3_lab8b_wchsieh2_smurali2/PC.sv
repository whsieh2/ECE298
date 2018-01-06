module PC ( input logic Clk, LD_PC, Reset,
				input logic [1:0] PCMUX,
				inout logic [15:0] dataIn,
				input logic [15:0] AdderOut,
				output logic [15:0] dataOut);

logic [15:0] PCval;	
always_ff @ (posedge Clk or posedge Reset)
begin
	if (Reset)
		PCval = 16'bZZZZZZZZZZZZZZZZ;
	else if (LD_PC)
	begin
		if (PCMUX == 2'b10)
			PCval <= dataIn;
		else if (PCMUX == 2'b00)
			PCval <= PCval + 1'b1;
		else if (PCMUX == 2'b01)
			PCval <= AdderOut; 
		else 
			PCval <= PCval;
	end
	else 
		PCval <= PCval;
	
end
assign dataOut = PCval;

endmodule