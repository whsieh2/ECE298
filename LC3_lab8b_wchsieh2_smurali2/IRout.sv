module IR(input logic Clk, LD_IR, Reset,
				inout logic [15:0] dataIn,
				output logic [15:0] dataOut);
logic [15:0] IRval;

always_ff @ (posedge Clk or posedge Reset)
begin
	if (Reset)
		IRval = 16'bZZZZZZZZZZZZZZZZ;
	else if (LD_IR)
		IRval <= dataIn;
	else 
		IRval<=IRval;
end

assign dataOut = IRval;

endmodule