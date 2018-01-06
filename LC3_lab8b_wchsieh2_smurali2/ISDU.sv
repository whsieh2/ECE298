//------------------------------------------------------------------------------
// Company: 		 UIUC ECE Dept.
// Engineer:		 Stephen Kempf
//
// Create Date:    17:44:03 10/08/06
// Design Name:    ECE 385 Lab 10 Given Code - Incomplete ISDU
// Module Name:    ISDU - Behavioral
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Fall 2013 Distribution
//------------------------------------------------------------------------------

module ISDU ( 	input	logic Clk, 
                        Reset,
						Run,
						Continue,
						//ContinueIR,
									
				input logic [3:0]  Opcode, 
				input     logic    IR_5, BEN,
				  
				output logic 	LD_MAR,
								LD_MDR,
								LD_IR,
								LD_BEN,
								LD_CC,
								LD_REG,
								LD_PC,
									
				output logic 	GatePC,
								GateMDR,
								GateALU,
								GateMARMUX,
									
				output logic [1:0] 	PCMUX,
				                    DRMUX,
									SR1MUX,
				output logic 		SR2MUX,
									ADDR1MUX,
				output logic [1:0] 	ADDR2MUX,
				output logic 		MARMUX,
				  
				output logic [1:0] 	ALUK,
				  
				output logic 		Mem_CE,
									Mem_UB,
									Mem_LB,
									Mem_OE,
									Mem_WE
				
				);
 
    enum logic [4:0] {Halted, PauseIR1, PauseIR2, Pause1, Pause2, S_18, S_33_1, S_33_2, S_35, 
								S_32, S_01, S_05, S_09, S_00, S_22, S_12, S_4, S_21, S_6, S_25_1, 
								S_25_2, S_27, S_7, S_23_1, S_23_2, S_16_1, S_16_2}   State, Next_state;   // Internal state logic
	    
    always_ff @ (posedge Clk or posedge Reset )
    begin : Assign_Next_State
        if (Reset) 
            State <= Halted;
        else 
            State <= Next_state;
    end
   
	always_comb
    begin 
	    Next_state  = State;
	 
        unique case (State)
            Halted : 
	            if (Run) 
					Next_state <= S_18;					  
            S_18 : 
                Next_state <= S_33_1;
            S_33_1 : 
                Next_state <= S_33_2;
            S_33_2 : 
                Next_state <= S_35;
            S_35 : 
               // Next_state <= PauseIR1;
					 Next_state <= S_32;
           /* PauseIR1 : 
                if (~ContinueIR) 
                    Next_state <= PauseIR1;
                else 
                    Next_state <= PauseIR2;
            PauseIR2 : 
                if (ContinueIR) 
                    Next_state <= PauseIR2;
                else 
                    Next_state <= S_32;*/
            S_32 : 
				case (Opcode)
					4'b0001 : //ADD
						Next_state <= S_01;
					4'b0101 : //AND
						Next_state <= S_05;
					4'b1001 : //NOT
						Next_state <= S_09;
					4'b0000 : //BR
						Next_state <= S_00;
					4'b1100 : //JMP
						Next_state <= S_12;
					4'b0100 : //JSR
						Next_state <= S_4;
					4'b0110 : //LDR
						Next_state <= S_6;
					4'b0111 : //STR
						Next_state <= S_7;
					4'b1101 : //PAUSE
						Next_state <= Pause1;
					default : 
					    Next_state <= S_18;
				endcase
            S_01 : 
					Next_state <= S_18;
				S_05 :
					Next_state <= S_18;
				S_09 :
					Next_state <= S_18;
				S_00:
					begin
						if (BEN)
							Next_state <= S_22;
						else	
							Next_state <= S_18;
					end
				S_22:
					Next_state <= S_18;
				S_12:
					Next_state <= S_18;
				S_4:
					Next_state <= S_21;
				S_21:
					Next_state <= S_18;
				S_6:
					Next_state <= S_25_1;
				S_25_1:
					Next_state <= S_25_2;
				S_25_2:
					Next_state <= S_27;
				S_27:
					Next_state <= S_18;
				S_7:
					Next_state <= S_23_1;
				S_23_1:
					Next_state <= S_23_2;
				S_23_2:
					Next_state <= S_16_1;
				S_16_1:
					Next_state <= S_16_2;
				S_16_2:
					Next_state <= S_18;
				Pause1:
					begin	
						if (~Continue)
							Next_state <= Pause1;
						else
							Next_state <= Pause2;
					end
				Pause2:
					begin
						if (Continue)
							Next_state <= Pause2;
						else
							Next_state <= S_18;
					end	 
				default : ;
	     endcase
    end
   
    always_comb
    begin 
        //default controls signal values; within a process, these can be
        //overridden further down (in the case statement, in this case)
	    LD_MAR = 1'b0;
	    LD_MDR = 1'b0;
	    LD_IR = 1'b0;
	    LD_BEN = 1'b0;
	    LD_CC = 1'b0;
	    LD_REG = 1'b0;
	    LD_PC = 1'b0;
		 
	    GatePC = 1'b0;
	    GateMDR = 1'b0;
	    GateALU = 1'b0;
	    GateMARMUX = 1'b0;
		 
		ALUK = 2'b00;
		 
	    PCMUX = 2'b00;
	    DRMUX = 2'b00;
	    SR1MUX = 2'b01; //Use IR[8:6] by default (usually for when BaseR is used)
	    SR2MUX = 1'b0;
	    ADDR1MUX = 1'b0;
	    ADDR2MUX = 2'b00;
	    MARMUX = 1'b0;
		 
	    Mem_OE = 1'b1;//active low
	    Mem_WE = 1'b1;
		 
	    case (State)
			Halted: ; //Do Nothing
			S_18 : 
				begin 				//Fetch 1 (Week 1)
					GatePC = 1'b1; //PC Drives Bus
					LD_MAR = 1'b1; //Load PC into MAR
					PCMUX = 2'b00; //Increment PC
					LD_PC = 1'b1; 
				end
			S_33_1 : 				//Fetch 2 (Week1)
				Mem_OE = 1'b0; 	//Memory bus driven by Memory
			S_33_2 : 
				begin 
					Mem_OE = 1'b0; //Fetch 3 (Week 1)
					LD_MDR = 1'b1; //Load MDR from bus
                end
            S_35 : 
                begin 			//Fetch 4(Week 1)
					GateMDR = 1'b1;//MDR Drives Bus
					LD_IR = 1'b1; 	//Load into IR
                end
            //PauseIR1: ;
            //PauseIR2: ;
            S_32 : 				//Decode
                LD_BEN = 1'b1;
            S_01 : //ADD
					begin 
						SR2MUX = IR_5; 	//Add from SR or imm5
						ALUK = 2'b00; 		//ADD for ALU
						GateALU = 1'b1;	//ALU drives bus
						LD_REG = 1'b1;	 	//Store into regfile
						LD_CC = 1'b1; 		//set condition codes
					end
				S_05: //AND
					begin	
						SR2MUX = IR_5;		//AND from SR or imm5
						ALUK = 2'b01;		//AND for ALU
						GateALU = 1'b1;	//ALU drives Bus
						LD_REG = 1'b1;		//Store into regfile
						LD_CC = 1'b1;		//set condition codes
					end
				S_09: //NOT
					begin
						ALUK = 2'b10;		//NOT for ALU
						GateALU = 1'b1;	//ALU drives bus
						LD_REG = 1'b1;		//Store into regfile
						LD_CC = 1'b1;		//set condition codes
					end
				S_00: ; //Check BEN (BR1)
				S_22:
					begin	//BR2					
						ADDR2MUX = 2'b10;	//Choose to load offset9+PC into PC
						PCMUX = 2'b10;
						LD_PC = 1'b1;
					end
				S_12: //JMP
					begin	
						ADDR1MUX = 1'b1; //Load PC with SR1
						PCMUX = 2'b10;
						LD_PC = 1'b1;
					end
				S_4: //JSR1
					begin
						GatePC = 1'b1; //PC drives bus
						DRMUX = 2'b10; //Load bus to R7
						LD_REG = 1'b1;
					end
				S_21: //JSR2
					begin
						ADDR2MUX = 2'b11; //Choose to load offset11+PC into PC
						PCMUX = 2'b10;
						LD_PC = 1'b1;
					end
				S_6: //LDR1
					begin
						ADDR2MUX = 2'b01;
						ADDR1MUX = 1'b1;
						MARMUX = 1'b1;		//BaseR + offset6
						GateMARMUX = 1'b1;//MARMUX drives bus
						LD_MAR = 1'b1;		//Load to MAR
					end
				S_25_1://LDR2
					Mem_OE = 1'b0; //Memory bus driven my memory
				S_25_2://LDR3
					begin
						Mem_OE = 1'b0;
						LD_MDR = 1'b1; //Load MDR from bus
					end
				S_27: //LDR4
					begin
						GateMDR = 1'b1; 	//MDR Drives bus
						LD_REG = 1'b1;		//load into DR
						LD_CC = 1'b1;		//Set CC
					end
				S_7: //STR1
					begin
						ADDR2MUX = 2'b01;
						ADDR1MUX = 1'b1;
						MARMUX = 1'b1;		//BaseR + offset6
						GateMARMUX = 1'b1;//MARMUX drives bus
						LD_MAR = 1'b1;		//Load to MAR
					end
				S_23_1://STR2
					begin
						SR1MUX = 2'b00; 	//Choose SR1 using IR[11:9]
						ALUK = 2'b11;		//Pass SR1
						GateALU = 1'b1;	//ALU drives bus
						LD_MDR = 1'b1;		//Load into MDR
					end
				S_23_2://STR3 extra for STR2 (S_23_2)
					begin
						SR1MUX = 2'b00;
						ALUK = 2'b11;
						GateALU = 1'b1;
						LD_MDR = 1'b1;
					end
				S_16_1://STR4
					begin
						Mem_WE = 1'b0;	//Write to memory
						GateMDR = 1'b1;//MDR drives bus
					end
				S_16_2://STR5 extra for STR4 (S_16_1)
					begin	
						Mem_WE = 1'b0;
						GateMDR = 1'b1;
					end
								
            default : ;
          endcase
       end 
 
	assign Mem_CE = 1'b0; //always enable memory
	assign Mem_UB = 1'b0;
	assign Mem_LB = 1'b0;
	
