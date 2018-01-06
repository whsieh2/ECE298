//-------------------------------------------------------------------------
//      BouncingBall.sv                                                  --
//      Viral Mehta                                                      --
//      Spring 2005                                                      --
//                                                                       --
//      Modified by Stephen Kempf 03-01-2006                             --
//                                03-12-2007                             --
//      Fall 2013 Distribution                                           --
//                                                                       --
//      For use with ECE 298 Lab 7                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module  brick_breaker ( input        		 Clk,
														 Reset, 
														 ps2clk,
														 ps2data,
														 levelIncr,//Pin_P23
                       output logic [9:0]  Red,
														 Green,
														 Blue, 
							  output logic      	 VGA_clk,
														 sync,
														 blank,
														 vs,
														 hs, 
							  output logic [6:0]  sR1hexU, sR2hexU, sR1hexL, sR2hexL);
    
    logic Reset_h, vssig, up, left, down, right, Release, clockenable, levelChange,PaddleSizeUpPow, PaddleSizeDownPow, wrapAround,
				ballSizeUp, ballSizeDown,PowOn, power_show,lifeUp;//levelIncr_h,
    logic [9:0] drawxsig, drawysig, ballxsig, ballysig, ballsizesig;
	 logic [9:0] padx1sig, pady1sig, paddleSize;
	 logic [9:0] PowX, PowY;
	 logic [7:0] keyCode, sR2data;
	 logic [3:0] level;
	 logic [3:0] lives;
	 logic [10:0] score;
	 logic noMore,gameOver;
	 logic[ 2:0] brick1, brick2, brick3, brick4,brick5,brick6,brick7,brick8,brick9,brick10,brick11,brick12,brick13,brick14,brick15,brick16,brick17,brick18,brick19,brick20,
	 brick21, brick22, brick23, brick24,brick25,brick26,brick27,brick28,brick29,brick30,brick31,brick32,brick33,brick34,brick35,brick36,brick37,brick38,brick39,brick40,
	 brick41, brick42, brick43, brick44,brick45,brick46,brick47,brick48,brick49,brick50,brick51,brick52,brick53,brick54,brick55,brick56,brick57,brick58,brick59,brick60,
	 brick61, brick62, brick63, brick64,brick65,brick66,brick67,brick68,brick69,brick70,brick71, brick72, brick73, brick74,brick75,brick76,brick77,brick78,brick79,brick80,
	 brick81,brick82,brick83,brick84,brick85,brick86,brick87,brick88,brick89,brick90,brick91, brick92, brick93, brick94,brick95,brick96,brick97,brick98,brick99,brick100,
	 brick101,brick102,brick103,brick104,brick105,brick106,brick107,brick108,brick109,brick110;
	 logic [2:0] brickLevel_1, brickLevel_2, brickLevel_3, brickLevel_4,brickLevel_5,brickLevel_6,brickLevel_7,brickLevel_8,brickLevel_9,brickLevel_10,brickLevel_11,brickLevel_12,brickLevel_13,brickLevel_14,brickLevel_15,brickLevel_16,brickLevel_17,brickLevel_18,brickLevel_19,brickLevel_20,
					brickLevel_21, brickLevel_22, brickLevel_23, brickLevel_24,brickLevel_25,brickLevel_26,brickLevel_27,brickLevel_28,brickLevel_29,brickLevel_30,brickLevel_31,brickLevel_32,brickLevel_33,brickLevel_34,brickLevel_35,brickLevel_36,brickLevel_37,brickLevel_38,brickLevel_39,brickLevel_40,
					brickLevel_41, brickLevel_42, brickLevel_43, brickLevel_44,brickLevel_45,brickLevel_46,brickLevel_47,brickLevel_48,brickLevel_49,brickLevel_50,brickLevel_51,brickLevel_52,brickLevel_53,brickLevel_54,brickLevel_55,brickLevel_56,brickLevel_57,brickLevel_58,brickLevel_59,brickLevel_60,
					brickLevel_61, brickLevel_62, brickLevel_63, brickLevel_64,brickLevel_65,brickLevel_66,brickLevel_67,brickLevel_68,brickLevel_69,brickLevel_70,brickLevel_71, brickLevel_72, brickLevel_73, brickLevel_74,brickLevel_75,brickLevel_76,brickLevel_77,brickLevel_78,brickLevel_79,brickLevel_80,
					brickLevel_81,brickLevel_82,brickLevel_83,brickLevel_84,brickLevel_85,brickLevel_86,brickLevel_87,brickLevel_88,brickLevel_89,brickLevel_90,brickLevel_91, brickLevel_92, brickLevel_93, brickLevel_94,brickLevel_95,brickLevel_96,brickLevel_97,brickLevel_98,brickLevel_99,brickLevel_100,
					brickLevel_101,brickLevel_102,brickLevel_103,brickLevel_104,brickLevel_105,brickLevel_106,brickLevel_107,brickLevel_108,brickLevel_109,brickLevel_110;
	 logic [9:0] bX1, bY1, bX2, bY2, bX3, bY3, bX4, bY4, bX5, bY5, bX6, bY6, bX7, bY7, bX8, bY8, bX9, bY9, bX10, bY10,
		bX11, bY11, bX12, bY12, bX13, bY13, bX14, bY14, bX15, bY15, bX16, bY16, bX17, bY17, bX18, bY18, bX19, bY19, bX20, bY20, 
		bX21, bY21, bX22, bY22, bX23, bY23, bX24, bY24, bX25, bY25, bX26, bY26, bX27, bY27, bX28, bY28, bX29, bY29, bX30, bY30, 
		bX31, bY31, bX32, bY32, bX33, bY33, bX34, bY34, bX35, bY35, bX36, bY36, bX37, bY37, bX38, bY38, bX39, bY39, bX40, bY40, 
		bX41, bY41, bX42, bY42, bX43, bY43, bX44, bY44, bX45, bY45, bX46, bY46, bX47, bY47, bX48, bY48, bX49, bY49, bX50, bY50, 
		bX51, bY51, bX52, bY52, bX53, bY53, bX54, bY54, bX55, bY55, bX56, bY56, bX57, bY57, bX58, bY58, bX59, bY59, bX60, bY60,
		bX61, bY61, bX62, bY62, bX63, bY63, bX64, bY64, bX65, bY65, bX66, bY66, bX67, bY67, bX68, bY68, bX69, bY69, bX70, bY70,
		bX71, bY71, bX72, bY72, bX73, bY73, bX74, bY74, bX75, bY75, bX76, bY76, bX77, bY77, bX78, bY78, bX79, bY79, bX80, bY80, 
		bX81, bY81, bX82, bY82, bX83, bY83, bX84, bY84, bX85, bY85, bX86, bY86, bX87, bY87, bX88, bY88, bX89, bY89, bX90, bY90, 
		bX91, bY91, bX92, bY92, bX93, bY93, bX94, bY94, bX95, bY95, bX96, bY96, bX97, bY97, bX98, bY98, bX99, bY99, bX100, bY100, 
		bX101, bY101, bX102, bY102, bX103, bY103, bX104, bY104, bX105, bY105, bX106, bY106, bX107, bY107, bX108, bY108, bX109, bY109, bX110, bY110;
 
