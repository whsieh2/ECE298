module compute (input logic [2:0]	F,
					 input logic 			A_In, B_In,
					 output logic			A_Out, B_Out, F_A_B);
					 
always_comb
begin
	unique case (F)	//we realized unique case was able to accomplish the code below without any bugs. It works like a switch statement.
		3'b000: F_A_B = A_In & B_In;	//these are all the bitwise logical computations 
		3'b001: F_A_B = A_In | B_In;	//In lab 3 we used 2 4x1 multiplexers to accomplish these computations based on F2,F1,F0.
		3'b010: F_A_B = A_In ^ B_In;
		3'b011: F_A_B = 1'b1;
		3'b100: F_A_B = ~(A_In & B_In);
		3'b101: F_A_B = ~(A_In | B_In);
		3'b110: F_A_B = ~(A_In ^ B_In);
		3'b111: F_A_B = 1'b0;
		
	endcase
/*if(F=3'b000)
		F_A_B = A_In & B_In;
	else if(F==3'b001)
		F_A_B = A_In | B_In;
	else if(F==3'b010)
		F_A_B = A_In ^ B_In;
	else if(F==3'b011)
		F_A_B = 1;
	else if(F==3'b100)
		F_A_B = ~(A_In & B_In);		//a&~b should be ~(a&b)
	else if(F==3'b101)
		F_A_B = ~(A_In | B_In);
	else if(F==3'b110)
		F_A_B = ~(A_In ^ B_In);
	else if(F==3'b111)
		F_A_B = 0;
*/
end
	assign A_Out = A_In;
	assign B_Out = B_In;
endmodule	
		
		
	
