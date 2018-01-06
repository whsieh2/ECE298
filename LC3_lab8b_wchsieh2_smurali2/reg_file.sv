module reg_file( input logic Clk, Reset, SR2MUX,
					  input logic [1:0] DRMUX, SR1MUX,
					  input logic LD_REG,
					  inout logic [15:0] Data, 
					  input logic [15:0] IRout,
					  output logic [15:0] SR1Out, SR2Out);
					  

logic [7:0] Reg;
logic [2:0] DR, SR1, SR2;
logic [15:0] R0, R1, R2, R3, R4, R5, R6, R7;

always_ff @(posedge Clk or posedge Reset)
begin

	if(Reset)
	begin
		SR1Out <= 16'b0000000000000000;
		SR2Out <= 16'b0000000000000000;
		R0 <=  16'b0000000000000000;
		R1 <=  16'b0000000000000000;
		R2 <=  16'b0000000000000000;
		R3 <=  16'b0000000000000000;
		R4 <=  16'b0000000000000000;
		R5 <=  16'b0000000000000000;
		R6 <=  16'b0000000000000000;
		R7 <=  16'b0000000000000000;
		
	end
	
else if(LD_REG)
begin
	
	if(DRMUX == 2'b00)
		DR = IRout[11:9];
	else if(DRMUX == 2'b01)
		DR = 3'b110;
	else if (DRMUX == 2'b10)
		DR = 3'b111;
	if(SR1MUX == 2'b00)
		SR1 = IRout[11:9];
	else if(SR1MUX == 2'b01)
		SR1 = IRout[8:6];
	else if (SR1MUX == 2'b10)
		SR1 = 3'b110;
		
	if(SR2MUX)
		SR2 = 3'bZ;
	else
		SR2 = IRout[2:0];
	

	unique case(DR)
	3'b000 : Reg[0] = 1'b1;
	3'b001 : Reg[1] = 1'b1;
	3'b010 : Reg[2] = 1'b1;
	3'b011 : Reg[3] = 1'b1;
	3'b100 : Reg[4] = 1'b1;
	3'b101 : Reg[5] = 1'b1;
	3'b110 : Reg[6] = 1'b1;
	3'b111 : Reg[7] = 1'b1;
	endcase
	
	if(Reg[0])
		R0 <= Data;
	else if (Reg[1])
		R1 <= Data;
	else if (Reg[2])
		R2 <= Data;
	else if (Reg[3])
		R3 <= Data;
	else if (Reg[4])
		R4 <= Data;	
	else if (Reg[5])
		R5 <= Data;
	else if (Reg[6])
		R6 <= Data;
	else if (Reg[7])
		R7 <= Data;

		
		
/*	Reg_16 reg0(.*, .Load(Reg[0]), .D(Data), .Data_Out(R0));
	Reg_16 reg1(.*, .Load(Reg[1]), .D(Data), .Data_Out(R1));
	Reg_16 reg2(.*, .Load(Reg[2]), .D(Data), .Data_Out(R2));
	Reg_16 reg3(.*, .Load(Reg[3]), .D(Data), .Data_Out(R3));
	Reg_16 reg4(.*, .Load(Reg[4]), .D(Data), .Data_Out(R4));
	Reg_16 reg5(.*, .Load(Reg[5]), .D(Data), .Data_Out(R5));
	Reg_16 reg6(.*, .Load(Reg[6]), .D(Data), .Data_Out(R6));
	Reg_16 reg7(.*, .Load(Reg[7]), .D(Data), .Data_Out(R7));*/
	
	unique case(SR1)
	3'b000 : SR1Out = R0;
	3'b001 : SR1Out = R1;
	3'b010 : SR1Out = R2;
	3'b011 : SR1Out = R3;
	3'b100 : SR1Out = R4;
	3'b101 : SR1Out = R5;
	3'b110 : SR1Out = R6;
	3'b111 :	SR1Out = R7;
	
	endcase

	unique case(SR2)
	3'b000 : SR2Out = R0;
	3'b001 : SR2Out = R1;
	3'b010 : SR2Out = R2;
	3'b011 : SR2Out = R3;
	3'b100 : SR2Out = R4;
	3'b101 : SR2Out = R5;
	3'b110 : SR2Out = R6;
	3'b111 : SR2Out = R7;
	endcase

	end

end
endmodule
