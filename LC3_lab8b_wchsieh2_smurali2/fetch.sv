module fetch (input logic Clk, Reset, Run, Continue,
					output logic CE, UB, LB, OE, WE,
					output logic [17:0] ADDR,
					output logic [15:0] IRout,
					output logic [11:0] LED,
					inout [15:0] bus);	// top level
		//wire [15:0] bus;
		logic [15:0] MDRout, PCout, AdderOut;
		logic	LD_MAR,LD_MDR,LD_IR, LD_BEN,LD_CC,LD_REG,LD_PC;		
		logic GatePC,GateMDR,GateALU,	GateMARMUX;				
		logic [1:0] PCMUX, DRMUX ,SR1MUX;
		logic SR2MUX, ADDR1MUX;
		logic [1:0] ADDR2MUX;
		logic MARMUX, BEN;
		logic [1:0] ALUK;
		logic [15:0] SR1Out, SR2Out, ALUout, MarMUXOut;
		
		//Reg_16 Reg_hi(.*, .Load(Continue), .D(bus), .Data_Out(IRout));
			
		IR IR_one(.Clk(Clk), .LD_IR(LD_IR), .Reset(Reset), .dataIn(bus), .dataOut(IRout));
		
		ISDU ISDU_mod(.*, .Clk(Clk), .Reset(Reset), .Continue(Continue), .Opcode(IRout[15:12]), .IR_5(IRout[5]), //changed .ContinueIR to .Continue
					.BEN(BEN), .LD_MAR(LD_MAR), .LD_MDR(LD_MDR), .LD_IR(LD_IR), .LD_BEN(LD_BEN),.LD_CC(LD_CC), .LD_REG(LD_REG),.LD_PC(LD_PC),
					.GatePC(GatePC),.Mem_CE(CE), .Mem_UB(UB),.Mem_LB(LB),.Mem_OE(OE),.Mem_WE(WE) );
	
									
				
		reg_file Register_File(.*, .Data(bus));
	
		NZP nzp(.*);

		AdderMuxCluster Cluster_One(.*);
		
		MarMUX MAR_MUX_STUFF(.*);
		
		GateMarMUX Gate_MARMUX(.*, .dataIn(MarMUXOut),.dataOut(bus));
					
		
		ALU ALU_STUFF(.A_In(SR1Out), .SR2Out(SR2Out), .IRSext(IRout), .Control(SR2MUX),.F(ALUK),.F_A_B(ALUout));
		
		GateALU GateALU_one(.*, .dataIn(ALUout),.dataOut(bus));
		
		PC PC_mod (.*,.dataIn(bus),.dataOut(PCout));

		GatePC GatePC_mod(.*, .dataIn(PCout),.dataOut(bus));
		
		MAR MAR_one(.*, .dataIn(bus), .dataOut(ADDR));
		
		MDR MDR_one(.*, .dataIn(bus), .dataOut(MDRout));
		
		GateMDR GateMDR_one(.*, .dataIn(MDRout), .dataOut(bus));
	
	
	
		assign LED[9:0] = 10'b0;
		always_ff @ (posedge Clk)
		begin
			case (IRout[15:12])
				4'b0001 :
				begin
				 	LED[11] <= 1'b0; 
					LED[10] <= 1'b1;
				end
				
				4'b0101 :
				begin
				 	LED[11] <= 1'b0; 
					LED[10] <= 1'b1;
				end

								
				4'b1001 :
				begin
				 	LED[11] <= 1'b0; 
					LED[10] <= 1'b1;
				end
								
				4'b000 :
				begin
				 	LED[11] <= 1'b1; 
					LED[10] <= 1'b0;
				end
								
				4'b1100 :
				begin
				 	LED[11] <= 1'b1; 
					LED[10] <= 1'b0;
				end
								
				4'b0100 :
				begin
				 	LED[11] <= 1'b1; 
					LED[10] <= 1'b0;
				end
								
				4'b0110 :
				begin
				 	LED[11] <= 1'b1; 
					LED[10] <= 1'b0;
				end
								
				4'b0111 :
				begin
				 	LED[11] <= 1'b1; 
					LED[10] <= 1'b0;
				end
								
				4'b1101 :
				begin
				 	LED[11] <= 1'b1; 
					LED[10] <= 1'b1;
				end
		endcase
			end
		//assign busline = bus;

		//assign bus = (GateMDR)? bus : 16'bZZZZZZZZZZZZZZZZ;
		
	/*	assign IR0 = MDRout[3:0];
		assign IR1 = MDRout[7:4];
		assign IR2 = MDRout[11:8];
		assign IR3 = MDRout[15:12];
		
	HexDriver Hex0(.In0(IR0),.Out0(HEX0));
	HexDriver Hex1(.In0(IR1),.Out0(HEX1));
	HexDriver Hex2(.In0(IR2),.Out0(HEX2));
	HexDriver Hex3(.In0(IR3),.Out0(HEX3));
		*/
	
		
endmodule