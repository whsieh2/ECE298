module GateMDR ( input logic GateMDR,
					  input logic [15:0]dataIn,
					  inout [15:0]dataOut);
					
//always_ff @ (posedge Clk)
logic [15:0] out;
					
//always_ff @ (posedge Clk)
always_comb
begin
	if (GateMDR)
		out <= dataIn;
	else
		out <= 16'bZZZZZZZZZZZZZZZZ;
end
assign dataOut = out;
endmodule