
/*---------------------------------------------------------------------------
  --      AES.sv                                                           --
  --      Joe Meng                                                         --
  --      Fall 2013                                                        --
  --                                                                       --
  --      For use with ECE 298 Experiment 9                                --
  --      UIUC ECE Department                                              --
  ---------------------------------------------------------------------------
*/
// AES module interface with all ports, commented for Week 1
 module  AES ( input  [127:0]  Plaintext,
               input [127:0]	 Cipherkey,
               input           Clk, 
                               Reset,
		 	  				     Run,
               output [127:0]  Ciphertext,
               output          Ready  );

// Partial interface for Week 1
// Splitting the signals into 32-bit ones for compatibility with ModelSim
	/*module  AES ( input clk,
			  input  [31:0]  Cipherkey_0, Cipherkey_1, Cipherkey_2, Cipherkey_3,
              output [31:0]  keyschedule_out_0, keyschedule_out_1, keyschedule_out_2, keyschedule_out_3 );				*/ 
					 
	logic [1407:0] keyschedule;	 
					 
	//KeyExpansion keyexpansion_0(.*, .clk(Clk),.KeySchedule(keyschedule));
	
	assign {keyschedule_out_0, keyschedule_out_1, keyschedule_out_2, keyschedule_out_3} = keyschedule[1407:1280];	
//	assign {
	
	logic [127:0] State;
	logic [127:0] InAdd, OutAdd, InShift, OutShift, InSub, OutSub, InMix, OutMix;
	//logic [31:0] Word;
	logic [127:0] Round_Key; //40+3+20+30+27
	logic [3:0] Round;
	enum logic [5:0] {RESET, END,WAIT, ADD0, ADD1, ADD2, ADD3, ADD4, ADD5, ADD6, ADD7, ADD8, ADD9, ADD10, SHIFT0, SHIFT1, SHIFT2, SHIFT3, SHIFT4,
							SHIFT5, SHIFT6, SHIFT7, SHIFT8,SHIFT9,SUB0,SUB1,SUB2,SUB3,SUB4,SUB5,SUB6,SUB7,SUB8,SUB9,MIX0,MIX1,MIX2,MIX3,MIX4,
							MIX5,MIX6,MIX7,MIX8//,SHIFT0A, SHIFT0B, SHIFT1A, SHIFT1B, SHIFT2A, SHIFT2B, SHIFT3A, SHIFT3B, SHIFT4A, SHIFT4B,
							//SHIFT5A, SHIFT5B, SHIFT6A, SHIFT6B, SHIFT7A, SHIFT7B, SHIFT8A, SHIFT8B, SHIFT9A, SHIFT9B, SUB0A, SUB0B, SUB0C,
							//SUB1A, SUB1B, SUB1C, SUB2A, SUB2B, SUB2C, SUB3A, SUB3B, SUB3C, SUB4A, SUB4B, SUB4C, SUB5A, SUB5B, SUB5C, SUB6A,
							//SUB6B, SUB6C, SUB7A, SUB7B, SUB7C, SUB8A, SUB8B, SUB8C, SUB9A, SUB9B, SUB9C,MIX0A, MIX0B, MIX0C,
							//MIX1A, MIX1B, MIX1C, MIX2A, MIX2B, MIX2C, MIX3A, MIX3B, MIX3C, MIX4A, MIX4B, MIX4C, MIX5A, MIX5B, MIX5C, MIX6A,
							//MIX6B, MIX6C, MIX7A, MIX7B, MIX7C, MIX8A, MIX8B, MIX8C, MIX9A, MIX9B, MIX9C
							}state, next_state;
							
