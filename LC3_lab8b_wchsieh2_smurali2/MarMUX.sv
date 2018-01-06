module MarMUX( input logic MARMUX,
					input logic [15:0] AdderOut,
					input logic [15:0] IRout,
					output logic [15:0] MarMUXOut);
always_comb
begin
	if (MARMUX)
		MarMUXOut <= {8'b0, IRout[7:0]};
	else 
		MarMUXOut <= AdderOut;
end
endmodule
