module NZP(	input logic Clk, Reset, LD_CC, 
				input logic [15:0] IRout,
				output logic BEN);

logic N,Z,P;				
always_ff @ (posedge Clk or posedge Reset)
begin
	if (Reset)
	begin
		N <= 1'b0;
		Z <= 1'b0;
		P <= 1'b0;
	end
	else if (LD_CC)
	begin
		N <= 1'b0;
		Z <= 1'b0;
		P <= 1'b0;
		if(IRout[15])
			N <= 1'b1;
		else if (IRout==0)
			Z <= 1'b1;
		else
			P <= 1'b1;
	end
end
assign BEN = (IRout[11]&&N)||(IRout[10]&&Z)||(IRout[9]&&P);
endmodule