//	InvAddRoundKey IARK0 (.Clk(Clk), .KeySchedule(keyschedule), .Round(Round), .state(InAdd), .outstate(OutAdd));
	InvShiftRows ISR0 (.Clk(Clk), .instate(InShift), .outstate(OutShift));
	InvSubBytes_128 ISB0 (.clk(Clk),.in(InSub),.out(OutSub));
	InvMixColumns_128 IMC0 (.in(InMix), .out(OutMix));


	always @ (posedge Clk, negedge Reset) 
	begin
	if (Reset == 1'b0) 
		begin
			state <= RESET;
		end 
	else
		state <= next_state;
	end
	always//_ff @ (posedge Clk)
	begin
		next_state = state;
			unique case (state)
				RESET: begin
					next_state = WAIT;
					Ready = 1'b0;
				end
				WAIT: begin
					if (Run)
					begin
						next_state = ADD0;
						Ready = 1'b0;
					end
				end
				ADD0: begin
					if(Round == 4'b0000)
					begin
						next_state = SHIFT0;
					end
				Ready = 1'b0;
				end
				ADD1: begin
					if(Round == 4'b0001)
					begin
					next_state = MIX0;
					end
					Ready = 1'b0;
				end
				ADD2: begin
				if(Round == 4'b0010)
					begin
					next_state = MIX1;
					end
				Ready = 1'b0;
				end
				ADD3: begin
				if(Round == 4'b0011)
					begin
					next_state = MIX2;
					end
					Ready = 1'b0;
				end
				ADD4: begin
				if(Round == 4'b0100)
					begin
					next_state = MIX3;
					end
					Ready = 1'b0;
				end
				ADD5: begin
				if(Round == 4'b0101)
					begin
					next_state = MIX4;
					end
					Ready = 1'b0;
				end
				ADD6: begin
				if(Round == 4'b0110)
					begin
					next_state = MIX5;
					end
				Ready = 1'b0;
				end
				ADD7: begin
				if(Round == 4'b0111)
					begin
					next_state = MIX6;
					end
					Ready = 1'b0;
				end
				ADD8: begin
					if(Round == 4'b1000)
					begin
					next_state = MIX7;
					end
				 Ready = 1'b0;
				end
				ADD9: begin
				if(Round == 4'b1001)
					begin
					next_state = MIX8;
					end
					Ready = 1'b0;
				end
				ADD10: begin
				if(Round == 4'b1010)
					begin
					next_state = END; 
					end
				Ready = 1'b0;
				end
				SHIFT0: begin
					if(Round == 4'b0000)
					begin
					next_state = SUB0;//SHIFT0A;//
					end
				Ready = 1'b0;
				end
								
				/*SHIFT0A: begin
				next_state = SHIFT0B;
				end
				SHIFT0B: begin
				next_state = SUB0;
				end
				*/
				SHIFT1: begin
					if(Round == 4'b0001)
					begin
					next_state = SUB1;//SHIFT1A;////
					end
				Ready = 1'b0;
				end
				/*
				SHIFT1A: begin
				next_state = SHIFT1B;
				end
				SHIFT1B: begin
				next_state = SUB1;
				end*/
				
				SHIFT2: begin
				if(Round == 4'b0010)
					begin
					next_state = SUB2;//SHIFT2A;//;//
					end
				Ready = 1'b0;
				end
								
				/*SHIFT2A: begin
				next_state = SHIFT2B;
				end
				SHIFT2B: begin
				next_state = SUB2;
				end
				*/
				SHIFT3: begin
				if(Round == 4'b0011)
					begin
					next_state = SUB3;//SHIFT3A;//
					end
				Ready = 1'b0;
				end
								
				/*SHIFT3A: begin
				next_state = SHIFT3B;
				end
				SHIFT3B: begin
				next_state = SUB3;
				end*/
				
				SHIFT4: begin
				if(Round == 4'b0100)
					begin
					next_state =SUB4;//SHIFT4A;// 
					end
					Ready = 1'b0;
				end
								
			/*	SHIFT4A: begin
				next_state = SHIFT4B;
				end
				SHIFT4B: begin
				next_state = SUB4;
				end*/
				
				SHIFT5: begin
				if(Round == 4'b0101)
					begin
					next_state = SUB5;//SHIFT5A;///
					end
				Ready = 1'b0;
				end
								
				/*SHIFT5A: begin
				next_state = SHIFT1B;
				end
				SHIFT5B: begin
				next_state = SUB5;
				end
				*/
				SHIFT6: begin
				if(Round == 4'b0110)
					begin
					next_state =SUB6;//SHIFT6A;// 
					end
				Ready = 1'b0;
				end
						/*		
				SHIFT6A: begin
				next_state = SHIFT6B;
				end
				SHIFT6B: begin
				next_state = SUB6;
				end
				*/
				SHIFT7: begin
				if(Round == 4'b0111)
					begin
					next_state = SUB7;//SHIFT7A;//
					end
				Ready = 1'b0;
				end
				/*				
				SHIFT7A: begin
				next_state = SHIFT7B;
				end
				SHIFT7B: begin
				next_state = SUB7;
				end
				*/
				
				SHIFT8: begin
				if(Round == 4'b1000)
					begin
					next_state =SUB8;//SHIFT8A;// 
					end
					Ready = 1'b0;
				end
			/*(					
				SHIFT8A: begin
				next_state = SHIFT8B;
				end
				SHIFT8B: begin
				next_state = SUB8;
				end
*/				SHIFT9: begin
				if(Round == 4'b1001)
					begin
					next_state = SUB9;//SHIFT9A;//
					end
					Ready = 1'b0;
				end
					/*			
				SHIFT9A: begin
				next_state = SHIFT9B;
				end
				SHIFT9B: begin
				next_state = SUB9;
				end*/
				
				SUB0: begin
				if(Round == 4'b0000)
					begin
					next_state =ADD1;// SUB0A;//
					end
					Ready = 1'b0;
				end
				/*
				SUB0A: begin
				next_state = SUB0B;
				end
				SUB0B: begin
				next_state = SUB0C;
				end
				SUB0C: begin
				next_state = ADD1;
				end
			*/
				SUB1: begin
				if(Round == 4'b0001)
					begin
					next_state = ADD2;//SUB1A;//
					end
					Ready = 1'b0;
				end
								
				/*SUB1A: begin
				next_state = SUB1B;
				end
				SUB1B: begin
				next_state = SUB1C;
				end
				SUB1C: begin
				next_state = ADD2;
				end*/
				
				SUB2: begin
				if(Round == 4'b0010)
					begin
					next_state =ADD3;//SUB2A;// 
					end
					Ready = 1'b0;
				end
						/*						
				SUB2A: begin
				next_state = SUB2B;
				end
				SUB2B: begin
				next_state = SUB2C;
				end
				SUB2C: begin
				next_state = ADD3;
				end*/
				
				SUB3: begin
				if(Round == 4'b0011)
					begin
					next_state =ADD4;//SUB3A;// 
					end
				Ready = 1'b0;
				end		
				/*
				SUB3A: begin
				next_state = SUB3B;
				end
				SUB3B: begin
				next_state = SUB3C;
				end
				SUB3C: begin
				next_state = ADD4;
				end*/
				
				SUB4: begin
				if(Round == 4'b0100)
					begin
					next_state =ADD5;//SUB4A;// 
					end
					Ready = 1'b0;
				end
						/*						
				SUB4A: begin
				next_state = SUB4B;
				end
				SUB4B: begin
				next_state = SUB4C;
				end
				SUB4C: begin
				next_state = ADD5;
				end*/
				
				SUB5: begin
				if(Round == 4'b0101)
					begin
					next_state = ADD6;//SUB5A;//
					end
				Ready = 1'b0;
				end		
				/*
				SUB5A: begin
				next_state = SUB5B;
				end
				SUB5B: begin
				next_state = SUB5C;
				end
				SUB5C: begin
				next_state = ADD6;
				end
				*/
				SUB6: begin
				if(Round == 4'b0110)
					begin
					next_state = ADD7;//SUB6A;//
					end
					Ready = 1'b0;
				end
						/*						
				SUB6A: begin
				next_state = SUB6B;
				end
				SUB6B: begin
				next_state = SUB6C;
				end
				SUB6C: begin
				next_state = ADD7;
				end*/

				SUB7: begin
				if(Round == 4'b0111)
					begin
					next_state = ADD8;//SUB7A;//
					end
					Ready = 1'b0;
				end
				/*
				SUB7A: begin
				next_state = SUB7B;
				end
				SUB7B: begin
				next_state = SUB7C;
				end
				SUB7C: begin
				next_state = ADD8;
				end
				*/
				SUB8: begin
				if(Round == 4'b1000)
					begin
					next_state =ADD9;//SUB8A;// 
					end
					Ready = 1'b0;
				end
				/*
				SUB8A: begin
				next_state = SUB8B;
				end
				SUB8B: begin
				next_state = SUB8C;
				end
				SUB8C: begin
				next_state = ADD9;
				end
				*/
				SUB9: begin
				if(Round == 4'b1001)
					begin
					next_state = ADD10;//SUB9A;//
					end
					Ready = 1'b0;
				end
				/*
				SUB9A: begin
				next_state = SUB9B;
				end
				SUB9B: begin
				next_state = SUB9C;
				end
				SUB9C: begin
				next_state = ADD10;
				end
				*/
				MIX0: begin
				if(Round == 4'b0001)
					begin
					next_state =SHIFT1;// MIX0A;//
					end
				Ready = 1'b0;
				end
				/*
				MIX0A: begin
				next_state = MIX0B;
				end
				MIX0B: begin
				next_state = MIX0C;
				end
				MIX0C: begin
				next_state = SHIFT1;
				end
				*/
				MIX1: begin
				if(Round == 4'b0010)
					begin
					next_state =SHIFT2;// MIX1A;//
					end
				Ready = 1'b0;
				end
				/*
				MIX1A: begin
				next_state = MIX1B;
				end
				MIX1B: begin
				next_state = MIX1C;
				end
				MIX1C: begin
				next_state = SHIFT2;
				end
				*/
				MIX2: begin
				if(Round == 4'b0011)
					begin
					next_state =SHIFT3;// MIX2A;//
					end
					Ready = 1'b0;
				end
/*
				MIX2A: begin
				next_state = MIX2B;
				end
				MIX2B: begin
				next_state = MIX2C;
				end
				MIX2C: begin
				next_state = SHIFT3;
				end
				*/
				MIX3: begin
				if(Round == 4'b0100)
					begin
					next_state =SHIFT4;// MIX3A;//
					end
				Ready = 1'b0;
				end
				/*
				MIX3A: begin
				next_state = MIX3B;
				end
				MIX3B: begin
				next_state = MIX3C;
				end
				MIX3C: begin
				next_state = SHIFT4;
				end
				*/
				MIX4: begin
				if(Round == 4'b0101)
					begin
					next_state =SHIFT5;// MIX4A;//
					end
				Ready = 1'b0;
				end
				/*
				MIX4A: begin
				next_state = MIX4B;
				end
				MIX4B: begin
				next_state = MIX4C;
				end
				MIX4C: begin
				next_state = SHIFT5;
				end
				*/
				MIX5: begin
				if(Round == 4'b0110)
					begin
					next_state =SHIFT6;// MIX5A;//
					end
				Ready = 1'b0;
				end
				/*
				MIX5A: begin
				next_state = MIX5B;
				end
				MIX5B: begin
				next_state = MIX5C;
				end
				MIX5C: begin
				next_state = SHIFT6;
				end
				*/
				MIX6: begin
				if(Round == 4'b0111)
					begin
					next_state =SHIFT7;// MIX6A;//
					end
					Ready = 1'b0;
				end
				/*
				MIX6A: begin
				next_state = MIX6B;
				end
				MIX6B: begin
				next_state = MIX6C;
				end
				MIX6C: begin
				next_state = SHIFT7;
				end*/
				
				MIX7: begin
				if(Round == 4'b1000)
					begin
					next_state =SHIFT8;// MIX7A;//
					end
				Ready = 1'b0;
				end
				/*
				MIX7A: begin
				next_state = MIX7B;
				end
				MIX7B: begin
				next_state = MIX7C;
				end
				MIX7C: begin
				next_state = SHIFT8;
				end
				*/
				MIX8: begin
				if(Round == 4'b1001)
					begin
					next_state = SHIFT9;//MIX8A;//
					end
				Ready = 1'b0;
				end
				/*
				MIX8A: begin
				next_state = MIX8B;
				end
				MIX8B: begin
				next_state = MIX8C;
				end
				MIX8C: begin
				next_state = SHIFT9;
				end
				*/
				END: begin
					Ready = 1'b1;
					next_state = RESET;
				end
	
			endcase
		end
	//always_comb// or 
	always_ff @ (posedge Clk)
	begin 
	unique case(state)
		RESET: begin
			State <= 128'b0;
			InShift <= 128'b0;
			InMix <= 128'b0;
			InSub <= 128'b0;
			InAdd <= 128'b0;
			Round <= 4'b1111;
			//Ready = 1'b0;
		end
		WAIT: begin
			State = Plaintext;
			end
		ADD0: begin
			Round <= 4'b0;
			//InAdd = State;
			//State = OutAdd;
			Ciphertext = keyschedule[1407:1280];
		end
		ADD1: begin
			Round <= 4'b0001;
			//InAdd = State;
			//State = OutAdd;
			State = State ^ keyschedule[1279:1152];
		end
		ADD2: begin
			Round <= 4'b0010;
			/*InAdd = State;
			State = OutAdd;*/
			State = State ^ keyschedule[1151:1025];
		end
		ADD3: begin
			Round <= 4'b0011;
		/*	InAdd = State;
			State = OutAdd;	*/
			State = State ^ keyschedule[1024:897];
		end
		ADD4: begin
			Round <= 4'b0100;
			/*InAdd = State;
			State = OutAdd;*/
			State = State ^ keyschedule[896:769];
		end
		ADD5: begin
			Round <= 4'b0101;
		/*	InAdd = State;
			State = OutAdd;*/
			State = State ^ keyschedule[768:641];
		end
		ADD6: begin
			Round <= 4'b0110;
			/*InAdd = State;
			State = OutAdd;*/
			State = State ^ keyschedule[640:513];
		end
		ADD7: begin
			Round <= 4'b0111;
		/*	InAdd = State;
			State = OutAdd;*/
			State = State ^ keyschedule[512:385];
		end
		ADD8: begin
			Round <= 4'b1000;
		/*	InAdd = State;
			State = OutAdd;*/
			State = State ^ keyschedule[384:257];
		end
		ADD9: begin
			Round <= 4'b1001;
			/*InAdd = State;
			State = OutAdd;*/
			State = State ^ keyschedule[256:128];
		end
		ADD10: begin
			Round <= 4'b1010;
			/*InAdd = State;
			State = OutAdd;*/
			State = State ^ keyschedule[127:0];
		end
		SHIFT0: begin
			InShift = State;
			State = OutShift;
		end
		SHIFT1: begin
			InShift = State;
			State = OutShift;
		end
		SHIFT2: begin
			InShift = State;
			State = OutShift;
		end
		SHIFT3: begin
			InShift = State;
			State = OutShift;
		end
		SHIFT4: begin
			InShift = State;
			State = OutShift;
		end
		SHIFT5: begin
			InShift = State;
			State = OutShift;
		end
		SHIFT6: begin
			InShift = State;
			State = OutShift;
		end
		SHIFT7: begin
			InShift = State;
			State = OutShift;
		end
		SHIFT8: begin
			InShift = State;
			State = OutShift;
		end
		SHIFT9: begin
			InShift = State;
			State = OutShift;
		end
		SUB0: begin
			InSub = State;
			State = OutSub;
		end
		SUB1: begin
			InSub = State;
			State = OutSub;
		end
		SUB2: begin
			InSub = State;
			State = OutSub;
		end
		SUB3: begin
			InSub = State;
			State = OutSub;
		end
		SUB4: begin
			InSub = State;
			State = OutSub;
		end
		SUB5: begin
			InSub = State;
			State = OutSub;
		end
		SUB6: begin
			InSub = State;
			State = OutSub;
		end
		SUB7: begin
			InSub = State;
			State = OutSub;
		end
		SUB8: begin
			InSub = State;
			State = OutSub;
		end
		SUB9: begin
			InSub = State;
			State = OutSub;
		end
		MIX0: begin
			InMix = State;
			State = OutMix;
		end
		MIX1: begin
			InMix = State;
			State = OutMix;
		end
		MIX2: begin
			InMix = State;
			State = OutMix;
		end
		MIX3: begin
			InMix = State;
			State = OutMix;
		end
		MIX4: begin
			InMix = State;
			State = OutMix;
		end
		MIX5: begin
			InMix = State;
			State = OutMix;
		end
		MIX6: begin
			InMix = State;
			State = OutMix;
		end
		MIX7: begin
			InMix = State;
			State = OutMix;
		end
		MIX8: begin
			InMix = State;
			State = OutMix;
		end
		END: begin
			Ciphertext=State; //keyschedule[1407:1280];
		
		end
	endcase
	end
	
endmodule