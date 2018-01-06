module PowerUpDown_Generator (input Reset, frame_clk, levelChange, noMore,
										input logic [2:0] brickLevel_1, brickLevel_2, brickLevel_3, brickLevel_4,brickLevel_5,brickLevel_6,brickLevel_7,brickLevel_8,brickLevel_9,brickLevel_10,brickLevel_11,brickLevel_12,brickLevel_13,brickLevel_14,brickLevel_15,brickLevel_16,brickLevel_17,brickLevel_18,brickLevel_19,brickLevel_20,
										brickLevel_21, brickLevel_22, brickLevel_23, brickLevel_24,brickLevel_25,brickLevel_26,brickLevel_27,brickLevel_28,brickLevel_29,brickLevel_30,brickLevel_31,brickLevel_32,brickLevel_33,brickLevel_34,brickLevel_35,brickLevel_36,brickLevel_37,brickLevel_38,brickLevel_39,brickLevel_40,
										brickLevel_41, brickLevel_42, brickLevel_43, brickLevel_44,brickLevel_45,brickLevel_46,brickLevel_47,brickLevel_48,brickLevel_49,brickLevel_50,brickLevel_51,brickLevel_52,brickLevel_53,brickLevel_54,brickLevel_55,brickLevel_56,brickLevel_57,brickLevel_58,brickLevel_59,brickLevel_60,
										brickLevel_61, brickLevel_62, brickLevel_63, brickLevel_64,brickLevel_65,brickLevel_66,brickLevel_67,brickLevel_68,brickLevel_69,brickLevel_70,brickLevel_71, brickLevel_72, brickLevel_73, brickLevel_74,brickLevel_75,brickLevel_76,brickLevel_77,brickLevel_78,brickLevel_79,brickLevel_80,
										brickLevel_81,brickLevel_82,brickLevel_83,brickLevel_84,brickLevel_85,brickLevel_86,brickLevel_87,brickLevel_88,brickLevel_89,brickLevel_90,brickLevel_91, brickLevel_92, brickLevel_93, brickLevel_94,brickLevel_95,brickLevel_96,brickLevel_97,brickLevel_98,brickLevel_99,brickLevel_100,
										brickLevel_101,brickLevel_102,brickLevel_103,brickLevel_104,brickLevel_105,brickLevel_106,brickLevel_107,brickLevel_108,brickLevel_109,brickLevel_110,
										input logic [2:0]brick1, brick2, brick3, brick4,brick5,brick6,brick7,brick8,brick9,brick10,brick11,brick12,brick13,brick14,brick15,brick16,brick17,brick18,brick19,brick20,
										brick21, brick22, brick23, brick24,brick25,brick26,brick27,brick28,brick29,brick30,brick31,brick32,brick33,brick34,brick35,brick36,brick37,brick38,brick39,brick40,
										brick41, brick42, brick43, brick44,brick45,brick46,brick47,brick48,brick49,brick50,brick51,brick52,brick53,brick54,brick55,brick56,brick57,brick58,brick59,brick60,
										brick61, brick62, brick63, brick64,brick65,brick66,brick67,brick68,brick69,brick70,brick71,brick72,brick73,brick74,brick75,brick76,brick77,brick78,brick79,brick80,
										brick81,brick82,brick83,brick84,brick85,brick86,brick87,brick88,brick89,brick90,brick91,brick92,brick93,brick94,brick95,brick96,brick97,brick98,brick99,brick100,
										brick101,brick102,brick103,brick104,brick105,brick106,brick107,brick108,brick109,brick110,
										input logic [9:0] bX1, bY1, bX2, bY2, bX3, bY3, bX4, bY4, bX5, bY5, bX6, bY6, bX7, bY7, bX8, bY8, bX9, bY9, bX10, bY10,
										bX11, bY11, bX12, bY12, bX13, bY13, bX14, bY14, bX15, bY15, bX16, bY16, bX17, bY17, bX18, bY18, bX19, bY19, bX20, bY20, 
										bX21, bY21, bX22, bY22, bX23, bY23, bX24, bY24, bX25, bY25, bX26, bY26, bX27, bY27, bX28, bY28, bX29, bY29, bX30, bY30, 
										bX31, bY31, bX32, bY32, bX33, bY33, bX34, bY34, bX35, bY35, bX36, bY36, bX37, bY37, bX38, bY38, bX39, bY39, bX40, bY40, 
										bX41, bY41, bX42, bY42, bX43, bY43, bX44, bY44, bX45, bY45, bX46, bY46, bX47, bY47, bX48, bY48, bX49, bY49, bX50, bY50, 
										bX51, bY51, bX52, bY52, bX53, bY53, bX54, bY54, bX55, bY55, bX56, bY56, bX57, bY57, bX58, bY58, bX59, bY59, bX60, bY60,
										bX61, bY61, bX62, bY62, bX63, bY63, bX64, bY64, bX65, bY65, bX66, bY66, bX67, bY67, bX68, bY68, bX69, bY69, bX70, bY70,
										bX71, bY71, bX72, bY72, bX73, bY73, bX74, bY74, bX75, bY75, bX76, bY76, bX77, bY77, bX78, bY78, bX79, bY79, bX80, bY80, 
										bX81, bY81, bX82, bY82, bX83, bY83, bX84, bY84, bX85, bY85, bX86, bY86, bX87, bY87, bX88, bY88, bX89, bY89, bX90, bY90, 
										bX91, bY91, bX92, bY92, bX93, bY93, bX94, bY94, bX95, bY95, bX96, bY96, bX97, bY97, bX98, bY98, bX99, bY99, bX100, bY100, 
										bX101, bY101, bX102, bY102, bX103, bY103, bX104, bY104, bX105, bY105, bX106, bY106, bX107, bY107, bX108, bY108, bX109, bY109, bX110, bY110,
										input logic [9:0]  BallX, BallY, 
										input logic [10:0] score,
										input logic [9:0] paddleX1, paddleY1, paddleSize,
										output logic PaddleSizeUpPow,PaddleSizeDownPow,wrapAround,ballSizeUp,ballSizeDown,lifeUp,	PowOn,power_show
										output logic[9:0] PowX, PowY
										);
