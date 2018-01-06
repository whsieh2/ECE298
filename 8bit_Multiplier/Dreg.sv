module Dreg ( input logic Clk, Load, Reset, D,
				  output logic Q);
always @ (posedge Clk) 
begin 
	Q = Q; //hold
	if (Reset) 
		Q = 1'b0;
	else if (Load)
		Q = D;
end
endmodule