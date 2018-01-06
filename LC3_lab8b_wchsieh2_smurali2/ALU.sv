module ALU( input logic  [15:0] A_In, SR2Out, IRSext, 
				input logic Control, 
				input logic  [1:0]  F,
				output logic [15:0] F_A_B);
logic [15:0] B_In;
always_comb
begin
	if (Control)
	begin
		if (IRSext[15])
			B_In <= {11'b11111111111, IRSext[4:0]};
		else
			B_In <= {11'b00000000000, IRSext[4:0]};
	end
	else
		B_In <= SR2Out;
		
	begin
		unique case(F)							//Not too sure about the order of the bits of ALUK.
		2'b00	: F_A_B = A_In + B_In;
		2'b01	: F_A_B = A_In & B_In;
		2'b10	: F_A_B = ~A_In;
		2'b11	: F_A_B = A_In;
		endcase
	end
end	
endmodule
