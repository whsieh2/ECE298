module GatePC( input logic GatePC,
					input logic [15:0] dataIn,
					inout [15:0] dataOut);
logic [15:0] out;
					
//always_ff @ (posedge Clk)
always_comb
begin
	if (GatePC)
		out <= dataIn;
	else
		out <= 16'bZZZZZZZZZZZZZZZZ;
end
assign dataOut = out;
endmodule