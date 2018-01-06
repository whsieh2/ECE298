//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Fall 2013 Distribution                                             --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------


//  POWERUPS - PADDLE SIZE, BALL WRAPAROUND, TWO BALLS(TRY OUT) EXTRA LIVES, INVINCIBILITY.
//  POWERDOWN - PADDLE SIZE, BALL SIZE.


module  ball ( input Reset, frame_clk, up, left, down, right,wrapAround, ballSizeUp, ballSizeDown,lifeUp,PowOn,levelIncr,
					input logic [9:0] paddleX1, paddleY1, paddleSize,
               output logic [9:0]  BallX, BallY, BallS, 
					output logic [3:0] level,
					output logic [3:0] lives, //Will give player a total of 5 lives.
					output logic [10:0] score, //increments 5 for every brick hit, and 15 for every level
					output logic noMore,levelChange,gameOver,
					input logic [2:0] brickLevel_1, brickLevel_2, brickLevel_3, brickLevel_4,brickLevel_5,brickLevel_6,brickLevel_7,brickLevel_8,brickLevel_9,brickLevel_10,brickLevel_11,brickLevel_12,brickLevel_13,brickLevel_14,brickLevel_15,brickLevel_16,brickLevel_17,brickLevel_18,brickLevel_19,brickLevel_20,
					brickLevel_21, brickLevel_22, brickLevel_23, brickLevel_24,brickLevel_25,brickLevel_26,brickLevel_27,brickLevel_28,brickLevel_29,brickLevel_30,brickLevel_31,brickLevel_32,brickLevel_33,brickLevel_34,brickLevel_35,brickLevel_36,brickLevel_37,brickLevel_38,brickLevel_39,brickLevel_40,
					brickLevel_41, brickLevel_42, brickLevel_43, brickLevel_44,brickLevel_45,brickLevel_46,brickLevel_47,brickLevel_48,brickLevel_49,brickLevel_50,brickLevel_51,brickLevel_52,brickLevel_53,brickLevel_54,brickLevel_55,brickLevel_56,brickLevel_57,brickLevel_58,brickLevel_59,brickLevel_60,
					brickLevel_61, brickLevel_62, brickLevel_63, brickLevel_64,brickLevel_65,brickLevel_66,brickLevel_67,brickLevel_68,brickLevel_69,brickLevel_70,brickLevel_71, brickLevel_72, brickLevel_73, brickLevel_74,brickLevel_75,brickLevel_76,brickLevel_77,brickLevel_78,brickLevel_79,brickLevel_80,
					brickLevel_81,brickLevel_82,brickLevel_83,brickLevel_84,brickLevel_85,brickLevel_86,brickLevel_87,brickLevel_88,brickLevel_89,brickLevel_90,brickLevel_91, brickLevel_92, brickLevel_93, brickLevel_94,brickLevel_95,brickLevel_96,brickLevel_97,brickLevel_98,brickLevel_99,brickLevel_100,
					brickLevel_101,brickLevel_102,brickLevel_103,brickLevel_104,brickLevel_105,brickLevel_106,brickLevel_107,brickLevel_108,brickLevel_109,brickLevel_110,
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
					output logic [2:0] brick1, brick2, brick3, brick4,brick5,brick6,brick7,brick8,brick9,brick10,brick11,brick12,brick13,brick14,brick15,brick16,brick17,brick18,brick19,brick20,
					brick21, brick22, brick23, brick24,brick25,brick26,brick27,brick28,brick29,brick30,brick31,brick32,brick33,brick34,brick35,brick36,brick37,brick38,brick39,brick40,
					brick41, brick42, brick43, brick44,brick45,brick46,brick47,brick48,brick49,brick50,brick51,brick52,brick53,brick54,brick55,brick56,brick57,brick58,brick59,brick60,
					brick61, brick62, brick63, brick64,brick65,brick66,brick67,brick68,brick69,brick70,brick71, brick72, brick73, brick74,brick75,brick76,brick77,brick78,brick79,brick80,
					brick81,brick82,brick83,brick84,brick85,brick86,brick87,brick88,brick89,brick90,brick91, brick92, brick93, brick94,brick95,brick96,brick97,brick98,brick99,brick100,
					brick101,brick102,brick103,brick104,brick105,brick106,brick107,brick108,brick109,brick110);
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size;
	 logic [9:0] stepX, stepY;
	 logic [3:0] levels;
	 logic youDied;
	
    parameter [9:0] Ball_X_Center=338;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=458;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=8;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=629;//639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=8;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=475;//479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=3;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=3;      // Step size on the Y axis
	 parameter [9:0] ballBig=10;	
	 parameter [9:0] ballSmall=3;
	 parameter [9:0] ballNormal=6;
	 logic [9:0] step_X_initial, step_Y_initial;
	 always_comb
	 begin

	 end
	 ball_launcher launch_one (.*); 
	 
    always_ff @ (posedge Reset or posedge frame_clk)
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
				Ball_Size<=ballNormal;
				score<=10'b0000000000;
            Ball_Y_Motion <= 0;
				Ball_X_Motion <= 0;
				Ball_Y_Pos <= Ball_Y_Center;
				Ball_X_Pos <= Ball_X_Center;
				youDied<=1'b0;
				noMore<=1'b1;
				levelChange<=1'b1;
				level<=4'b0001;
				lives<=4'b1001;
				brick1<=brickLevel_1; //I use brickLevel because I can't make the outputs of brickMaker brick# due to multiple assignment. So I set brick to the output each time 
				brick2<=brickLevel_2; //we change the level or reset. However the problem is that even when the levels change, the update of the bricks are still the previous level..
				brick3<=brickLevel_3; // could be a clock issue.
				brick4<=brickLevel_4;
				brick5<=brickLevel_5;
				brick6<=brickLevel_6;
				brick7<=brickLevel_7;
				brick8<=brickLevel_8;
				brick9<=brickLevel_9;
				brick10<=brickLevel_10;
				brick11<=brickLevel_11;
				brick12<=brickLevel_12;
				brick13<=brickLevel_13;
				brick14<=brickLevel_14;
				brick15<=brickLevel_15;
				brick16<=brickLevel_16;
				brick17<=brickLevel_17;
				brick18<=brickLevel_18;
				brick19<=brickLevel_19;
				brick20<=brickLevel_20;
				brick21<=brickLevel_21;
				brick22<=brickLevel_22;
				brick23<=brickLevel_23;
				brick24<=brickLevel_24;
				brick25<=brickLevel_25;
				brick26<=brickLevel_26;
				brick27<=brickLevel_27;
				brick28<=brickLevel_28;
				brick29<=brickLevel_29;
				brick30<=brickLevel_30;
				brick31<=brickLevel_31;
				brick32<=brickLevel_32;
				brick33<=brickLevel_33;
				brick34<=brickLevel_34;
				brick35<=brickLevel_35;
				brick36<=brickLevel_36;
				brick37<=brickLevel_37;
				brick38<=brickLevel_38;
				brick39<=brickLevel_39;
				brick40<=brickLevel_40;
				brick41<=brickLevel_41;
				brick42<=brickLevel_42;
				brick43<=brickLevel_43;
				brick44<=brickLevel_44;
				brick45<=brickLevel_45;
				brick46<=brickLevel_46;
				brick47<=brickLevel_47;
				brick48<=brickLevel_48;
				brick49<=brickLevel_49;
				brick50<=brickLevel_50;
				brick51<=brickLevel_51;
				brick52<=brickLevel_52;
				brick53<=brickLevel_53;
				brick54<=brickLevel_54;
				brick55<=brickLevel_55;
				brick56<=brickLevel_56;
				brick57<=brickLevel_57;
				brick58<=brickLevel_58;
				brick59<=brickLevel_59;
				brick60<=brickLevel_60;
				brick61<=brickLevel_61;
				brick62<=brickLevel_62;
				brick63<=brickLevel_63;
				brick64<=brickLevel_64;
				brick65<=brickLevel_65;
				brick66<=brickLevel_66;
				brick67<=brickLevel_67;
				brick68<=brickLevel_68;
				brick69<=brickLevel_69;
				brick70<=brickLevel_70;// After this should be 1/b0; for level 1
				brick71<=brickLevel_71; 
				brick72<=brickLevel_72; 
				brick73<=brickLevel_73; 
				brick74<=brickLevel_74;
				brick75<=brickLevel_75;
				brick76<=brickLevel_76;
				brick77<=brickLevel_77;
				brick78<=brickLevel_78;
				brick79<=brickLevel_79;
				brick80<=brickLevel_80;
				brick81<=brickLevel_81;
				brick82<=brickLevel_82;
				brick83<=brickLevel_83;
				brick84<=brickLevel_84;
				brick85<=brickLevel_85;
				brick86<=brickLevel_86;
				brick87<=brickLevel_87;
				brick88<=brickLevel_88;
				brick89<=brickLevel_89;
				brick90<=brickLevel_90;
				brick91<=brickLevel_91;
				brick92<=brickLevel_92; 
				brick93<=brickLevel_93; 
				brick94<=brickLevel_94;
				brick95<=brickLevel_95;
				brick96<=brickLevel_96;
				brick97<=brickLevel_97;
				brick98<=brickLevel_98;
				brick99<=brickLevel_99;
				brick100<=brickLevel_100;
				brick101<=brickLevel_101;
				brick102<=brickLevel_102;
				brick103<=brickLevel_103;
				brick104<=brickLevel_104;
				brick105<=brickLevel_105;
				brick106<=brickLevel_106;
				brick107<=brickLevel_107;
				brick108<=brickLevel_108;
				brick109<=brickLevel_109;
				brick110<=brickLevel_110;
		  	end
		   else if(((brick1|| brick2|| brick3|| brick4||brick5||brick6||brick7||brick8||brick9||brick10||brick11||brick12||brick13||brick14||brick15||brick16||brick17||brick18||brick19||brick20||
			brick21|| brick22|| brick23|| brick24||brick25||brick26||brick27||brick28||brick29||brick30||brick31||brick32||brick33||brick34||brick35||brick36||brick37||brick38||brick39||brick40||
			brick41|| brick42|| brick43|| brick44||brick45||brick46||brick47||brick48||brick49||brick50||brick51||brick52||brick53||brick54||brick55||brick56||brick57||brick58||brick59||brick60||
			brick61|| brick62|| brick63|| brick64||brick65||brick66||brick67||brick68||brick69||brick70||brick71|| brick72|| brick73|| brick74||brick75||brick76||brick77||brick78||brick79||brick80||
			brick81||brick82||brick83||brick84||brick85||brick86||brick87||brick88||brick89||brick90||brick91|| brick92|| brick93|| brick94||brick95||brick96||brick97||brick98||brick99||brick100||
			brick101||brick102||brick103||brick104||brick105||brick106||brick107||brick108||brick109||brick110)==3'b000)||levelIncr) //when all the bricks are zero, go to next level
			begin
				level<=level+4'b0001;
				levelChange<= 1'b1;
				score<=score+ 6'b000001;
				noMore<=1'b1; //make noMore 1 because the paddle needs to reset to relaunch the ball.
				Ball_Y_Pos <= Ball_Y_Center;
				Ball_X_Pos <= Ball_X_Center;
				Ball_Y_Motion <= 0; 
				Ball_X_Motion <= 0;
				Ball_Size<=ballNormal;
				brick1<=brickLevel_1;
				brick2<=brickLevel_2;
				brick3<=brickLevel_3;
				brick4<=brickLevel_4;
				brick5<=brickLevel_5;
				brick6<=brickLevel_6;
				brick7<=brickLevel_7;
				brick8<=brickLevel_8;
				brick9<=brickLevel_9;
				brick10<=brickLevel_10;
				brick11<=brickLevel_11;
				brick12<=brickLevel_12;
				brick13<=brickLevel_13;
				brick14<=brickLevel_14;
				brick15<=brickLevel_15;
				brick16<=brickLevel_16;
				brick17<=brickLevel_17;
				brick18<=brickLevel_18;
				brick19<=brickLevel_19;
				brick20<=brickLevel_20;
				brick21<=brickLevel_21;
				brick22<=brickLevel_22;
				brick23<=brickLevel_23;
				brick24<=brickLevel_24;
				brick25<=brickLevel_25;
				brick26<=brickLevel_26;
				brick27<=brickLevel_27;
				brick28<=brickLevel_28;
				brick29<=brickLevel_29;
				brick30<=brickLevel_30;
				brick31<=brickLevel_31;
				brick32<=brickLevel_32;
				brick33<=brickLevel_33;
				brick34<=brickLevel_34;
				brick35<=brickLevel_35;
				brick36<=brickLevel_36;
				brick37<=brickLevel_37;
				brick38<=brickLevel_38;
				brick39<=brickLevel_39;
				brick40<=brickLevel_40;
				brick41<=brickLevel_41;
				brick42<=brickLevel_42;
				brick43<=brickLevel_43;
				brick44<=brickLevel_44;
				brick45<=brickLevel_45;
				brick46<=brickLevel_46;
				brick47<=brickLevel_47;
				brick48<=brickLevel_48;
				brick49<=brickLevel_49;
				brick50<=brickLevel_50;
				brick51<=brickLevel_51;
				brick52<=brickLevel_52;
				brick53<=brickLevel_53;
				brick54<=brickLevel_54;
				brick55<=brickLevel_55;
				brick56<=brickLevel_56;
				brick57<=brickLevel_57;
				brick58<=brickLevel_58;
				brick59<=brickLevel_59;
				brick60<=brickLevel_60;
				brick61<=brickLevel_61;
				brick62<=brickLevel_62;
				brick63<=brickLevel_63;
				brick64<=brickLevel_64;
				brick65<=brickLevel_65;
				brick66<=brickLevel_66;
				brick67<=brickLevel_67;
				brick68<=brickLevel_68;
				brick69<=brickLevel_69;
				brick70<=brickLevel_70;// After this should be 1/b0; for level 1
				brick71<=brickLevel_71; 
				brick72<=brickLevel_72; 
				brick73<=brickLevel_73; 
				brick74<=brickLevel_74;
				brick75<=brickLevel_75;
				brick76<=brickLevel_76;
				brick77<=brickLevel_77;
				brick78<=brickLevel_78;
				brick79<=brickLevel_79;
				brick80<=brickLevel_80;
				brick81<=brickLevel_81;
				brick82<=brickLevel_82;
				brick83<=brickLevel_83;
				brick84<=brickLevel_84;
				brick85<=brickLevel_85;
				brick86<=brickLevel_86;
				brick87<=brickLevel_87;
				brick88<=brickLevel_88;
				brick89<=brickLevel_89;
				brick90<=brickLevel_90;
				brick91<=brickLevel_91;
				brick92<=brickLevel_92; 
				brick93<=brickLevel_93; 
				brick94<=brickLevel_94;
				brick95<=brickLevel_95;
				brick96<=brickLevel_96;
				brick97<=brickLevel_97;
				brick98<=brickLevel_98;
				brick99<=brickLevel_99;
				brick100<=brickLevel_100;
				brick101<=brickLevel_101;
				brick102<=brickLevel_102;
				brick103<=brickLevel_103;
				brick104<=brickLevel_104;
				brick105<=brickLevel_105;
				brick106<=brickLevel_106;
				brick107<=brickLevel_107;
				brick108<=brickLevel_108;
				brick109<=brickLevel_109;
				brick110<=brickLevel_110;
				//end
		  end
		  else if (( (Ball_Y_Pos) >= Ball_Y_Max ))  // Ball is at bottom edge, time to die friend
		  begin
						//Ball_Y_Motion <=~stepY+1'b1;
						levelChange<=1'b1;		
						Ball_Y_Motion <= 0;
						Ball_X_Motion <= 0;
						Ball_Y_Pos <= Ball_Y_Center;
						Ball_X_Pos <= Ball_X_Center;
						noMore<=1'b1;
						youDied<=1'b1;
				if (lives<=4'b0000)
				begin
						gameOver<=1'b1;
						levelChange<= 1'b1;
						level<=4'b1000;
						noMore<=1'b1;
						brick1<=brickLevel_1;
						brick2<=brickLevel_2;
						brick3<=brickLevel_3;
						brick4<=brickLevel_4;
						brick5<=brickLevel_5;
						brick6<=brickLevel_6;
						brick7<=brickLevel_7;
						brick8<=brickLevel_8;
						brick9<=brickLevel_9;
						brick10<=brickLevel_10;
						brick11<=brickLevel_11;
						brick12<=brickLevel_12;
						brick13<=brickLevel_13;
						brick14<=brickLevel_14;
						brick15<=brickLevel_15;
						brick16<=brickLevel_16;
						brick17<=brickLevel_17;
						brick18<=brickLevel_18;
						brick19<=brickLevel_19;
						brick20<=brickLevel_20;
						brick21<=brickLevel_21;
						brick22<=brickLevel_22;
						brick23<=brickLevel_23;
						brick24<=brickLevel_24;
						brick25<=brickLevel_25;
						brick26<=brickLevel_26;
						brick27<=brickLevel_27;
						brick28<=brickLevel_28;
						brick29<=brickLevel_29;
						brick30<=brickLevel_30;
						brick31<=brickLevel_31;
						brick32<=brickLevel_32;
						brick33<=brickLevel_33;
						brick34<=brickLevel_34;
						brick35<=brickLevel_35;
						brick36<=brickLevel_36;
						brick37<=brickLevel_37;
						brick38<=brickLevel_38;
						brick39<=brickLevel_39;
						brick40<=brickLevel_40;
						brick41<=brickLevel_41;
						brick42<=brickLevel_42;
						brick43<=brickLevel_43;
						brick44<=brickLevel_44;
						brick45<=brickLevel_45;
						brick46<=brickLevel_46;
						brick47<=brickLevel_47;
						brick48<=brickLevel_48;
						brick49<=brickLevel_49;
						brick50<=brickLevel_50;
						brick51<=brickLevel_51;
						brick52<=brickLevel_52;
						brick53<=brickLevel_53;
						brick54<=brickLevel_54;
						brick55<=brickLevel_55;
						brick56<=brickLevel_56;
						brick57<=brickLevel_57;
						brick58<=brickLevel_58;
						brick59<=brickLevel_59;
						brick60<=brickLevel_60;
						brick61<=brickLevel_61;
						brick62<=brickLevel_62;
						brick63<=brickLevel_63;
						brick64<=brickLevel_64;
						brick65<=brickLevel_65;
						brick66<=brickLevel_66;
						brick67<=brickLevel_67;
						brick68<=brickLevel_68;
						brick69<=brickLevel_69;
						brick70<=brickLevel_70;// After this should be 1/b0; for level 1
						brick71<=brickLevel_71; 
						brick72<=brickLevel_72; 
						brick73<=brickLevel_73; 
						brick74<=brickLevel_74;
						brick75<=brickLevel_75;
						brick76<=brickLevel_76;
						brick77<=brickLevel_77;
						brick78<=brickLevel_78;
						brick79<=brickLevel_79;
						brick80<=brickLevel_80;
						brick81<=brickLevel_81;
						brick82<=brickLevel_82;
						brick83<=brickLevel_83;
						brick84<=brickLevel_84;
						brick85<=brickLevel_85;
						brick86<=brickLevel_86;
						brick87<=brickLevel_87;
						brick88<=brickLevel_88;
						brick89<=brickLevel_89;
						brick90<=brickLevel_90;
						brick91<=brickLevel_91;
						brick92<=brickLevel_92; 
						brick93<=brickLevel_93; 
						brick94<=brickLevel_94;
						brick95<=brickLevel_95;
						brick96<=brickLevel_96;
						brick97<=brickLevel_97;
						brick98<=brickLevel_98;
						brick99<=brickLevel_99;
						brick100<=brickLevel_100;
						brick101<=brickLevel_101;
						brick102<=brickLevel_102;
						brick103<=brickLevel_103;
						brick104<=brickLevel_104;
						brick105<=brickLevel_105;
						brick106<=brickLevel_106;
						brick107<=brickLevel_107;
						brick108<=brickLevel_108;
						brick109<=brickLevel_109;
						brick110<=brickLevel_110;
				end	
				else
				lives<=lives-4'b0001;
		  end
		  else
		  begin
				if((down && ~up && ~left && ~right && noMore))
					 begin
						Ball_Y_Motion <= (~ (step_Y_initial) + 1'b1);
						Ball_X_Motion <= step_X_initial;
						noMore<=1'b0;
						levelChange<=1'b0;
						youDied<=1'b0;
						stepX <= step_X_initial;
						stepY <= step_Y_initial;
					 end
				if(PowOn)
				begin
					 if ((ballSizeUp))
						Ball_Size<=ballBig;
					else if((ballSizeDown))
						Ball_Size<=ballSmall;
				end
				else if(~PowOn)
					Ball_Size<=ballNormal;
				if ( ((Ball_X_Pos - Ball_Size) <= Ball_X_Min )/*&&(~wrapAround)*/)  // Ball is at the  left edge, BOUNCE!
					  begin
					 /* if ((Ball_X_Pos+Ball_Size)<=Ball_X_Max)
							Ball_X_Motion <= (~ (stepX) + 1'b1);
					  else */
					  Ball_X_Pos<=Ball_X_Min+2;
					  Ball_X_Motion <= stepX;
					  noMore<=1'b0;
					  end
				else if ( ((Ball_X_Pos + Ball_Size) >= Ball_X_Max )/*&&(~wrapAround)*/)  // Ball is at the  right edge, BOUNCE!
					  begin
					 /* if ((Ball_X_Pos-Ball_Size)>=Ball_X_Min)
							Ball_X_Motion <= stepX;
					  else*/
					  Ball_X_Pos<=Ball_X_Max-2;
					  Ball_X_Motion <= (~ (stepX) + 1'b1);  // 2's complement.
					  noMore<=1'b0;

					  end

				else if (((Ball_Y_Pos + Ball_Size+3)>=paddleY1)&&(Ball_X_Pos - paddleX1<=paddleSize)&&~(noMore))  // Ball is at the bottom edge, BOUNCE!
					  begin
						  noMore<=1'b0;
						  if(~down && ~up && left && ~right&&(Ball_X_Motion==stepX)&&~(noMore)) //if the paddle is going left and the ball right
						  begin
								if(stepX==1'b1) //if the step is at its minimum just switch directions
								Ball_X_Motion<=~stepX+1'b1;
								else //otherwise decrement the step
								begin
								stepX<=stepX-1'b1;
								Ball_X_Motion<=stepX;
								end
						  end
						  else if(~down && ~up && left && ~right&&(Ball_X_Motion==(~stepX+1'b1))&&~(noMore)&&(stepX<=8)) //if the paddle is going left and the ball left
						  begin
								if (stepX<=7) //we don't want the ball being faster than the paddle
								begin
									stepX<=stepX+1'b1; //increase the step
									if(stepX/stepY>2) //if X step is 2 times Y step, increase Y.
										stepY<=stepY+1;
									else if(stepY/stepX>2)// if Y step is 2 times X step, decrease Y.
										stepY<=stepY-1;
									Ball_X_Motion<=(~stepX+1'b1);
								end
						  end
						  else if (~down && ~up && ~left && right&&(Ball_X_Motion==(~stepX+1'b1))&&~(noMore)) //if paddle is going right and the ball is going left
						  begin
								if(stepX==1'b1) // if the step is at its minimum, just switch directions
									Ball_X_Motion<=stepX;
								else //otherwise decrement the step
								begin
								stepX<=stepX-1'b1;
								Ball_X_Motion<=(~stepX+1'b1);
								end
						  end
						  else if (~down && ~up && ~left && right&&(Ball_X_Motion==stepX)&&~(noMore)&&(stepX<=8))// if the paddle is going right and the ball right
						  begin
								if(stepX<=7)//we don't want the ball being faster than the paddle
								begin
									stepX<=stepX+1'b1; //increase the step
									if(stepX/stepY>2) //if X step is 2 times Y step, increase Y.
										stepY<=stepY+1;
									else if(stepY/stepX>2) // if Y step is 2 times X step, decrease Y.
										stepY<=stepY-1;
									Ball_X_Motion<=stepX;
								end
						  end
						  Ball_Y_Motion <= (~ (stepY) + 1'b1); // ball bounces off the paddle! :D
					  end
					else if (( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min ))  // Ball is at the top edge, BOUNCE!
					  begin
						Ball_Y_Motion <=stepY;
						noMore<=1'b0;
					  end		
	
				/* This code need to go somewhere else, because all variables are not specified here*/	  
				//If Ball at the brick boundaries, BOUNCE! and brick should get destroyed 
				else if(((Ball_Y_Pos - Ball_Size)<=bY1+15)&&(Ball_X_Pos - bX1<=57)&&Ball_X_Pos>=bX1/*&&brickLevel_1*/&&brick1) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY1) 
					begin
						Ball_Y_Motion <= stepY;
						score<=score+3'b001;
						brick1<=brick1-3'b001;
						noMore<= 1'b0;
					end
					else if(Ball_Y_Pos+Ball_Size>=bY1)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						score<=score+3'b001;
						brick1<=brick1-3'b001;
						noMore<= 1'b0;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX1+62)&&(Ball_Y_Pos - bY1<=10)&&Ball_Y_Pos>=bY1/*&&brickLevel_1*/&&brick1) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX1) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						score<=score+3'b001;						
						brick1<=brick1-3'b001;
						noMore<= 1'b0;
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX1) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						score<=score+3'b001;						
						brick1<=brick1-3'b001;
						noMore<= 1'b0;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY2+15)&&(Ball_X_Pos - bX2<=57)&&Ball_X_Pos>=bX2/*&&brickLevel_2*/&&brick2) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY2) 
					begin
						Ball_Y_Motion <= stepY;
						score<=score+3'b001;						
						brick2<=brick2-3'b001;
						noMore<= 1'b0;
					end
					else if(Ball_Y_Pos+Ball_Size>=bY2)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						score<=score+3'b001;						
						brick2<=brick2-3'b001;
						noMore<= 1'b0;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX2+62)&&(Ball_Y_Pos - bY2<=10)&&Ball_Y_Pos>=bY2/*&&brickLevel_2*/&&brick2) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX2) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						score<=score+3'b001;						
						brick2<=brick2-3'b001;
						noMore<= 1'b0;
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX2) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						score<=score+3'b001;						
						brick2<=brick2-3'b001;
						noMore<= 1'b0;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY3+15)&&(Ball_X_Pos - bX3<=57)&&Ball_X_Pos>=bX3/*&&brickLevel_3*/&&brick3) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY3) 
					begin
						Ball_Y_Motion <= stepY;
						score<=score+3'b001;						
						brick3<=brick3-3'b001;
						noMore<= 1'b0;
					end
					else if(Ball_Y_Pos+Ball_Size>=bY3)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						score<=score+3'b001;						
						brick3<=brick3-3'b001;
						noMore<= 1'b0;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX3+62)&&(Ball_Y_Pos - bY3<=10)&&Ball_Y_Pos>=bY3/*&&brickLevel_3*/&&brick3) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX3) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						score<=score+3'b001;						
						brick3<=brick3-3'b001;
						noMore<= 1'b0;
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX3) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						score<=score+3'b001;						
						brick3<=brick3-3'b001;
						noMore<= 1'b0;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY4+15)&&(Ball_X_Pos - bX4<=57)&&Ball_X_Pos>=bX4/*&&brickLevel_4*/&&brick4) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY4) 
					begin
						Ball_Y_Motion <= stepY;
						score<=score+3'b001;						
						brick4<=brick4-3'b001;
						noMore<= 1'b0;
					end
					else if(Ball_Y_Pos+Ball_Size>=bY4)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						score<=score+3'b001;						
						brick4<=brick4-3'b001;
						noMore<= 1'b0;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX4+62)&&(Ball_Y_Pos - bY4<=10)&&Ball_Y_Pos>=bY4/*&&brickLevel_4*/&&brick4) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX4) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						score<=score+3'b001;
						brick4<=brick4-3'b001;
						noMore<= 1'b0;
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX4) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						score<=score+3'b001;						
						brick4<=brick4-3'b001;
						noMore<= 1'b0;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY5+15)&&(Ball_X_Pos - bX5<=57)&&Ball_X_Pos>=bX5/*&&brickLevel_5*/&&brick5) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY5) 
					begin
						Ball_Y_Motion <= stepY;
						score<=score+3'b001;	
						brick5<=brick5-3'b001;
						noMore<= 1'b0;
					end
					else if(Ball_Y_Pos+Ball_Size>=bY5)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						score<=score+3'b001;	
						brick5<=brick5-3'b001;
						noMore<= 1'b0;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX5+62)&&(Ball_Y_Pos - bY5<=10)&&Ball_Y_Pos>=bY5/*&&brickLevel_5*/&&brick5) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX5) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						score<=score+3'b001;
						brick5<=brick5-3'b001;
						noMore<= 1'b0;
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX5) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						score<=score+3'b001;
						brick5<=brick5-3'b001;
						noMore<= 1'b0;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY6+15)&&(Ball_X_Pos - bX6<=57)&&Ball_X_Pos>=bX6/*&&brickLevel_6*/&&brick6) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY6) 
					begin
						Ball_Y_Motion <= stepY;
						brick6<=brick6-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY6)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick6<=brick6-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX6+62)&&(Ball_Y_Pos - bY6<=10)&&Ball_Y_Pos>=bY6/*&&brickLevel_6*/&&brick6) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX6) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick6<=brick6-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX6) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick6<=brick6-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY7+15)&&(Ball_X_Pos - bX7<=57)&&Ball_X_Pos>=bX7/*&&brickLevel_7*/&&brick7) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY7) 
					begin
						Ball_Y_Motion <= stepY;
						brick7<=brick7-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY7)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick7<=brick7-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX7+62)&&(Ball_Y_Pos - bY7<=10)&&Ball_Y_Pos>=bY7/*&&brickLevel_7*/&&brick7) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX7) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick7<=brick7-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX7) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick7<=brick7-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY8+15)&&(Ball_X_Pos - bX8<=57)&&Ball_X_Pos>=bX8/*&&brickLevel_8*/&&brick8) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY8) 
					begin
						Ball_Y_Motion <= stepY;
						brick8<=brick8-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY8)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick8<=brick8-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX8+62)&&(Ball_Y_Pos - bY8<=10)&&Ball_Y_Pos>=bY8/*&&brickLevel_8*/&&brick8) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX8) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick8<=brick8-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX8) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick8<=brick8-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY9+15)&&(Ball_X_Pos - bX9<=57)&&Ball_X_Pos>=bX9/*&&brickLevel_9*/&&brick9) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY9) 
					begin
						Ball_Y_Motion <= stepY;
						brick9<=brick9-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY9)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick9<=brick9-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX9+62)&&(Ball_Y_Pos - bY9<=10)&&Ball_Y_Pos>=bY9/*&&brickLevel_9*/&&brick9) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX9) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick9<=brick9-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX9) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick9<=brick9-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY11+15)&&(Ball_X_Pos - bX11<=57)&&Ball_X_Pos>=bX11/*&&brickLevel_11*/&&brick11) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY11) 
					begin
						Ball_Y_Motion <= stepY;
						brick11<=brick11-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY11)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick11<=brick11-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX11+62)&&(Ball_Y_Pos - bY11<=10)&&Ball_Y_Pos>=bY11/*&&brickLevel_11*/&&brick11) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX11) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick11<=brick11-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX11) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick11<=brick11-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY12+15)&&(Ball_X_Pos - bX12<=57)&&Ball_X_Pos>=bX12/*&&brickLevel_12*/&&brick12) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY12) 
					begin
						Ball_Y_Motion <= stepY;
						brick12<=brick12-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY12)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick12<=brick12-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX12+62)&&(Ball_Y_Pos - bY12<=10)&&Ball_Y_Pos>=bY12/*&&brickLevel_12*/&&brick12) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX12) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick12<=brick12-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX12) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick12<=brick12-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY13+15)&&(Ball_X_Pos - bX13<=57)&&Ball_X_Pos>=bX13/*&&brickLevel_13*/&&brick13) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY13) 
					begin
						Ball_Y_Motion <= stepY;
						brick13<=brick13-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY13)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick13<=brick13-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX13+62)&&(Ball_Y_Pos - bY13<=10)&&Ball_Y_Pos>=bY13/*&&brickLevel_13*/&&brick13) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX13) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick13<=brick13-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX13) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick13<=brick13-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY14+15)&&(Ball_X_Pos - bX14<=57)&&Ball_X_Pos>=bX14/*&&brickLevel_14*/&&brick14) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY14) 
					begin
						Ball_Y_Motion <= stepY;
						brick14<=brick14-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY14)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick14<=brick14-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX14+62)&&(Ball_Y_Pos - bY14<=10)&&Ball_Y_Pos>=bY14/*&&brickLevel_14*/&&brick14) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX14) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick14<=brick14-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX14) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick14<=brick14-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY15+15)&&(Ball_X_Pos - bX15<=57)&&Ball_X_Pos>=bX15/*&&brickLevel_15*/&&brick15) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY15) 
					begin
						Ball_Y_Motion <= stepY;
						brick15<=brick15-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY15)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick15<=brick15-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX15+62)&&(Ball_Y_Pos - bY15<=10)&&Ball_Y_Pos>=bY15/*&&brickLevel_15*/&&brick15) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX15) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick15<=brick15-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX15) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick15<=brick15-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY16+15)&&(Ball_X_Pos - bX16<=57)&&Ball_X_Pos>=bX16/*&&brickLevel_16*/&&brick16) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY16) 
					begin
						Ball_Y_Motion <= stepY;
						brick16<=brick16-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY16)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick16<=brick16-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX16+62)&&(Ball_Y_Pos - bY16<=10)&&Ball_Y_Pos>=bY16/*&&brickLevel_16*/&&brick16) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX16) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick16<=brick16-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX16) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick16<=brick16-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY17+15)&&(Ball_X_Pos - bX17<=57)&&Ball_X_Pos>=bX17/*&&brickLevel_17*/&&brick17) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY17) 
					begin
						Ball_Y_Motion <= stepY;
						brick17<=brick17-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY17)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick17<=brick17-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX17+62)&&(Ball_Y_Pos - bY17<=10)&&Ball_Y_Pos>=bY17/*&&brickLevel_17*/&&brick17) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX17) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick17<=brick17-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX17) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick17<=brick17-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY18+15)&&(Ball_X_Pos - bX18<=57)&&Ball_X_Pos>=bX18/*&&brickLevel_18*/&&brick18) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY18) 
					begin
						Ball_Y_Motion <= stepY;
						brick18<=brick18-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY18)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick18<=brick18-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX18+62)&&(Ball_Y_Pos - bY18<=10)&&Ball_Y_Pos>=bY18/*&&brickLevel_18*/&&brick18) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX18) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick18<=brick18-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX18) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick18<=brick18-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY19+15)&&(Ball_X_Pos - bX19<=57)&&Ball_X_Pos>=bX19/*&&brickLevel_19*/&&brick19) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY19) 
					begin
						Ball_Y_Motion <= stepY;
						brick19<=brick19-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY19)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick19<=brick19-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX19+62)&&(Ball_Y_Pos - bY19<=10)&&Ball_Y_Pos>=bY19/*&&brickLevel_19*/&&brick19) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX19) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick19<=brick19-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX19) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick19<=brick19-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY21+15)&&(Ball_X_Pos - bX21<=57)&&Ball_X_Pos>=bX21/*&&brickLevel_21*/&&brick21) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY21) 
					begin
						Ball_Y_Motion <= stepY;
						brick21<=brick21-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY21)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick21<=brick21-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX21+62)&&(Ball_Y_Pos - bY21<=10)&&Ball_Y_Pos>=bY21/*&&brickLevel_21*/&&brick21) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX21) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick21<=brick21-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX21) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick21<=brick21-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY22+15)&&(Ball_X_Pos - bX22<=57)&&Ball_X_Pos>=bX22/*&&brickLevel_22*/&&brick22) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY22) 
					begin
						Ball_Y_Motion <= stepY;
						brick22<=brick22-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY22)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick22<=brick22-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX22+62)&&(Ball_Y_Pos - bY22<=10)&&Ball_Y_Pos>=bY22/*&&brickLevel_22*/&&brick22) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX22) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick22<=brick22-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX22) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick22<=brick22-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY23+15)&&(Ball_X_Pos - bX23<=57)&&Ball_X_Pos>=bX23/*&&brickLevel_23*/&&brick23) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY23) 
					begin
						Ball_Y_Motion <= stepY;
						brick23<=brick23-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY23)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick23<=brick23-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX23+62)&&(Ball_Y_Pos - bY23<=10)&&Ball_Y_Pos>=bY23/*&&brickLevel_23*/&&brick23) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX23) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick23<=brick23-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX23) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick23<=brick23-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY24+15)&&(Ball_X_Pos - bX24<=57)&&Ball_X_Pos>=bX24/*&&brickLevel_24*/&&brick24) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY24) 
					begin
						Ball_Y_Motion <= stepY;
						brick24<=brick24-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY24)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick24<=brick24-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX24+62)&&(Ball_Y_Pos - bY24<=10)&&Ball_Y_Pos>=bY24/*&&brickLevel_24*/&&brick24) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX24) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick24<=brick24-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX24) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick24<=brick24-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY25+15)&&(Ball_X_Pos - bX25<=57)&&Ball_X_Pos>=bX25/*&&brickLevel_25*/&&brick25) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY25) 
					begin
						Ball_Y_Motion <= stepY;
						brick25<=brick25-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY25)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick25<=brick25-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX25+62)&&(Ball_Y_Pos - bY25<=10)&&Ball_Y_Pos>=bY25/*&&brickLevel_25*/&&brick25) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX25) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick25<=brick25-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX25) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick25<=brick25-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY26+15)&&(Ball_X_Pos - bX26<=57)&&Ball_X_Pos>=bX26/*&&brickLevel_26*/&&brick26) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY26) 
					begin
						Ball_Y_Motion <= stepY;
						brick26<=brick26-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY26)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick26<=brick26-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX26+62)&&(Ball_Y_Pos - bY26<=10)&&Ball_Y_Pos>=bY26/*&&brickLevel_26*/&&brick26) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX26) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick26<=brick26-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX26) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick26<=brick26-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY27+15)&&(Ball_X_Pos - bX27<=57)&&Ball_X_Pos>=bX27/*&&brickLevel_27*/&&brick27) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY27) 
					begin
						Ball_Y_Motion <= stepY;
						brick27<=brick27-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY27)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick27<=brick27-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX27+62)&&(Ball_Y_Pos - bY27<=10)&&Ball_Y_Pos>=bY27/*&&brickLevel_27*/&&brick27) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX27) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick27<=brick27-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX27) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick27<=brick27-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY28+15)&&(Ball_X_Pos - bX28<=57)&&Ball_X_Pos>=bX28/*&&brickLevel_28*/&&brick28) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY28) 
					begin
						Ball_Y_Motion <= stepY;
						brick28<=brick28-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY28)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick28<=brick28-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX28+62)&&(Ball_Y_Pos - bY28<=10)&&Ball_Y_Pos>=bY28/*&&brickLevel_28*/&&brick28) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX28) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick28<=brick28-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX28) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick28<=brick28-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY29+15)&&(Ball_X_Pos - bX29<=57)&&Ball_X_Pos>=bX29/*&&brickLevel_29*/&&brick29) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY29) 
					begin
						Ball_Y_Motion <= stepY;
						brick29<=brick29-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY29)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick29<=brick29-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX29+62)&&(Ball_Y_Pos - bY29<=10)&&Ball_Y_Pos>=bY29/*&&brickLevel_29*/&&brick29) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX29) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick29<=brick29-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX29) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick29<=brick29-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY31+15)&&(Ball_X_Pos - bX31<=57)&&Ball_X_Pos>=bX31/*&&brickLevel_31*/&&brick31) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY31) 
					begin
						Ball_Y_Motion <= stepY;
						brick31<=brick31-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY31)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick31<=brick31-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX31+62)&&(Ball_Y_Pos - bY31<=10)&&Ball_Y_Pos>=bY31/*&&brickLevel_31*/&&brick31) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX31) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick31<=brick31-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX31) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick31<=brick31-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY32+15)&&(Ball_X_Pos - bX32<=57)&&Ball_X_Pos>=bX32/*&&brickLevel_32*/&&brick32) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY32) 
					begin
						Ball_Y_Motion <= stepY;
						brick32<=brick32-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY32)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick32<=brick32-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX32+62)&&(Ball_Y_Pos - bY32<=10)&&Ball_Y_Pos>=bY32/*&&brickLevel_32*/&&brick32) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX32) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick32<=brick32-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX32) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick32<=brick32-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY33+15)&&(Ball_X_Pos - bX33<=57)&&Ball_X_Pos>=bX33/*&&brickLevel_33*/&&brick33) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY33) 
					begin
						Ball_Y_Motion <= stepY;
						brick33<=brick33-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY33)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick33<=brick33-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX33+62)&&(Ball_Y_Pos - bY33<=10)&&Ball_Y_Pos>=bY33/*&&brickLevel_33*/&&brick33) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX33) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick33<=brick33-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX33) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick33<=brick33-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY34+15)&&(Ball_X_Pos - bX34<=57)&&Ball_X_Pos>=bX34/*&&brickLevel_34*/&&brick34) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY34) 
					begin
						Ball_Y_Motion <= stepY;
						brick34<=brick34-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY34)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick34<=brick34-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX34+62)&&(Ball_Y_Pos - bY34<=10)&&Ball_Y_Pos>=bY34/*&&brickLevel_34*/&&brick34) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX34) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick34<=brick34-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX34) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick34<=brick34-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY35+15)&&(Ball_X_Pos - bX35<=57)&&Ball_X_Pos>=bX35/*&&brickLevel_35*/&&brick35) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY35) 
					begin
						Ball_Y_Motion <= stepY;
						brick35<=brick35-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY35)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick35<=brick35-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX35+62)&&(Ball_Y_Pos - bY35<=10)&&Ball_Y_Pos>=bY35/*&&brickLevel_35*/&&brick35) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX35) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick35<=brick35-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX35) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick35<=brick35-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY36+15)&&(Ball_X_Pos - bX36<=57)&&Ball_X_Pos>=bX36/*&&brickLevel_36*/&&brick36) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY36) 
					begin
						Ball_Y_Motion <= stepY;
						brick36<=brick36-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY36)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick36<=brick36-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX36+62)&&(Ball_Y_Pos - bY36<=10)&&Ball_Y_Pos>=bY36/*&&brickLevel_36*/&&brick36) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX36) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick36<=brick36-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX36) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick36<=brick36-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY37+15)&&(Ball_X_Pos - bX37<=57)&&Ball_X_Pos>=bX37/*&&brickLevel_37*/&&brick37) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY37) 
					begin
						Ball_Y_Motion <= stepY;
						brick37<=brick37-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY37)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick37<=brick37-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX37+62)&&(Ball_Y_Pos - bY37<=10)&&Ball_Y_Pos>=bY37/*&&brickLevel_37*/&&brick37) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX37) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick37<=brick37-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX37) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick37<=brick37-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY38+15)&&(Ball_X_Pos - bX38<=57)&&Ball_X_Pos>=bX38/*&&brickLevel_38*/&&brick38) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY38) 
					begin
						Ball_Y_Motion <= stepY;
						brick38<=brick38-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY38)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick38<=brick38-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX38+62)&&(Ball_Y_Pos - bY38<=10)&&Ball_Y_Pos>=bY38/*&&brickLevel_38*/&&brick38) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX38) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick38<=brick38-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX38) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick38<=brick38-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY39+15)&&(Ball_X_Pos - bX39<=57)&&Ball_X_Pos>=bX39/*&&brickLevel_39*/&&brick39) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY39) 
					begin
						Ball_Y_Motion <= stepY;
						brick39<=brick39-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_Y_Pos+Ball_Size>=bY39)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick39<=brick39-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX39+62)&&(Ball_Y_Pos - bY39<=10)&&Ball_Y_Pos>=bY39/*&&brickLevel_39*/&&brick39) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX39) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick39<=brick39-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX39) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick39<=brick39-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY41+15)&&(Ball_X_Pos - bX41<=57)&&Ball_X_Pos>=bX41/*&&brickLevel_41*/&&brick41) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY41) 
					begin
						Ball_Y_Motion <= stepY;
						brick41<=brick41-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY41)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick41<=brick41-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX41+62)&&(Ball_Y_Pos - bY41<=10)&&Ball_Y_Pos>=bY41/*&&brickLevel_41*/&&brick41) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX41) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick41<=brick41-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX41) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick41<=brick41-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY42+15)&&(Ball_X_Pos - bX42<=57)&&Ball_X_Pos>=bX42/*&&brickLevel_42*/&&brick42) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY42) 
					begin
						Ball_Y_Motion <= stepY;
						brick42<=brick42-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY42)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick42<=brick42-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX42+62)&&(Ball_Y_Pos - bY42<=10)&&Ball_Y_Pos>=bY42/*&&brickLevel_42*/&&brick42) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX42) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick42<=brick42-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX42) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick42<=brick42-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY43+15)&&(Ball_X_Pos - bX43<=57)&&Ball_X_Pos>=bX43/*&&brickLevel_43*/&&brick43) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY43) 
					begin
						Ball_Y_Motion <= stepY;
						brick43<=brick43-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY43)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick43<=brick43-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX43+62)&&(Ball_Y_Pos - bY43<=10)&&Ball_Y_Pos>=bY43/*&&brickLevel_43*/&&brick43) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX43) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick43<=brick43-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX43) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick43<=brick43-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY44+15)&&(Ball_X_Pos - bX44<=57)&&Ball_X_Pos>=bX44/*&&brickLevel_44*/&&brick44) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY44) 
					begin
						Ball_Y_Motion <= stepY;
						brick44<=brick44-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY44)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick44<=brick44-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX44+62)&&(Ball_Y_Pos - bY44<=10)&&Ball_Y_Pos>=bY44/*&&brickLevel_44*/&&brick44) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX44) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick44<=brick44-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX44) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick44<=brick44-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY45+15)&&(Ball_X_Pos - bX45<=57)&&Ball_X_Pos>=bX45/*&&brickLevel_45*/&&brick45) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY45) 
					begin
						Ball_Y_Motion <= stepY;
						brick45<=brick45-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_Y_Pos+Ball_Size>=bY45)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick45<=brick45-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX45+62)&&(Ball_Y_Pos - bY45<=10)&&Ball_Y_Pos>=bY45/*&&brickLevel_45*/&&brick45) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX45) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick45<=brick45-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX45) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick45<=brick45-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY46+15)&&(Ball_X_Pos - bX46<=57)&&Ball_X_Pos>=bX46/*&&brickLevel_46*/&&brick46) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY46) 
					begin
						Ball_Y_Motion <= stepY;
						brick46<=brick46-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY46)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick46<=brick46-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX46+62)&&(Ball_Y_Pos - bY46<=10)&&Ball_Y_Pos>=bY46/*&&brickLevel_46*/&&brick46) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX46) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick46<=brick46-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX46) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick46<=brick46-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY47+15)&&(Ball_X_Pos - bX47<=57)&&Ball_X_Pos>=bX47/*&&brickLevel_47*/&&brick47) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY47) 
					begin
						Ball_Y_Motion <= stepY;
						brick47<=brick47-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY47)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick47<=brick47-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX47+62)&&(Ball_Y_Pos - bY47<=10)&&Ball_Y_Pos>=bY47/*&&brickLevel_47*/&&brick47) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX47) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick47<=brick47-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX47) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick47<=brick47-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY48+15)&&(Ball_X_Pos - bX48<=57)&&Ball_X_Pos>=bX48/*&&brickLevel_48*/&&brick48) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY48) 
					begin
						Ball_Y_Motion <= stepY;
						brick48<=brick48-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY48)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick48<=brick48-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX48+62)&&(Ball_Y_Pos - bY48<=10)&&Ball_Y_Pos>=bY48/*&&brickLevel_48*/&&brick48) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX48) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick48<=brick48-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX48) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick48<=brick48-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY49+15)&&(Ball_X_Pos - bX49<=57)&&Ball_X_Pos>=bX49/*&&brickLevel_49*/&&brick49) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY49) 
					begin
						Ball_Y_Motion <= stepY;
						brick49<=brick49-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY49)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick49<=brick49-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX49+62)&&(Ball_Y_Pos - bY49<=10)&&Ball_Y_Pos>=bY49/*&&brickLevel_49*/&&brick49) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX49) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick49<=brick49-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX49) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick49<=brick49-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY51+15)&&(Ball_X_Pos - bX51<=57)&&Ball_X_Pos>=bX51/*&&brickLevel_51*/&&brick51) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY51) 
					begin
						Ball_Y_Motion <= stepY;
						brick51<=brick51-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY51)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick51<=brick51-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX51+62)&&(Ball_Y_Pos - bY51<=10)&&Ball_Y_Pos>=bY51/*&&brickLevel_51*/&&brick51) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX51) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick51<=brick51-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX51) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick51<=brick51-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY52+15)&&(Ball_X_Pos - bX52<=57)&&Ball_X_Pos>=bX52/*&&brickLevel_52*/&&brick52) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY52) 
					begin
						Ball_Y_Motion <= stepY;
						brick52<=brick52-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY52)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick52<=brick52-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX52+62)&&(Ball_Y_Pos - bY52<=10)&&Ball_Y_Pos>=bY52/*&&brickLevel_52*/&&brick52) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX52) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick52<=brick52-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX52) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick52<=brick52-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY53+15)&&(Ball_X_Pos - bX53<=57)&&Ball_X_Pos>=bX53/*&&brickLevel_53*/&&brick53) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY53) 
					begin
						Ball_Y_Motion <= stepY;
						brick53<=brick53-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY53)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick53<=brick53-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX53+62)&&(Ball_Y_Pos - bY53<=10)&&Ball_Y_Pos>=bY53/*&&brickLevel_53*/&&brick53) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX53) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick53<=brick53-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX53) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick53<=brick53-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY54+15)&&(Ball_X_Pos - bX54<=57)&&Ball_X_Pos>=bX54/*&&brickLevel_54*/&&brick54) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY54) 
					begin
						Ball_Y_Motion <= stepY;
						brick54<=brick54-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY54)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick54<=brick54-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX54+62)&&(Ball_Y_Pos - bY54<=10)&&Ball_Y_Pos>=bY54/*&&brickLevel_54*/&&brick54) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX54) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick54<=brick54-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX54) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick54<=brick54-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY55+15)&&(Ball_X_Pos - bX55<=57)&&Ball_X_Pos>=bX55/*&&brickLevel_55*/&&brick55) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY55) 
					begin
						Ball_Y_Motion <= stepY;
						brick55<=brick55-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY55)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick55<=brick55-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX55+62)&&(Ball_Y_Pos - bY55<=10)&&Ball_Y_Pos>=bY55/*&&brickLevel_55*/&&brick55) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX55) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick55<=brick55-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX55) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick55<=brick55-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY56+15)&&(Ball_X_Pos - bX56<=57)&&Ball_X_Pos>=bX56/*&&brickLevel_56*/&&brick56) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY56) 
					begin
						Ball_Y_Motion <= stepY;
						brick56<=brick56-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY56)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick56<=brick56-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX56+62)&&(Ball_Y_Pos - bY56<=10)&&Ball_Y_Pos>=bY56/*&&brickLevel_56*/&&brick56) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX56) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick56<=brick56-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX56) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick56<=brick56-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY57+15)&&(Ball_X_Pos - bX57<=57)&&Ball_X_Pos>=bX57/*&&brickLevel_57*/&&brick57) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY57) 
					begin
						Ball_Y_Motion <= stepY;
						brick57<=brick57-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY57)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick57<=brick57-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX57+62)&&(Ball_Y_Pos - bY57<=10)&&Ball_Y_Pos>=bY57/*&&brickLevel_57*/&&brick57) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX57) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick57<=brick57-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX57) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick57<=brick57-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY58+15)&&(Ball_X_Pos - bX58<=57)&&Ball_X_Pos>=bX58/*&&brickLevel_58*/&&brick58) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY58) 
					begin
						Ball_Y_Motion <= stepY;
						brick58<=brick58-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY58)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick58<=brick58-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX58+62)&&(Ball_Y_Pos - bY58<=10)&&Ball_Y_Pos>=bY58/*&&brickLevel_58*/&&brick58) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX58) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick58<=brick58-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX58) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick58<=brick58-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY59+15)&&(Ball_X_Pos - bX59<=57)&&Ball_X_Pos>=bX59/*&&brickLevel_59*/&&brick59) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY59) 
					begin
						Ball_Y_Motion <= stepY;
						brick59<=brick59-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY59)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick59<=brick59-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX59+62)&&(Ball_Y_Pos - bY59<=10)&&Ball_Y_Pos>=bY59/*&&brickLevel_59*/&&brick59) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX59) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick59<=brick59-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX59) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick59<=brick59-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY61+15)&&(Ball_X_Pos - bX61<=57)&&Ball_X_Pos>=bX61/*&&brickLevel_61*/&&brick61) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY61) 
					begin
						Ball_Y_Motion <= stepY;
						brick61<=brick61-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY61)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick61<=brick61-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX61+62)&&(Ball_Y_Pos - bY61<=10)&&Ball_Y_Pos>=bY61/*&&brickLevel_61*/&&brick61) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX61) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick61<=brick61-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX61) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick61<=brick61-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY62+15)&&(Ball_X_Pos - bX62<=57)&&Ball_X_Pos>=bX62/*&&brickLevel_62*/&&brick62) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY62) 
					begin
						Ball_Y_Motion <= stepY;
						brick62<=brick62-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY62)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick62<=brick62-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX62+62)&&(Ball_Y_Pos - bY62<=10)&&Ball_Y_Pos>=bY62/*&&brickLevel_62*/&&brick62) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX62) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick62<=brick62-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX62) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick62<=brick62-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY63+15)&&(Ball_X_Pos - bX63<=57)&&Ball_X_Pos>=bX63/*&&brickLevel_63*/&&brick63) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY63) 
					begin
						Ball_Y_Motion <= stepY;
						brick63<=brick63-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY63)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick63<=brick63-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX63+62)&&(Ball_Y_Pos - bY63<=10)&&Ball_Y_Pos>=bY63/*&&brickLevel_63*/&&brick63) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX63) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick63<=brick63-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX63) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick63<=brick63-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY64+15)&&(Ball_X_Pos - bX64<=57)&&Ball_X_Pos>=bX64/*&&brickLevel_64*/&&brick64) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY64) 
					begin
						Ball_Y_Motion <= stepY;
						brick64<=brick64-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY64)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick64<=brick64-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX64+62)&&(Ball_Y_Pos - bY64<=10)&&Ball_Y_Pos>=bY64/*&&brickLevel_64*/&&brick64) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX64) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick64<=brick64-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX64) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick64<=brick64-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY65+15)&&(Ball_X_Pos - bX65<=57)&&Ball_X_Pos>=bX65/*&&brickLevel_65*/&&brick65) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY65) 
					begin
						Ball_Y_Motion <= stepY;
						brick65<=brick65-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY65)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick65<=brick65-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX65+62)&&(Ball_Y_Pos - bY65<=10)&&Ball_Y_Pos>=bY65/*&&brickLevel_65*/&&brick65) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX65) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick65<=brick65-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX65) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick65<=brick65-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY66+15)&&(Ball_X_Pos - bX66<=57)&&Ball_X_Pos>=bX66/*&&brickLevel_66*/&&brick66) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY66) 
					begin
						Ball_Y_Motion <= stepY;
						brick66<=brick66-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY66)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick66<=brick66-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX66+62)&&(Ball_Y_Pos - bY66<=10)&&Ball_Y_Pos>=bY66/*&&brickLevel_66*/&&brick66) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX66) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick66<=brick66-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX66) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick66<=brick66-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY67+15)&&(Ball_X_Pos - bX67<=57)&&Ball_X_Pos>=bX67/*&&brickLevel_67*/&&brick67) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY67) 
					begin
						Ball_Y_Motion <= stepY;
						brick67<=brick67-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY67)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick67<=brick67-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX67+62)&&(Ball_Y_Pos - bY67<=10)&&Ball_Y_Pos>=bY67/*&&brickLevel_67*/&&brick67) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX67) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick67<=brick67-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX67) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick67<=brick67-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY68+15)&&(Ball_X_Pos - bX68<=57)&&Ball_X_Pos>=bX68/*&&brickLevel_68*/&&brick68) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY68) 
					begin
						Ball_Y_Motion <= stepY;
						brick68<=brick68-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY68)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick68<=brick68-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX68+62)&&(Ball_Y_Pos - bY68<=10)&&Ball_Y_Pos>=bY68/*&&brickLevel_68*/&&brick68) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX68) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick68<=brick68-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX68) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick68<=brick68-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY69+15)&&(Ball_X_Pos - bX69<=57)&&Ball_X_Pos>=bX69/*&&brickLevel_69*/&&brick69) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY69) 
					begin
						Ball_Y_Motion <= stepY;
						brick69<=brick69-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY69)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick69<=brick69-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX69+62)&&(Ball_Y_Pos - bY69<=10)&&Ball_Y_Pos>=bY69/*&&brickLevel_69*/&&brick69) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX69) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick69<=brick69-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX69) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick69<=brick69-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY71+15)&&(Ball_X_Pos - bX71<=57)&&Ball_X_Pos>=bX71/*&&brickLevel_71*/&&brick71) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY71) 
					begin
						Ball_Y_Motion <= stepY;
						brick71<=brick71-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY71)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick71<=brick71-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX71+62)&&(Ball_Y_Pos - bY71<=10)&&Ball_Y_Pos>=bY71/*&&brickLevel_71*/&&brick71) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX71) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick71<=brick71-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX71) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick71<=brick71-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY72+15)&&(Ball_X_Pos - bX72<=57)&&Ball_X_Pos>=bX72/*&&brickLevel_72*/&&brick72) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY72) 
					begin
						Ball_Y_Motion <= stepY;
						brick72<=brick72-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY72)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick72<=brick72-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX72+62)&&(Ball_Y_Pos - bY72<=10)&&Ball_Y_Pos>=bY72/*&&brickLevel_72*/&&brick72) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX72) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick72<=brick72-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX72) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick72<=brick72-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY73+15)&&(Ball_X_Pos - bX73<=57)&&Ball_X_Pos>=bX73/*&&brickLevel_73*/&&brick73) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY73) 
					begin
						Ball_Y_Motion <= stepY;
						brick73<=brick73-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY73)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick73<=brick73-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX73+62)&&(Ball_Y_Pos - bY73<=10)&&Ball_Y_Pos>=bY73/*&&brickLevel_73*/&&brick73) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX73) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick73<=brick73-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX73) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick73<=brick73-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY74+15)&&(Ball_X_Pos - bX74<=57)&&Ball_X_Pos>=bX74/*&&brickLevel_74*/&&brick74) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY74) 
					begin
						Ball_Y_Motion <= stepY;
						brick74<=brick74-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY74)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick74<=brick74-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX74+62)&&(Ball_Y_Pos - bY74<=10)&&Ball_Y_Pos>=bY74/*&&brickLevel_74*/&&brick74) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX74) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick74<=brick74-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX74) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick74<=brick74-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY75+15)&&(Ball_X_Pos - bX75<=57)&&Ball_X_Pos>=bX75/*&&brickLevel_75*/&&brick75) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY75) 
					begin
						Ball_Y_Motion <= stepY;
						brick75<=brick75-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY75)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick75<=brick75-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX75+62)&&(Ball_Y_Pos - bY75<=10)&&Ball_Y_Pos>=bY75/*&&brickLevel_75*/&&brick75) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX75) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick75<=brick75-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX75) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick75<=brick75-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY76+15)&&(Ball_X_Pos - bX76<=57)&&Ball_X_Pos>=bX76/*&&brickLevel_76*/&&brick76) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY76) 
					begin
						Ball_Y_Motion <= stepY;
						brick76<=brick76-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY76)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick76<=brick76-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX76+62)&&(Ball_Y_Pos - bY76<=10)&&Ball_Y_Pos>=bY76/*&&brickLevel_76*/&&brick76) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX76) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick76<=brick76-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX76) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick76<=brick76-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY77+15)&&(Ball_X_Pos - bX77<=57)&&Ball_X_Pos>=bX77/*&&brickLevel_77*/&&brick77) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY77) 
					begin
						Ball_Y_Motion <= stepY;
						brick77<=brick77-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY77)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick77<=brick77-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX77+62)&&(Ball_Y_Pos - bY77<=10)&&Ball_Y_Pos>=bY77/*&&brickLevel_77*/&&brick77) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX77) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick77<=brick77-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX77) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick77<=brick77-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY78+15)&&(Ball_X_Pos - bX78<=57)&&Ball_X_Pos>=bX78/*&&brickLevel_78*/&&brick78) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY78) 
					begin
						Ball_Y_Motion <= stepY;
						brick78<=brick78-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY78)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick78<=brick78-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX78+62)&&(Ball_Y_Pos - bY78<=10)&&Ball_Y_Pos>=bY78/*&&brickLevel_78*/&&brick78) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX78) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick78<=brick78-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX78) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick78<=brick78-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY79+15)&&(Ball_X_Pos - bX79<=57)&&Ball_X_Pos>=bX79/*&&brickLevel_79*/&&brick79) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY79) 
					begin
						Ball_Y_Motion <= stepY;
						brick79<=brick79-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY79)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick79<=brick79-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX79+62)&&(Ball_Y_Pos - bY79<=10)&&Ball_Y_Pos>=bY79/*&&brickLevel_79*/&&brick79) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX79) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick79<=brick79-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX79) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick79<=brick79-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY81+15)&&(Ball_X_Pos - bX81<=57)&&Ball_X_Pos>=bX81/*&&brickLevel_81*/&&brick81) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY81) 
					begin
						Ball_Y_Motion <= stepY;
						brick81<=brick81-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY81)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick81<=brick81-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX81+62)&&(Ball_Y_Pos - bY81<=10)&&Ball_Y_Pos>=bY81/*&&brickLevel_81*/&&brick81) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX81) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick81<=brick81-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX81) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick81<=brick81-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY82+15)&&(Ball_X_Pos - bX82<=57)&&Ball_X_Pos>=bX82/*&&brickLevel_82*/&&brick82) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY82) 
					begin
						Ball_Y_Motion <= stepY;
						brick82<=brick82-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY82)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick82<=brick82-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX82+62)&&(Ball_Y_Pos - bY82<=10)&&Ball_Y_Pos>=bY82/*&&brickLevel_82*/&&brick82) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX82) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick82<=brick82-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX82) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick82<=brick82-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY83+15)&&(Ball_X_Pos - bX83<=57)&&Ball_X_Pos>=bX83/*&&brickLevel_83*/&&brick83) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY83) 
					begin
						Ball_Y_Motion <= stepY;
						brick83<=brick83-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY83)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick83<=brick83-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX83+62)&&(Ball_Y_Pos - bY83<=10)&&Ball_Y_Pos>=bY83/*&&brickLevel_83*/&&brick83) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX83) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick83<=brick83-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX83) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick83<=brick83-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY84+15)&&(Ball_X_Pos - bX84<=57)&&Ball_X_Pos>=bX84/*&&brickLevel_84*/&&brick84) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY84) 
					begin
						Ball_Y_Motion <= stepY;
						brick84<=brick84-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY84)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick84<=brick84-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX84+62)&&(Ball_Y_Pos - bY84<=10)&&Ball_Y_Pos>=bY84/*&&brickLevel_84*/&&brick84) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX84) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick84<=brick84-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX84) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick84<=brick84-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY85+15)&&(Ball_X_Pos - bX85<=57)&&Ball_X_Pos>=bX85/*&&brickLevel_85*/&&brick85) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY85) 
					begin
						Ball_Y_Motion <= stepY;
						brick85<=brick85-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY85)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick85<=brick85-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX85+62)&&(Ball_Y_Pos - bY85<=10)&&Ball_Y_Pos>=bY85/*&&brickLevel_85*/&&brick85) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX85) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick85<=brick85-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX85) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick85<=brick85-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY86+15)&&(Ball_X_Pos - bX86<=57)&&Ball_X_Pos>=bX86/*&&brickLevel_86*/&&brick86) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY86) 
					begin
						Ball_Y_Motion <= stepY;
						brick86<=brick86-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY86)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick86<=brick86-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX86+62)&&(Ball_Y_Pos - bY86<=10)&&Ball_Y_Pos>=bY86/*&&brickLevel_86*/&&brick86) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX86) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick86<=brick86-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX86) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick86<=brick86-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY87+15)&&(Ball_X_Pos - bX87<=57)&&Ball_X_Pos>=bX87/*&&brickLevel_87*/&&brick87) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY87) 
					begin
						Ball_Y_Motion <= stepY;
						brick87<=brick87-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY87)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick87<=brick87-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX87+62)&&(Ball_Y_Pos - bY87<=10)&&Ball_Y_Pos>=bY87/*&&brickLevel_87*/&&brick87) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX87) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick87<=brick87-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX87) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick87<=brick87-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY88+15)&&(Ball_X_Pos - bX88<=57)&&Ball_X_Pos>=bX88/*&&brickLevel_88*/&&brick88) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY88) 
					begin
						Ball_Y_Motion <= stepY;
						brick88<=brick88-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY88)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick88<=brick88-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX88+62)&&(Ball_Y_Pos - bY88<=10)&&Ball_Y_Pos>=bY88/*&&brickLevel_88*/&&brick88) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX88) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick88<=brick88-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX88) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick88<=brick88-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY89+15)&&(Ball_X_Pos - bX89<=57)&&Ball_X_Pos>=bX89/*&&brickLevel_89*/&&brick89) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY89) 
					begin
						Ball_Y_Motion <= stepY;
						brick89<=brick89-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY89)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick89<=brick89-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX89+62)&&(Ball_Y_Pos - bY89<=10)&&Ball_Y_Pos>=bY89/*&&brickLevel_89*/&&brick89) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX89) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick89<=brick89-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX89) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick89<=brick89-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY91+15)&&(Ball_X_Pos - bX91<=57)&&Ball_X_Pos>=bX91/*&&brickLevel_91*/&&brick91) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY91) 
					begin
						Ball_Y_Motion <= stepY;
						brick91<=brick91-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY91)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick91<=brick91-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX91+62)&&(Ball_Y_Pos - bY91<=10)&&Ball_Y_Pos>=bY91/*&&brickLevel_91*/&&brick91) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX91) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick91<=brick91-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX91) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick91<=brick91-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY92+15)&&(Ball_X_Pos - bX92<=57)&&Ball_X_Pos>=bX92/*&&brickLevel_92*/&&brick92) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY92) 
					begin
						Ball_Y_Motion <= stepY;
						brick92<=brick92-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY92)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick92<=brick92-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX92+62)&&(Ball_Y_Pos - bY92<=10)&&Ball_Y_Pos>=bY92/*&&brickLevel_92*/&&brick92) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX92) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick92<=brick92-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX92) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick92<=brick92-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY93+15)&&(Ball_X_Pos - bX93<=57)&&Ball_X_Pos>=bX93/*&&brickLevel_93*/&&brick93) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY93) 
					begin
						Ball_Y_Motion <= stepY;
						brick93<=brick93-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY93)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick93<=brick93-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX93+62)&&(Ball_Y_Pos - bY93<=10)&&Ball_Y_Pos>=bY93/*&&brickLevel_93*/&&brick93) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX93) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick93<=brick93-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX93) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick93<=brick93-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY94+15)&&(Ball_X_Pos - bX94<=57)&&Ball_X_Pos>=bX94/*&&brickLevel_94*/&&brick94) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY94) 
					begin
						Ball_Y_Motion <= stepY;
						brick94<=brick94-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY94)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick94<=brick94-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX94+62)&&(Ball_Y_Pos - bY94<=10)&&Ball_Y_Pos>=bY94/*&&brickLevel_94*/&&brick94) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX94) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick94<=brick94-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX94) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick94<=brick94-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY95+15)&&(Ball_X_Pos - bX95<=57)&&Ball_X_Pos>=bX95/*&&brickLevel_95*/&&brick95) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY95) 
					begin
						Ball_Y_Motion <= stepY;
						brick95<=brick95-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY95)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick95<=brick95-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX95+62)&&(Ball_Y_Pos - bY95<=10)&&Ball_Y_Pos>=bY95/*&&brickLevel_95*/&&brick95) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX95) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick95<=brick95-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX95) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick95<=brick95-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY96+15)&&(Ball_X_Pos - bX96<=57)&&Ball_X_Pos>=bX96/*&&brickLevel_96*/&&brick96) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY96) 
					begin
						Ball_Y_Motion <= stepY;
						brick96<=brick96-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY96)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick96<=brick96-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX96+62)&&(Ball_Y_Pos - bY96<=10)&&Ball_Y_Pos>=bY96/*&&brickLevel_96*/&&brick96) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX96) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick96<=brick96-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX96) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick96<=brick96-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY97+15)&&(Ball_X_Pos - bX97<=57)&&Ball_X_Pos>=bX97/*&&brickLevel_97*/&&brick97) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY97) 
					begin
						Ball_Y_Motion <= stepY;
						brick97<=brick97-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY97)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick97<=brick97-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX97+62)&&(Ball_Y_Pos - bY97<=10)&&Ball_Y_Pos>=bY97/*&&brickLevel_97*/&&brick97) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX97) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick97<=brick97-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX97) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick97<=brick97-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY98+15)&&(Ball_X_Pos - bX98<=57)&&Ball_X_Pos>=bX98/*&&brickLevel_98*/&&brick98) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY98) 
					begin
						Ball_Y_Motion <= stepY;
						brick98<=brick98-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY98)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick98<=brick98-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX98+62)&&(Ball_Y_Pos - bY98<=10)&&Ball_Y_Pos>=bY98/*&&brickLevel_98*/&&brick98) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX98) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick98<=brick98-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX98) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick98<=brick98-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY99+15)&&(Ball_X_Pos - bX99<=57)&&Ball_X_Pos>=bX99/*&&brickLevel_99*/&&brick99) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY99) 
					begin
						Ball_Y_Motion <= stepY;
						brick99<=brick99-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY99)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick99<=brick99-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX99+62)&&(Ball_Y_Pos - bY99<=10)&&Ball_Y_Pos>=bY99/*&&brickLevel_99*/&&brick99) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX99) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick99<=brick99-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX99) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick99<=brick99-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY101+15)&&(Ball_X_Pos - bX101<=57)&&Ball_X_Pos>=bX101/*&&brickLevel_101*/&&brick101) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY101) 
					begin
						Ball_Y_Motion <= stepY;
						brick101<=brick101-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY101)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick101<=brick101-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX101+62)&&(Ball_Y_Pos - bY101<=10)&&Ball_Y_Pos>=bY101/*&&brickLevel_101*/&&brick101) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX101) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick101<=brick101-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_X_Pos+Ball_Size+5>=bX101) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick101<=brick101-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY102+15)&&(Ball_X_Pos - bX102<=57)&&Ball_X_Pos>=bX102/*&&brickLevel_102*/&&brick102) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY102) 
					begin
						Ball_Y_Motion <= stepY;
						brick102<=brick102-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_Y_Pos+Ball_Size>=bY102)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick102<=brick102-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX102+62)&&(Ball_Y_Pos - bY102<=10)&&Ball_Y_Pos>=bY102/*&&brickLevel_102*/&&brick102) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX102) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick102<=brick102-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX102) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick102<=brick102-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY103+15)&&(Ball_X_Pos - bX103<=57)&&Ball_X_Pos>=bX103/*&&brickLevel_103*/&&brick103) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY103) 
					begin
						Ball_Y_Motion <= stepY;
						brick103<=brick103-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						end
					else if(Ball_Y_Pos+Ball_Size>=bY103)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick103<=brick103-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX103+62)&&(Ball_Y_Pos - bY103<=10)&&Ball_Y_Pos>=bY103/*&&brickLevel_103*/&&brick103) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX103) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick103<=brick103-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX103) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick103<=brick103-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY104+15)&&(Ball_X_Pos - bX104<=57)&&Ball_X_Pos>=bX104/*&&brickLevel_104*/&&brick104) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY104) 
					begin
						Ball_Y_Motion <= stepY;
						brick104<=brick104-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_Y_Pos+Ball_Size>=bY104)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick104<=brick104-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX104+62)&&(Ball_Y_Pos - bY104<=10)&&Ball_Y_Pos>=bY104/*&&brickLevel_104*/&&brick104) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX104) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick104<=brick104-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX104) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick104<=brick104-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY105+15)&&(Ball_X_Pos - bX105<=57)&&Ball_X_Pos>=bX105/*&&brickLevel_105*/&&brick105) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY105) 
					begin						
						Ball_Y_Motion <= stepY;
						brick105<=brick105-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_Y_Pos+Ball_Size>=bY105)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick105<=brick105-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX105+62)&&(Ball_Y_Pos - bY105<=10)&&Ball_Y_Pos>=bY105/*&&brickLevel_105*/&&brick105) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX105) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick105<=brick105-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX105) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick105<=brick105-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY106+15)&&(Ball_X_Pos - bX106<=57)&&Ball_X_Pos>=bX106/*&&brickLevel_106*/&&brick106) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY106) 
					begin
						Ball_Y_Motion <= stepY;
						brick106<=brick106-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						
					end
					else if(Ball_Y_Pos+Ball_Size>=bY106)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick106<=brick106-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX106+62)&&(Ball_Y_Pos - bY106<=10)&&Ball_Y_Pos>=bY106/*&&brickLevel_106*/&&brick106) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX106) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick106<=brick106-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX106) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick106<=brick106-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY107+15)&&(Ball_X_Pos - bX107<=57)&&Ball_X_Pos>=bX107/*&&brickLevel_107*/&&brick107) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY107) 
					begin
						Ball_Y_Motion <= stepY;
						brick107<=brick107-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_Y_Pos+Ball_Size>=bY107)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick107<=brick107-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX107+62)&&(Ball_Y_Pos - bY107<=10)&&Ball_Y_Pos>=bY107/*&&brickLevel_107*/&&brick107) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX107) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick107<=brick107-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX107) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick107<=brick107-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY108+15)&&(Ball_X_Pos - bX108<=57)&&Ball_X_Pos>=bX108/*&&brickLevel_108*/&&brick108) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY108) 
					begin
						Ball_Y_Motion <= stepY;
						brick108<=brick108-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_Y_Pos+Ball_Size>=bY108)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick108<=brick108-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX108+62)&&(Ball_Y_Pos - bY108<=10)&&Ball_Y_Pos>=bY108/*&&brickLevel_108*/&&brick108) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX108) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick108<=brick108-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX108) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick108<=brick108-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY109+15)&&(Ball_X_Pos - bX109<=57)&&Ball_X_Pos>=bX109/*&&brickLevel_109*/&&brick109) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY109) 
					begin
						Ball_Y_Motion <= stepY;
						brick109<=brick109-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_Y_Pos+Ball_Size>=bY109)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick109<=brick109-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX109+62)&&(Ball_Y_Pos - bY109<=10)&&Ball_Y_Pos>=bY109/*&&brickLevel_109*/&&brick109) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX109) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick109<=brick109-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX109) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick109<=brick109-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
								else if(((Ball_Y_Pos - Ball_Size)<=bY30+15)&&(Ball_X_Pos - bX30<=57)&&Ball_X_Pos>=bX30/*&&brickLevel_30*/&&brick30) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY30) 
					begin
						Ball_Y_Motion <= stepY;
						brick30<=brick30-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_Y_Pos+Ball_Size>=bY30)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick30<=brick30-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX30+62)&&(Ball_Y_Pos - bY30<=10)&&Ball_Y_Pos>=bY30/*&&brickLevel_30*/&&brick30) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX30) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick30<=brick30-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX30) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick30<=brick30-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY10+15)&&(Ball_X_Pos - bX10<=57)&&Ball_X_Pos>=bX10/*&&brickLevel_10*/&&brick10) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY10) 
					begin
						Ball_Y_Motion <= stepY;
						brick10<=brick10-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_Y_Pos+Ball_Size>=bY10)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick10<=brick10-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX10+62)&&(Ball_Y_Pos - bY10<=10)&&Ball_Y_Pos>=bY10/*&&brickLevel_10*/&&brick10) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX10) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick10<=brick10-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX10) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick10<=brick10-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY20+15)&&(Ball_X_Pos - bX20<=57)&&Ball_X_Pos>=bX20/*&&brickLevel_20*/&&brick20) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY20) 
					begin
						Ball_Y_Motion <= stepY;
						brick20<=brick20-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_Y_Pos+Ball_Size>=bY20)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick20<=brick20-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX20+62)&&(Ball_Y_Pos - bY20<=10)&&Ball_Y_Pos>=bY20/*&&brickLevel_20*/&&brick20) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX20) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick20<=brick20-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX20) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick20<=brick20-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY40+15)&&(Ball_X_Pos - bX40<=57)&&Ball_X_Pos>=bX40/*&&brickLevel_40*/&&brick40) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY40) 
					begin
						Ball_Y_Motion <= stepY;
						brick40<=brick40-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_Y_Pos+Ball_Size>=bY40)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick40<=brick40-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX40+62)&&(Ball_Y_Pos - bY40<=10)&&Ball_Y_Pos>=bY40/*&&brickLevel_40*/&&brick40) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX40) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick40<=brick40-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX40) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick40<=brick40-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end				
				else if(((Ball_Y_Pos - Ball_Size)<=bY50+15)&&(Ball_X_Pos - bX50<=57)&&Ball_X_Pos>=bX50/*&&brickLevel_50*/&&brick50) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY50) 
					begin
						Ball_Y_Motion <= stepY;
						brick50<=brick50-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_Y_Pos+Ball_Size>=bY50)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick50<=brick50-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX50+62)&&(Ball_Y_Pos - bY50<=10)&&Ball_Y_Pos>=bY50/*&&brickLevel_50*/&&brick50) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX50) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick50<=brick50-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX50) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick50<=brick50-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY60+15)&&(Ball_X_Pos - bX60<=57)&&Ball_X_Pos>=bX60/*&&brickLevel_60*/&&brick60) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY60) 
					begin
						Ball_Y_Motion <= stepY;
						brick60<=brick60-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_Y_Pos+Ball_Size>=bY60)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick60<=brick60-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX60+62)&&(Ball_Y_Pos - bY60<=10)&&Ball_Y_Pos>=bY60/*&&brickLevel_60*/&&brick60) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX60) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick60<=brick60-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX60) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick60<=brick60-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY70+15)&&(Ball_X_Pos - bX70<=57)&&Ball_X_Pos>=bX70/*&&brickLevel_70*/&&brick70) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY70) 
					begin
						Ball_Y_Motion <= stepY;
						brick70<=brick70-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						
					end
					else if(Ball_Y_Pos+Ball_Size>=bY70)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick70<=brick70-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX70+62)&&(Ball_Y_Pos - bY70<=10)&&Ball_Y_Pos>=bY70/*&&brickLevel_70*/&&brick70) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX70) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick70<=brick70-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX70) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick70<=brick70-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY80+15)&&(Ball_X_Pos - bX80<=57)&&Ball_X_Pos>=bX80/*&&brickLevel_80*/&&brick80) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY80) 
					begin
						Ball_Y_Motion <= stepY;
						brick80<=brick80-3'b001;
						noMore<= 1'b0;score<=score+3'b001;
						
					end
					else if(Ball_Y_Pos+Ball_Size>=bY80)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick80<=brick80-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX80+62)&&(Ball_Y_Pos - bY80<=10)&&Ball_Y_Pos>=bY80/*&&brickLevel_80*/&&brick80) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX80) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick80<=brick80-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX80) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick80<=brick80-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY90+15)&&(Ball_X_Pos - bX90<=57)&&Ball_X_Pos>=bX90/*&&brickLevel_90*/&&brick90) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY90) 
					begin
						Ball_Y_Motion <= stepY;
						brick90<=brick90-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						
					end
					else if(Ball_Y_Pos+Ball_Size>=bY90)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick90<=brick90-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX90+62)&&(Ball_Y_Pos - bY90<=10)&&Ball_Y_Pos>=bY90/*&&brickLevel_90*/&&brick90) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX90) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick90<=brick90-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX90) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick90<=brick90-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY100+15)&&(Ball_X_Pos - bX100<=57)&&Ball_X_Pos>=bX100/*&&brickLevel_100*/&&brick100) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY100) 
					begin
						Ball_Y_Motion <= stepY;
						brick100<=brick100-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						
					end
					else if(Ball_Y_Pos+Ball_Size>=bY100)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick100<=brick100-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX100+62)&&(Ball_Y_Pos - bY100<=10)&&Ball_Y_Pos>=bY100/*&&brickLevel_100*/&&brick100) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX100) // Checking to see if the leftside of ball hits the right side
					begin
						Ball_X_Motion <= stepX;
						brick100<=brick100-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						
					end
					else if(Ball_X_Pos+Ball_Size+5>=bX100) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick100<=brick100-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_Y_Pos - Ball_Size)<=bY110+15)&&(Ball_X_Pos - bX110<=57)&&Ball_X_Pos>=bX110/*&&brickLevel_110*/&&brick110) // see if the ball is below or above a brick
				begin
					if (Ball_Y_Pos-Ball_Size>=bY110) 
					begin
						Ball_Y_Motion <= stepY;
						brick110<=brick110-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
						
					end
					else if(Ball_Y_Pos+Ball_Size>=bY110)
					begin
						Ball_Y_Motion <= (~ (stepY) + 1'b1);
						brick110<=brick110-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				else if(((Ball_X_Pos - Ball_Size)<=bX110+62)&&(Ball_Y_Pos - bY110<=10)&&Ball_Y_Pos>=bY110/*&&brickLevel_110*/&&brick110) //see if the ball is to the left or right of a brick
				begin
					if (Ball_X_Pos-Ball_Size>=bX110) // Checking to see if the leftside of ball hits the right side
					begin						
						Ball_X_Motion <= stepX;
						brick110<=brick110-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;

					end
					else if(Ball_X_Pos+Ball_Size+5>=bX110) //Checking to see if the rightside ball hits the left side
					begin
						Ball_X_Motion <= (~ (stepX) + 1'b1);
						brick110<=brick110-3'b001;
						noMore<= 1'b0;
						score<=score+3'b001;
					end
				end
				if(lifeUp&&lives<4'b1001)
					lives<=lives+1'b1;
		
			Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
			Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
			end  

			
			end
	 
    assign BallX = Ball_X_Pos;
   
    assign BallY = Ball_Y_Pos;
   
    assign BallS = Ball_Size;
    

endmodule