assign {Reset_h}=~ (Reset);  // The push buttons are active low	
assign {levelIncr_h}=~ (levelIncr);
	keyboard keyboard_instance(.Clk(Clk), .psClk(ps2clk), .psData(ps2data), 
										.Reset(Reset_h), .keyCode(keyCode), 
										.sR2data(sR2data), .sR1hexU(sR1hexU), 
										.sR2hexU(sR2hexU), .sR1hexL(sR1hexL), 
										.sR2hexL(sR2hexL), .clockenable(clockenable));
	
	direction direction_instance(.Clk(clockenable), .sR2data(sR2data),
										  .keyCode(keyCode), .up(up), .left(left),
										  .down(down), .right(right));
   
   vga_controller vgasync_instance(.*,
	                                .Clk(Clk),
											  .Reset(Reset_h),
											  .pixel_clk(VGA_clk),
											  .DrawX(drawxsig),
											  .DrawY(drawysig));
											  							 
   paddle paddle_instance(.Reset(Reset_h),
							 .up(up),
							 .left(left),
							 .down(down),
							 .right(right),
	                   .frame_clk(vs),    // Vertical Sync used as an "ad hoc" 60 Hz clock signal
	                   .paddleX1(padx1sig),  // (This is why we registered it in the vga controller!)
							 .paddleY1(pady1sig),
							 .noMore(noMore),
							 .levelChange(levelChange),
							 .paddleSize(paddleSize));	
   
   ball ball_instance(.*, .Reset(Reset_h),
							 .levelIncr(levelIncr_h),
							 .up(up),
							 .left(left),
							 .down(down),
							 .right(right),
	                   .frame_clk(vs),
							 .paddleX1(padx1sig),  
							 .paddleY1(pady1sig),// Vertical Sync used as an "ad hoc" 60 Hz clock signal
	                   .BallX(ballxsig),  // (This is why we registered it in the vga controller!)
							 .BallY(ballysig),
							 .BallS(ballsizesig),
							 .noMore(noMore),
							 .levelChange(levelChange),
							 .paddleSize(paddleSize));
					
  brickMaker level_maker(.*,.frame_clk(vs),.Reset(Reset_h));
  PowerUpDown_Generator ToPowOrNotPow(.*,.frame_clk(vs),
													  .Reset(Reset_t),
													  .BallX(ballxsig),
													 .BallY(ballysig),
													 .paddleX1(padx1sig),
													 .paddleY1(pady1sig));
  color_mapper color_instance(.*,
										 .Reset(Reset_h),
	                            .BallX(ballxsig),
										 .BallY(ballysig),
										 .PaddleX1(padx1sig),
										 .PaddleY1(pady1sig),
										 .paddleSize(paddleSize),
										 .DrawX(drawxsig),
										 .DrawY(drawysig),
										 .Ball_size(ballsizesig));
   
 

endmodule
