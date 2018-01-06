module AdderMuxCluster(	input logic ADDR1MUX,
								input logic [1:0] ADDR2MUX,
								input logic [15:0] IRout, 
								input logic [15:0] PCout, SR1Out, 
								output logic [15:0] AdderOut);
logic [15:0] Adder1Out, Adder2Out;
								
always_comb

begin
	if(ADDR1MUX == 1'b1)
		Adder1Out <= PCout;
	else 
		Adder1Out <= SR1Out;
	
	case(ADDR2MUX)
	2'b00: 	Adder2Out <= 16'b0;
	2'b01: 	if (IRout[15])
					Adder2Out <= {10'b1111111111, IRout[5:0]};
				else
					Adder2Out <= {10'b0000000000, IRout[5:0]};
	2'b10: 	if (IRout[15])
					Adder2Out <= {7'b1111111, IRout[8:0]};
				else
					Adder2Out <= {7'b0000000, IRout[8:0]};
	2'b11: 	if (IRout[15])
					Adder2Out <= {5'b11111, IRout[10:0]};
				else
					Adder2Out <= {5'b00000, IRout[10:0]};	
	endcase			
	AdderOut = Adder1Out + Adder2Out;
end
endmodule

