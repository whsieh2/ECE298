module keyBoard (input Clk, ps2clock, data,
						output logic [2:0]outData,
						output logic [10:0]dataOut0, 
						output logic  [3:0]dataOut0a,
						output logic  [3:0]dataOut0b
							);
	//W- Up ( make- 1D; break F0,1D)
	//S - Down ( make - 1B; break F0,1B)
	//A - Left ( make - 1C; break F0, 1C)
	//D - Right ( make - 2D; break F0, 2D)
	// 2- Hex bits are recieved at a time.

	logic Q1, Q2, Shift_En, newClk, bin1, bin2 ,Load;
	logic [10:0]dataOut1;
	logic [7:0]keyData;
	
	divClk divClk1(.*, .Clock(Clk), .newclk(newClk));
	
	//DFF DFF1 (.*, .Clk(newClk), .D(ps2clock), .REps2(Q));
	DFF DFF1 (.*, .Clk(newClk), .D(ps2clock), .Q(Q1));
	DFF DFF2 (.*, .Clk(newClk), .D(Q1), .Q(Q2));

		
	assign Shift_En = Q2&(~Q1); //if it's 1, this is a falling edge, this we should shift the data.
	//assign REpsClk = (Q1^Q2)&Q1; //if it's 1, this is a rising edge.
	//The above is used to know when the clock starts falling on the falling edge so we can start collecting data/decoding.

	
	scanReg instance_One (.Clk(Q),.Shift_In(data), .Load(0), .Shift_En(Shift_En), .D(D), .Shift_Out(bin1) ,.Data_out(dataOut0));

	scanReg instance_Two (.Clk(Q),.Shift_In(bin1), .Load(0), .Shift_En(Shift_En), .D(dataOut0), .Shift_Out(bin2) ,.Data_out(dataOut1));


	//scanReg instance_one(.Clock(Clk),.Shift_En(Shift_En), .Din(data), .Data_out(dataOut0));//11 bit shift register with shift en - clk, din, shiften, output of 11 bits. if 2nd one is f0, look at the first one for hte value of the pressed key.
	//scanReg instance_two(.Clock(Clk),.Shift_En(Shift_En), .Din(dataOut0), .Data_out(dataOut1));
	always_ff @ (posedge Q)
	begin
		if(dataOut1[8:1] == 8'b11110000) //if the data is F0
			keyData[7:0] = dataOut0[8:1];
			dataOut0a[3:0] = dataOut0[4:1];
			dataOut0b[3:0] = dataOut0[8:5];
	end		
	
	always_ff @ (posedge Q)
	begin
	case (keyData)
		8'b00011101 : outData = 3'b000; //W(up)
		8'b00011011 : outData = 3'b001; //S(down)
		8'b00011100 : outData = 3'b010; //A(left)
		8'b00101101 : outData = 3'b011; //D(right)
		default: outData = 3'b111;
	endcase
	end	


	
	
	/*	always_ff @ (posedge Clk)
	begin
	if (Reset)
		Data_out = 8'b00000000;
	else if (Load)
		Data_out = D;
	else if (Shift_En)
		Data_out = {Shift_In,Data_out[7:1]};
	//else Data_out = Data_out;
	Shift_Out = Data_out[0];
	end
	q1
	
			if([8:1]data = 8'b11110000; //if the data is F0
				assign [7:0]keyData = [8:1]data;
				
	always_ff @ (posedge Clk)
		if (FEpsClk)
			begin
				do 
					shiftData = {Shift_In,shiftData[10:0]};
				while([8:1]data != 8'b11110000); //if the data is F0
				Data_out = {Shift_In,Data_out[7:1]};
				assign [7:0]keyData = [8:1]data;
				
			end
		end
		*/

endmodule 
		
	