logic [3:0] PowerCount;
logic [4:0] PositionCount;
logic [9:0] pow_X_Pos,pow_Y_Pos,pow_Y_Motion;
logic countStop;

//paddle size increase/decrease, ball wrap around, invincibility,  //Powerups last for 15 bricks
always_ff @ (posedge Reset or posedge frame_clk)			 //need to reset the power up position...
begin
	if(Reset)
	begin
		countStop<=1'b0;//Lets the counting functions roll.
		PowOn<=1'b0;//Doesn't let the powerups effect anything
		pow_Y_Pos<=1'b0;
		pow_Y_Motion<=1'b0;
		pow_X_Pos<=1'b0;
		power_show<=1'b0;
	end
	else if(levelChange||noMore)
	begin
		countStop<=1'b0;
		PowOn<=1'b0;
		pow_Y_Pos<=1'b0;
		pow_X_Pos<=1'b0;
		pow_Y_Motion<=1'b0;
		power_show<=1'b0;
	end
	else
	begin	//Drop a square, IUNNO
		pow_X_Pos<=400;
		case(score)
		0:
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		5:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end
		10:
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		20:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end
		60: 
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		85:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end
		125: 
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		150:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end
		200: //lvl3
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		225:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end
		265: //lvl3
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		290:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end
		330: //lvl3
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		355:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end
		395: //lvl4
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		420:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end
		460: //lvl4
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		485:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end
		525: //lvl4
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		550:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end
		590: //lvl4
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		615:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end
		655: //lvl4
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		680:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end
		720: //lvl4
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		745: 
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end
		785: //lvl4
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		810:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end
		850: //lvl4
		begin
		countStop=1'b1;		
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		875:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end	
		915: //lvl5
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		940:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end		
		980: //lvl5
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		1005:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end		
		1045: //lvl5
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		1070:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end		
		1110: //lvl5
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		1135:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end				
		1175: //lvl5
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		1200:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end
		1240: //lvl5
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		1265:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end		
		1305: //lvl6
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		1330:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end		
		1370: //lvl6
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		1395:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end		
		1435: //lvl6
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		1460:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end		
		1500: //lvl6
		begin
		countStop=1'b1;
		pow_Y_Motion<= 5;
		power_show<=1'b1;
		end
		1525:
		begin
		PowOn=1'b0;
		countStop=1'b0;
		power_show<=1'b0;
		end		
		endcase
		if (((pow_Y_Pos+10)>=paddleY1)&&(PowX - paddleX1<=paddleSize)&&power_show==1'b1)
		begin
			PowOn=1'b1;
			power_show<=1'b0;
			pow_Y_Pos<=1'b0;
			pow_Y_Motion<=1'b0;
			countStop=1'b0;
		end
		else if (((pow_Y_Motion )<=paddleY1)&&power_show==1'b1)
			PowOn=1'b0;
		else
		begin
			power_show<=1'b0;
			pow_Y_Pos<=1'b0;
			pow_Y_Motion<=1'b0;
		end
	end
	pow_Y_Pos <= (pow_Y_Pos + pow_Y_Motion);
end
always_ff @ (posedge frame_clk)
begin
	if(Reset)
	begin
		PaddleSizeUpPow<=1'b0;
		PaddleSizeDownPow<=1'b0;
		wrapAround<=1'b0;
		ballSizeUp<=1'b0;
		ballSizeDown<=1'b0;
		lifeUp<=1'b0;
		PowerCount<=3'b000;
		PositionCount<=5'b00000;
	end
	else if(levelChange||noMore)
	begin
		PaddleSizeUpPow<=1'b0;
		PaddleSizeDownPow<=1'b0;
		wrapAround<=1'b0;
		ballSizeUp<=1'b0;
		ballSizeDown<=1'b0;
		lifeUp<=1'b0;
	end
else if(~countStop)
begin
	if (PowerCount==4'b0000)
	begin
		PaddleSizeUpPow<=1'b1;				
		PaddleSizeDownPow<=1'b0;
		wrapAround<=1'b0;
		ballSizeUp<=1'b0;
		ballSizeDown<=1'b0;
		lifeUp<=1'b0;
		PowerCount++;
	end
	else if (PowerCount==4'b0001)
		begin
		PaddleSizeUpPow<=1'b0;				
		PaddleSizeDownPow<=1'b1;
		wrapAround<=1'b0;
		ballSizeUp<=1'b0;
		ballSizeDown<=1'b0;
		lifeUp<=1'b0;
		PowerCount++;
	end
	else if (PowerCount==4'b0010)
		begin
		PaddleSizeUpPow<=1'b1;				
		PaddleSizeDownPow<=1'b0;
		wrapAround<=1'b0;//1'b1;
		ballSizeUp<=1'b0;
		ballSizeDown<=1'b0;
		lifeUp<=1'b0;
		PowerCount++;
	end
	else if (PowerCount==4'b0011)
		begin
		PaddleSizeUpPow<=1'b0;				
		PaddleSizeDownPow<=1'b0;
		wrapAround<=1'b0;
		ballSizeUp<=1'b1;
		ballSizeDown<=1'b0;
		lifeUp<=1'b0;
		PowerCount++;
	end
	else if (PowerCount==4'b0111)
		begin
		PaddleSizeUpPow<=1'b0;				
		PaddleSizeDownPow<=1'b0;
		wrapAround<=1'b0;
		ballSizeUp<=1'b0;
		ballSizeDown<=1'b1;
		lifeUp<=1'b0;
		PowerCount++;
	end
	else if (PowerCount==4'b1000)
		begin
		PaddleSizeUpPow<=1'b0;				
		PaddleSizeDownPow<=1'b0;
		wrapAround<=1'b0;
		ballSizeUp<=1'b0;
		ballSizeDown<=1'b0;
		lifeUp<=1'b1;
		PowerCount<=4'b0000;//++;
	end
	else if (PowerCount==4'b1001)//A chance none of the power ups will turn on even if you eat the block falling.
		begin
		PaddleSizeUpPow<=1'b0;				
		PaddleSizeDownPow<=1'b0;
		wrapAround<=1'b0;
		ballSizeUp<=1'b0;
		ballSizeDown<=1'b0;
		lifeUp<=1'b0;
		PowerCount<=4'b0000;
		end*/
	if(PositionCount==5'b00000)
	begin
		PowX<=26;
		PositionCount++;
	end
	else if (PositionCount==5'b00001)
		PositionCount++;
	else if (PositionCount==5'b00010)
		PositionCount++;
	else if(PositionCount==5'b00011)
	begin
		PowX<=PowX + 63;
		PositionCount++;
	end
	else if (PositionCount==5'b00100)
		PositionCount++;
	else if (PositionCount==5'b00101)
		PositionCount++;
	else if(PositionCount==5'b00111)
	begin
		PowX<=PowX + 63;
		PositionCount++;
	end
	else if (PositionCount==5'b01000)
		PositionCount++;
	else if (PositionCount==5'b01001)
		PositionCount++;
	else if(PositionCount==5'b01010)
	begin
		PowX<=PowX + 63;
		PositionCount++;
	end
	else if (PositionCount==5'b01011)
		PositionCount++;
	else if (PositionCount==5'b01100)
		PositionCount++;
	else if(PositionCount==5'b01101)
	begin
		PowX<=PowX + 63;
		PositionCount++;
	end
	else if (PositionCount==5'b01110)
		PositionCount++;
	else if (PositionCount==5'b01111)
		PositionCount++;
	else if(PositionCount==5'b10000)
	begin
		PowX<=PowX + 63;
		PositionCount++;
	end
	else if (PositionCount==5'b10000)
		PositionCount++;
	else if (PositionCount==5'b10001)
		PositionCount++;
	else if(PositionCount==5'b10010)
	begin
		PowX<=PowX + 63;
		PositionCount++;
	end
	else if (PositionCount==5'b10011)
		PositionCount++;
	else if (PositionCount==5'b10100)
		PositionCount++;
	else if(PositionCount==5'b100101)
	begin
		PowX<=PowX + 63;
		PositionCount++;
	end
	else if (PositionCount==5'b10110)
		PositionCount++;
	else if (PositionCount==5'b10111)
		PositionCount++;
	else if(PositionCount==5'b11000)
	begin
		PowX<=PowX + 63;
		PositionCount++;
	end
	else if (PositionCount==5'b11001)
		PositionCount++;
	else if (PositionCount==5'b11010)
		PositionCount++;
	else if(PositionCount==5'b11011)
	begin
		PowX<=PowX + 63;
		PositionCount++;
	end
	else if (PositionCount==5'b11100)
		PositionCount++;
	else if (PositionCount==5'b11101)
		PositionCount=5'b00000;
end
end
assign PowY = pow_Y_Pos;
assign PowX = pow_X_Pos;
endmodule				
//Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);
//assign BallY = Ball_Y_Pos;
