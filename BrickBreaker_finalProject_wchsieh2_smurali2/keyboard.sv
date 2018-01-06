module keyboard(input  logic Clk, psClk, psData, Reset,
					 output logic [6:0] sR1hexU, sR2hexU, sR1hexL, sR2hexL,
					 output logic [7:0] keyCode, sR2data,
					 output logic 		  clockenable);
	
	logic [8:0]  dCounter;
	logic 		 Q1, Q2, shiftEnable;
	logic [10:0] sR1out, sR2out;
	logic [7:0]  keyData;
	
	// Signal conditioning and synchronizing buffer
	always_ff @ (posedge Clk or posedge Reset)
		begin
			if (Reset)
				begin
				dCounter <= 9'b0;
				clockenable <= 1'b0;
				end
			else if (dCounter == 9'b11111111)
				begin
				dCounter <= 9'b0;
				clockenable <= ~clockenable;
				end
			else
				dCounter <= dCounter + 1'b1;
		end
	//dClk dividedClk(.Clk(Clk), .Reset(Reset), .dClock(dClock));
	dflip DFF1(.Clk(Clk), .Reset(Reset), .D(psClk), .Load(clockenable), .Q(Q1));
	dflip DFF2(.Clk(Clk), .Reset(Reset), .D(Q1), .Load(clockenable), .Q(Q2));
	
	assign shiftEnable = Q2 & (~Q1);
	
	// Scan registers, when sR2 is F0, sR1 will give the key pressed
	scanReg scanRegister1(.Clk(Clk), .Reset(Reset), .Din(psData), 
								 .shiftEn(shiftEnable), .Data_Out(sR1out));
	scanReg scanRegister2(.Clk(Clk), .Reset(Reset), .Din(sR1out[0]), 
								 .shiftEn(shiftEnable), .Data_Out(sR2out));
	// Display current keyboard input
	HexDriver HexSR1U(.In0(sR1out[8:5]), .Out0(sR1hexU));
	HexDriver HexSR2U(.In0(sR2out[8:5]), .Out0(sR2hexU));
	HexDriver HexSR1L(.In0(sR1out[4:1]), .Out0(sR1hexL));
	HexDriver HexSR2L(.In0(sR2out[4:1]), .Out0(sR2hexL));
	
	// Process data from scan registers
	assign keyCode = sR1out[8:1];
	assign sR2data = sR2out[8:1];


endmodule