endmodule

/*module ISDU ( 	input	Clk, 
                        Reset,
						Run,
						Continue,
						ContinueIR,
				input logic BEN,
				input [3:0] Opcode,
									 
				input        IR_5,
				  
				output logic 	LD_MAR,
								LD_MDR,
								LD_IR,
								LD_BEN,
								LD_CC,
								LD_REG,
								LD_PC,
									
				output logic 	GatePC,
								GateMDR,
								GateALU,
								GateMARMUX,
									
				output logic [1:0] 	PCMUX,
				                    DRMUX,
									SR1MUX,
				output logic 		SR2MUX,
									ADDR1MUX,
				output logic [1:0] 	ADDR2MUX,
				output logic 		MARMUX,
				  
				output logic [1:0] 	ALUK,
				  
				output logic 		Mem_CE,
									Mem_UB,
									Mem_LB,
									Mem_OE,
									Mem_WE
				);

    enum logic [4:0] {Halted, Pause1, Pause2, S_18, S_33_1, S_33_2, S_35, S_32, S_01, S_10, S_12, S_15, S_16, S_23, 
								S_24, S_25_1, S_25_2, S_26, S_27, S_28, S_13, S_07, S_05, S_06, S_09, S_22, S_21, S_20, S_04}   State, Next_state;   // Internal state logic
	    
    always_ff @ (posedge Clk or posedge Reset )
    begin : Assign_Next_State
        if (Reset) 
            State <= Halted;
        else 
            State <= Next_state;
    end
   
	always_comb
    begin 
	    Next_state  = State;
	 
        unique case (State)
            Halted : 
	            if (Run) 
					Next_state <= S_18;					  
            S_18 : 
                Next_state <= S_33_1;
            S_33_1 : 
                Next_state <= S_33_2;
            S_33_2 : 
                Next_state <= S_35;
            S_35 : 
                Next_state <= S_32;
            S_32 : 
				case (Opcode)
					4'b0000 :
						if (BEN)
							Next_state <= S_22;
						else
							Next_state <= S_18;
					4'b0001 : 
					    Next_state <= S_01;
					4'b0100 :
						Next_state <= S_04;
					4'b0101 :
						Next_state <= S_05;
					4'b0110 :
						Next_state <= S_06;
					4'b0111 :
						Next_state <= S_07;
					4'b1001 :
						Next_state <= S_09;
					4'b1100 :
						Next_state <= S_12;
					4'b1101 :
						Next_state <= S_13;
					default : 
					    Next_state <= S_18;
				endcase
            S_01 : 
					Next_state <= S_18;
				S_05 :
					Next_state <= S_18;
				S_09 :
					Next_state <= S_18;
				S_12 :
					Next_state <= S_18;
				S_04 :
				case(IR_5)
					1'b1 :
						Next_state <= S_21;
					1'b0 :
						Next_state <= S_20;
				endcase
				S_06 :
					Next_state <= S_25_1;
				S_07 :
					Next_state <= S_23;
				S_25_1 :
					Next_state <= S_25_2;
				S_25_2 :
					Next_state <= S_27;
				S_23 :
					Next_state <= S_16;
				S_16 :
					Next_state <= S_18;
				S_27 :
					Next_state <= S_18;
				S_21 :
					Next_state <= S_18;
				S_20 :
					Next_state <= S_18;
				S_13 :
					Next_state <= Pause1;
				Pause1:
					begin	
						if (~Continue)
							Next_state <= Pause1;
						else
							Next_state <= Pause2;
					end
				Pause2:
					begin
						if (Continue)
							Next_state <= Pause2;
						else
							Next_state <= S_32;
					end
			default : ;

	     endcase
    end
   
    always_comb
    begin 
        //default controls signal values; within a process, these can be
        //overridden further down (in the case statement, in this case)
	    LD_MAR = 1'b0;
	    LD_MDR = 1'b0;
	    LD_IR = 1'b0;
	    LD_BEN = 1'b0;
	    LD_CC = 1'b0;
	    LD_REG = 1'b0;
	    LD_PC = 1'b0;
		 
	    GatePC = 1'b0;
	    GateMDR = 1'b0;
	    GateALU = 1'b0;
	    GateMARMUX = 1'b0;
		 
		ALUK = 2'b00;
		 
	    PCMUX = 2'b00;
	    DRMUX = 2'b00;
	    SR1MUX = 2'b00;
	    SR2MUX = 1'b0;	
	    ADDR1MUX = 1'b0;
	    ADDR2MUX = 2'b00;
	    MARMUX = 1'b0;
		 
	    Mem_OE = 1'b1;
	    Mem_WE = 1'b1;
		 
	    case (State)
			Halted: ;
			S_18 : 
				begin 
					GatePC = 1'b1;
					LD_MAR = 1'b1;
					PCMUX = 2'b00;
					LD_PC = 1'b1;
				end
			S_33_1 : 
				begin
				Mem_OE = 1'b0;
				Mem_WE = 1'b0;
				end
			S_33_2 : 
				begin 
					Mem_OE = 1'b0;
					Mem_WE = 1'b0;
					LD_MDR = 1'b1;
                end
            S_35 : 
                begin 
					GateMDR = 1'b1;
					LD_IR = 1'b1;
                end
            S_32 : 
                LD_BEN = 1'b1;
            S_01 : 
                begin 
					SR2MUX = IR_5;
					ALUK = 2'b00;
					GateALU = 1'b1;
					LD_REG = 1'b1;
					LD_CC = 1'b1;
                end
				S_10 ://LDMAR, GATEMARMUX, MARMUX = 1, ADDR2MUX = 10
					begin
					LD_BEN = 1'b0;
					LD_MAR = 1'b0;
					LD_MDR = 1'b0;
					LD_IR = 1'b0;
					LD_PC = 1'b0;
					LD_REG = 1'b0;
					LD_CC = 1'b0;
					GateMARMUX = 1'b1;
					GateMDR = 1'b0;
					GateALU = 1'b0;
					GatePC = 1'b0;
					MARMUX = 1'b1;
					ADDR1MUX = 1'b0;
					ADDR2MUX = 2'b10;
					Mem_OE = 1'b0;		//MIO.EN
					end
				S_12 :			//LDPC, GateALU, =1, PCMUX = 01, SR1MUX = 01, ALUK = 11
					begin
					LD_BEN = 1'b0;
					LD_MAR = 1'b0;
					LD_MDR = 1'b0;
					LD_IR = 1'b0;
					LD_PC = 1'b1;
					LD_REG = 1'b0;
					LD_CC = 1'b0;
					GateMARMUX = 1'b0;
					GateMDR = 1'b0;
					GateALU = 1'b1;
					GatePC = 1'b0;
					MARMUX = 1'b1;
					PCMUX = 2'b01;
					SR1MUX = 2'b01;
					ALUK = 2'b11;
					Mem_OE = 1'b0;		//MIO.EN
					end
				S_15 :			//LDMAR, GateMARMUX, =1
					begin
					LD_BEN = 1'b0;
					LD_MAR = 1'b1;
					LD_MDR = 1'b0;
					LD_IR = 1'b0;
					LD_PC = 1'b0;
					LD_REG = 1'b0;
					LD_CC = 1'b0;
					GateMARMUX = 1'b1;
					GateMDR = 1'b0;
					GateALU = 1'b0;
					GatePC = 1'b0;
					MARMUX = 1'b1;
					Mem_OE = 1'b0;		//MIO.EN
					end
				S_16 :			//MIO.EN
					begin
					LD_BEN = 1'b0;
					LD_MAR = 1'b0;
					LD_MDR = 1'b0;
					LD_IR = 1'b0;
					LD_PC = 1'b0;
					LD_REG = 1'b0;
					LD_CC = 1'b0;
					GateMARMUX = 1'b0;
					GateMDR = 1'b0;
					GateALU = 1'b0;
					GatePC = 1'b0;
					Mem_OE = 1'b1;		//MIO.EN
					Mem_WE = 1'b1;		//RW
					end
				S_18 :				//LDMAR, LDPC, GatePC = 1, PCMUX = 00
					begin
					LD_BEN = 1'b0;
					LD_MAR = 1'b1;
					LD_MDR = 1'b0;
					LD_IR = 1'b0;
					LD_PC = 1'b1;
					LD_REG = 1'b0;
					LD_CC = 1'b0;
					GateMARMUX = 1'b1;
					GateMDR = 1'b0;
					GateALU = 1'b0;
					GatePC = 1'b1;
					PCMUX = 2'b00;
					Mem_OE = 1'b0;		//MIO.EN
					end
				S_22 :
					begin
					LD_BEN = 1'b0;
					LD_MAR = 1'b0;
					LD_MDR = 1'b0;
					LD_IR = 1'b0;
					LD_PC = 1'b1;
					LD_REG = 1'b0;
					LD_CC = 1'b0;
					GateMARMUX = 1'b0;
					GateMDR = 1'b0;
					GateALU = 1'b0;
					GatePC = 1'b0;
					PCMUX = 2'b10;
					ADDR1MUX = 1'b0;
					ADDR2MUX = 2'b10;
					Mem_OE = 1'b1;		//changed
					end
				S_23 :				//LDMDR, GateALU =1, SR1MUX = 00, ALUK = 11
					begin
					LD_BEN = 1'b0;
					LD_MAR = 1'b0;
					LD_MDR = 1'b1;
					LD_IR = 1'b0;
					LD_PC = 1'b0;
					LD_REG = 1'b0;
					LD_CC = 1'b0;
					GateMARMUX = 1'b0;
					GateMDR = 1'b0;
					GateALU = 1'b1;
					GatePC = 1'b0;
					SR1MUX = 2'b00;
					ALUK = 2'b11;
					Mem_OE = 1'b1;		//MIO.EN  Changed from 0->1 because SR1 -> MDR
					end
				S_24 :				//LDMDR, MIO.EN = 1
					begin
					LD_BEN = 1'b0;
					LD_MAR = 1'b0;
					LD_MDR = 1'b1;
					LD_IR = 1'b0;
					LD_PC = 1'b0;
					LD_REG = 1'b0;
					LD_CC = 1'b0;
					GateMARMUX = 1'b0;
					GateMDR = 1'b0;
					GateALU = 1'b0;
					GatePC = 1'b0;
					Mem_OE = 1'b1;		//MIO.EN
					Mem_WE = 1'b0;
					end
				S_25_1 :				//LDMDR, MIO.EN = 1;
					begin
					LD_BEN = 1'b0;
					LD_MAR = 1'b0;
					LD_MDR = 1'b0;
					LD_IR = 1'b0;
					LD_PC = 1'b0;
					LD_REG = 1'b0;
					LD_CC = 1'b0;
					GateMARMUX = 1'b0;
					GateMDR = 1'b0;
					GateALU = 1'b0;
					GatePC = 1'b0;
					Mem_OE = 1'b0;		//MIO.EN
					Mem_WE = 1'b1;
					end
				S_25_2 :				//LDMDR, MIO.EN = 1;
					begin
					LD_BEN = 1'b0;
					LD_MAR = 1'b0;
					LD_MDR = 1'b1;
					LD_IR = 1'b0;
					LD_PC = 1'b0;
					LD_REG = 1'b0;
					LD_CC = 1'b0;
					GateMARMUX = 1'b0;
					GateMDR = 1'b0;
					GateALU = 1'b0;
					GatePC = 1'b0;
					Mem_OE = 1'b0;		//MIO.EN
					Mem_WE = 1'b1;
					end					
				S_26 :				//LDMAR, GateMDR = 1
					begin
					LD_BEN = 1'b0;
					LD_MAR = 1'b1;
					LD_MDR = 1'b0;
					LD_IR = 1'b0;
					LD_PC = 1'b0;
					LD_REG = 1'b0;
					LD_CC = 1'b0;
					GateMARMUX = 1'b0;
					GateMDR = 1'b1;
					GateALU = 1'b0;
					GatePC = 1'b0;
					Mem_OE = 1'b1;		//MIO.EN
					end
				S_27 :			//LDREG, LDCC, GateMDR = 1, DRMUX = 00
					begin
					LD_BEN = 1'b0;
					LD_MAR = 1'b0;
					LD_MDR = 1'b0;
					LD_IR = 1'b0;
					LD_PC = 1'b0;
					LD_REG = 1'b1;
					LD_CC = 1'b1;
					GateMARMUX = 1'b0;
					GateMDR = 1'b1;
					GateALU = 1'b0;
					GatePC = 1'b0;
					DRMUX = 2'b00;
					Mem_OE = 1'b1;		//MIO.EN
					end
				S_28 :
					begin
					LD_BEN = 1'b0;
					LD_MAR = 1'b1;
					LD_MDR = 1'b0;
					LD_IR = 1'b0;
					LD_PC = 1'b0;
					LD_REG = 1'b0;
					LD_CC = 1'b0;
					GateMARMUX = 1'b0;
					GateMDR = 1'b1;
					GateALU = 1'b0;
					GatePC = 1'b0;
					Mem_OE = 1'b0;		//MIO.EN
					end
				S_05:
					begin
					 LD_BEN = 1'b0;
					LD_MAR = 1'b0;
					LD_MDR = 1'b0;
					LD_IR = 1'b0;
					LD_PC = 1'b0;
					LD_REG = 1'b1;//
					LD_CC = 1'b1;//
					GateMARMUX = 1'b0;
					GateMDR = 1'b0;
					GateALU = 1'b1;
					GatePC = 1'b0;
					DRMUX = 2'b00;
					SR1MUX = 2'b01;
					SR2MUX = IR_5;
					ALUK = 2'b01;//
					Mem_OE = 1'b0;
					end
				S_09:
					begin
					LD_BEN = 1'b0;
					LD_MAR = 1'b0;
					LD_MDR = 1'b0;
					LD_IR = 1'b0;
					LD_PC = 1'b0;
					LD_REG = 1'b1;
					LD_CC = 1'b1;
					GateMARMUX = 1'b0;
					GateMDR = 1'b0;
					GateALU = 1'b1;
					GatePC = 1'b0;
					DRMUX = 2'b00;
					SR1MUX = 2'b01;
					ALUK = 2'b10;
					Mem_OE = 1'b1;  //we switched this from 0 to 1.
					end
				S_06 :
					begin
					LD_BEN = 1'b0;
					LD_MAR = 1'b1;
					LD_MDR = 1'b0;
					LD_IR = 1'b0;
					LD_PC = 1'b0;
					LD_REG = 1'b1;
					LD_CC = 1'b1;
					GateMARMUX = 1'b1;
					GateMDR = 1'b0;
					GateALU = 1'b0;
					GatePC = 1'b0;
					MARMUX = 1'b1;
					ADDR1MUX = 1'b1;
					ADDR2MUX = 2'b01;
					DRMUX = 2'b00;
					SR1MUX = 2'b01;
					Mem_OE = 1'b0;
					end
				S_07 :
					begin
					LD_BEN = 1'b0;
					LD_MAR = 1'b1;
					LD_MDR = 1'b0;
					LD_IR = 1'b0;
					LD_PC = 1'b0;
					LD_REG = 1'b1;
					LD_CC = 1'b1;
					GateMARMUX = 1'b1;
					GateMDR = 1'b0;
					GateALU = 1'b0;
					GatePC = 1'b0;
					MARMUX = 1'b1;
					ADDR1MUX = 1'b1;
					ADDR2MUX = 2'b01;
					DRMUX = 2'b00;
					SR1MUX = 2'b01;
					Mem_OE = 1'b0;
					end				
				S_21:
					begin
					LD_BEN = 1'b0;
					LD_MAR = 1'b0;
					LD_MDR = 1'b0;
					LD_IR = 1'b0;
					LD_PC = 1'b1;
					LD_REG = 1'b0;
					LD_CC = 1'b0;
					GateMARMUX = 1'b0;
					GateMDR = 1'b0;
					GateALU = 1'b0;
					GatePC = 1'b0;
					PCMUX = 2'b10;
					ADDR1MUX = 1'b0;
					ADDR2MUX = 2'b11;
					Mem_OE = 1'b0;
					end
				S_20:
					begin
					LD_BEN = 1'b0;
					LD_MAR = 1'b0;
					LD_MDR = 1'b0;
					LD_IR = 1'b0;
					LD_PC = 1'b1;
					LD_REG = 1'b0;
					LD_CC = 1'b0;
					GateMARMUX = 1'b0;
					GateMDR = 1'b0;
					GateALU = 1'b0;
					GatePC = 1'b0;
					PCMUX = 2'b10;
					ADDR1MUX = 1'b1;
					ADDR2MUX = 2'b00;
					SR1MUX = 2'b01;
					Mem_OE = 1'b0;
					end
				S_04:
					begin			//LDREG, GatePC = 1
					LD_BEN = 1'b0;
					LD_MAR = 1'b0;
					LD_MDR = 1'b0;
					LD_IR = 1'b0;
					LD_PC = 1'b1;
					LD_REG = 1'b1;
					LD_CC = 1'b0;
					GateMARMUX = 1'b0;
					GateMDR = 1'b0;
					GateALU = 1'b0;
					GatePC = 1'b1;
					DRMUX = 2'b01;
					Mem_OE = 1'b0;
					end
            default : ;
           endcase
       end 

	assign Mem_CE = 1'b0;
	assign Mem_UB = 1'b0;
	assign Mem_LB = 1'b0;
	
endmodule*/