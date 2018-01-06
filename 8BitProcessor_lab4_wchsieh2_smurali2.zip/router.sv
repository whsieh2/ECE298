module router (input logic [1:0]	R,
					input logic 		A_In, B_In, F_A_B,
					output logic		A_Out, B_Out);
					
always_comb
begin
	unique case (R)
		2'b00	:A_Out=A_In;		//This is our 4x1 multiplexer. Based on R1, R0, 
		2'b01	:A_Out=A_In;		//the output will be A, B, or a bitwise relationship between the two.
		2'b10	:A_Out=F_A_B;
		2'b11	:A_Out=B_In;
	endcase
	/*if(R==2'b00)
		A_Out = A_In;
	else if (R==2'b01)
		A_Out = A_In;
	else if (R==2'b10)
		A_Out = F_A_B;
	else if (R==2'b11) //originally 1'11 <= i changed it on the bottom too
		A_Out = B_In;*/
end			
always_comb
begin
	unique case (R)
		2'b00	:B_Out=B_In;	
		2'b01	:B_Out=F_A_B;
		2'b10	:B_Out=B_In;
		2'b11	:B_Out=A_In;
	endcase
	/*
	if(R==2'b00)
		B_Out = B_In;
	else if (R==2'b01)
		B_Out = F_A_B;
	else if (R==2'b10)
		B_Out = B_In;
	else if (R==2'b11)
		B_Out = A_In;*/
end
endmodule
		