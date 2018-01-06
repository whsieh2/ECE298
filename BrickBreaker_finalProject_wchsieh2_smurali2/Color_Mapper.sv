//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2013 Distribution                                             --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input  [9:0]	BallX, BallY, DrawX, DrawY, Ball_size, PaddleX1, PaddleY1, paddleSize,
								//output logic [3:0]level,
								input logic Reset, Clk, gameOver, levelChange,PowOn,power_show,
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
								bX61, bY61, bX62, bY62, bX63, bY63, 
								bX64, bY64, bX65, bY65, bX66, bY66, bX67, bY67, bX68, bY68, bX69, bY69, bX70, bY70,
								bX71, bY71, bX72, bY72, bX73, bY73, bX74, bY74, bX75, bY75, bX76, bY76, bX77, bY77, bX78, bY78, bX79, bY79, bX80, bY80, 
								bX81, bY81, bX82, bY82, bX83, bY83, bX84, bY84, bX85, bY85, bX86, bY86, bX87, bY87, bX88, bY88, bX89, bY89, bX90, bY90, 
								bX91, bY91, bX92, bY92, bX93, bY93, bX94, bY94, bX95, bY95, bX96, bY96, bX97, bY97, bX98, bY98, bX99, bY99, bX100, bY100, 
								bX101, bY101, bX102, bY102, bX103, bY103, bX104, bY104, bX105, bY105, bX106, bY106, bX107, bY107, bX108, bY108, bX109, bY109, bX110, bY110,
								input logic [9:0] PowX,PowY,
                        input logic [10:0] score,
								input logic [3:0] level,
								input logic [3:0] lives,
							   output logic [9:0] Red, Green, Blue );
    
    logic ball_on, paddle_on,line_on, brick_on_1, brick_on_2, brick_on_3,power_on;
	 logic [7:0] font_reg0, font_reg1, font_reg2, font_reg3, font_reg4, font_reg5, font_reg6, font_reg7, font_reg8, font_reg9, font_reg10;
	 logic [7:0] font_reg11, font_reg12, font_reg13, font_reg14, font_reg15, font_reg16, font_reg17, font_reg18, font_reg19, font_reg20, font_reg21, font_reg22, font_reg23;
	 logic l0_on, e0_on, v0_on, e1_on, l1_on, s0_on, c0_on, o0_on, r0_on, e2_on, l2_on, i0_on, v1_on, e3_on, s1_on,
	 score4_on, col0_on, col1_on, col2_on, lives_on, score1_on, score2_on, score3_on, levels_on;
    
	 int DistX, DistY, SizeBall;
	 assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY; 
    assign SizeBall = Ball_size;
	 
	 int val1 = 0; //score //level 2 score gets stuck at 00:
	 int scval1;
	 assign scval1 = int'(score);
	 int val2 = 0;
	 int val3 = 0;
	 int val4 = 0;
	 
	 always_ff
		begin
		if (Reset)
		begin
		val1=0;
		val2=0;
		val3=0;
		val4=0;
		end
		else if(scval1<10)
			begin
			val1 = scval1;
			end
		else if(scval1>=10 && scval1<20)
			begin
			val2 = 1;
			val1 = scval1-10;
			end
		else if(scval1>=20 && scval1<30)
			begin
			val2 = 2;
			val1 = scval1-20;
			end
		else if(scval1>=30 && scval1<40)
			begin
			val2 = 3;
			val1 = scval1-30;
			end
		else if(scval1>=40 && scval1<50)
			begin
			val2 = 4;
			val1 = scval1-40;
			end
		else if(scval1>=50 && scval1<60)
			begin
			val2 = 5;
			val1 = scval1-50;
			end
		else if(scval1>=60 && scval1<70)
			begin
			val2 = 6;
			val1 = scval1-60;
			end
		else if(scval1>=70 && scval1<80)
			begin
			val2 = 7;
			val1 = scval1-70;
			end
		else if(scval1>=80 && scval1<90)
			begin
			val2 = 8;
			val1 = scval1-80;
			end
		else if(scval1>=90 && scval1<100)
			begin
			val2 = 8;
			val1 = scval1-90;
			end
		else if(scval1>=100 && scval1<110)//please make the 3rd digit
			begin
			val3 = 1;
			val2 = 0;
			val1 = scval1-100;
			end
		else if(scval1>=110 && scval1<120)
			begin
			val3 = 1;
			val2 = 1;
			val1 = scval1-110;
			end
		else if(scval1>=120 && scval1<130)
			begin
			val3 = 1;
			val2 = 2;
			val1 = scval1-120;
			end
		else if(scval1>=130 && scval1<140)
			begin
			val3 = 1;
			val2 = 3;
			val1 = scval1-130;
			end
		else if(scval1>=140 && scval1<150)
			begin
			val3 = 1;
			val2 = 4;
			val1 = scval1-140;
			end
		else if(scval1>=150 && scval1<160)
			begin
			val3 = 1;
			val2 = 5;
			val1 = scval1-150;
			end
		else if(scval1>=160 && scval1<170)
			begin
			val3 = 1;
			val2 = 6;
			val1 = scval1-160;
			end
		else if(scval1>=170 && scval1<180)
			begin
			val3 = 1;
			val2 = 7;
			val1 = scval1-170;
			end
		else if(scval1>=180 && scval1<190)
			begin
			val3 = 1;
			val2 = 8;
			val1 = scval1-180;
			end
		else if(scval1>=190 && scval1<200)
			begin
			val3 = 1;
			val2 = 9;
			val1 = scval1-190;
			end
		else if(scval1>=200 && scval1<210)
			begin
			val3 = 2;
			val2 = 0;
			val1 = scval1-200;
			end
		else if(scval1>=210 && scval1<220)
			begin
			val3 = 2;
			val2 = 1;
			val1 = scval1-210;
			end
		else if(scval1>=220 && scval1<230)
			begin
			val3 = 2;
			val2 = 2;
			val1 = scval1-220;
			end
		else if(scval1>=230 && scval1<240)
			begin
			val3 = 2;
			val2 = 3;
			val1 = scval1-230;
			end
		else if(scval1>=240 && scval1<250)
			begin
			val3 = 2;
			val2 = 4;
			val1 = scval1-240;
			end
		else if(scval1>=250 && scval1<260)
			begin
			val3 = 2;
			val2 = 5;
			val1 = scval1-250;
			end
		else if(scval1>=260 && scval1<270)
			begin
			val3 = 2;
			val2 = 6;
			val1 = scval1-260;
			end
		else if(scval1>=270 && scval1<280)
			begin
			val3 = 2;
			val2 = 7;
			val1 = scval1-270;
			end
		else if(scval1>=280 && scval1<290)
			begin
			val3 = 2;
			val2 = 8;
			val1 = scval1-280;
			end
		else if(scval1>=290 && scval1<300)
			begin
			val3 = 2;
			val2 = 9;
			val1 = scval1-290;
			end
		else if(scval1>=300 && scval1<310)
			begin
			val3 = 3;
			val2 = 0;
			val1 = scval1-300;
			end
		else if(scval1>=310 && scval1<320)
			begin
			val3 = 3;
			val2 = 1;
			val1 = scval1-310;
			end
		else if(scval1>=320 && scval1<330)
			begin
			val3 = 3;
			val2 = 2;
			val1 = scval1-320;
			end
		else if(scval1>=330 && scval1<340)
			begin
			val3 = 3;
			val2 = 3;
			val1 = scval1-330;
			end
		else if(scval1>=340 && scval1<350)
			begin
			val3 = 3;
			val2 = 4;
			val1 = scval1-340;
			end
		else if(scval1>=350 && scval1<360)
			begin
			val3 = 3;
			val2 = 5;
			val1 = scval1-350;
			end
		else if(scval1>=360 && scval1<370)
			begin
			val3 = 3;
			val2 = 6;
			val1 = scval1-360;
			end
		else if(scval1>=370 && scval1<380)
			begin
			val3 = 3;
			val2 = 7;
			val1 = scval1-370;
			end
		else if(scval1>=380 && scval1<390)
			begin
			val3 = 3;
			val2 = 8;
			val1 = scval1-380;
			end
		else if(scval1>=390 && scval1<400)
			begin
			val3 = 3;
			val2 = 9;
			val1 = scval1-390;
			end
		else if(scval1>=400 && scval1<410)
			begin
			val3 = 4;
			val2 = 0;
			val1 = scval1-400;
			end
		else if(scval1>=410 && scval1<420)
			begin
			val3 = 4;
			val2 = 1;
			val1 = scval1-410;
			end
		else if(scval1>=420 && scval1<430)
			begin
			val3 = 4;
			val2 = 2;
			val1 = scval1-420;
			end
		else if(scval1>=430 && scval1<440)
			begin
			val3 = 4;
			val2 = 3;
			val1 = scval1-430;
			end
		else if(scval1>=440 && scval1<450)
			begin
			val3 = 4;
			val2 = 4;
			val1 = scval1-440;
			end
		else if(scval1>=450 && scval1<460)
			begin
			val3 = 4;
			val2 = 5;
			val1 = scval1-450;
			end
		else if(scval1>=460 && scval1<470)
			begin
			val3 = 4;
			val2 = 6;
			val1 = scval1-460;
			end
		else if(scval1>=470 && scval1<480)
			begin
			val3 = 4;
			val2 = 7;
			val1 = scval1-470;
			end
		else if(scval1>=480 && scval1<490)
			begin
			val3 = 4;
			val2 = 8;
			val1 = scval1-480;
			end
		else if(scval1>=490 && scval1<500)
			begin
			val3 = 4;
			val2 = 9;
			val1 = scval1-490;
			end
		else if(scval1>=500 && scval1<510)
			begin
			val3 = 5;
			val2 = 0;
			val1 = scval1-500;
			end
		else if(scval1>=510 && scval1<520)
			begin
			val3 = 5;
			val2 = 1;
			val1 = scval1-510;
			end
		else if(scval1>=520 && scval1<530)
			begin
			val3 = 5;
			val2 = 2;
			val1 = scval1-520;
			end
		else if(scval1>=530 && scval1<540)
			begin
			val3 = 5;
			val2 = 3;
			val1 = scval1-530;
			end
		else if(scval1>=540 && scval1<550)
			begin
			val3 = 5;
			val2 = 4;
			val1 = scval1-540;
			end
		else if(scval1>=550 && scval1<560)
			begin
			val3 = 5;
			val2 = 5;
			val1 = scval1-550;
			end
		else if(scval1>=560 && scval1<570)
			begin
			val3 = 5;
			val2 = 6;
			val1 = scval1-560;
			end
		else if(scval1>=570 && scval1<580)
			begin
			val3 = 5;
			val2 = 7;
			val1 = scval1-570;
			end
		else if(scval1>=580 && scval1<590)
			begin
			val3 = 5;
			val2 = 8;
			val1 = scval1-580;
			end
		else if(scval1>=590 && scval1<600)
			begin
			val3 = 5;
			val2 = 9;
			val1 = scval1-590;
			end
		else if(scval1>=600 && scval1<610)
			begin
			val3 = 6;
			val2 = 0;
			val1 = scval1-600;
			end
		else if(scval1>=610 && scval1<620)
			begin
			val3 = 6;
			val2 = 1;
			val1 = scval1-610;
			end
		else if(scval1>=620 && scval1<630)
			begin
			val3 = 6;
			val2 = 2;
			val1 = scval1-620;
			end
		else if(scval1>=630 && scval1<640)
			begin
			val3 = 6;
			val2 = 3;
			val1 = scval1-630;
			end
		else if(scval1>=640 && scval1<650)
			begin
			val3 = 6;
			val2 = 4;
			val1 = scval1-640;
			end
		else if(scval1>=650 && scval1<660)
			begin
			val3 = 6;
			val2 = 5;
			val1 = scval1-650;
			end
		else if(scval1>=660 && scval1<670)
			begin
			val3 = 6;
			val2 = 6;
			val1 = scval1-660;
			end
		else if(scval1>=670 && scval1<680)
			begin
			val3 = 6;
			val2 = 7;
			val1 = scval1-670;
			end
		else if(scval1>=680 && scval1<690)
			begin
			val3 = 6;
			val2 = 8;
			val1 = scval1-680;
			end
		else if(scval1>=690 && scval1<700)
			begin
			val3 = 6;
			val2 = 9;
			val1 = scval1-690;
			end
		else if(scval1>=700 && scval1<710)
			begin
			val3 = 7;
			val2 = 0;
			val1 = scval1-700;
			end
		else if(scval1>=710 && scval1<720)
			begin
			val3 = 7;
			val2 = 1;
			val1 = scval1-710;
			end
		else if(scval1>=720 && scval1<730)
			begin
			val3 = 7;
			val2 = 2;
			val1 = scval1-720;
			end
		else if(scval1>=730 && scval1<740)
			begin
			val3 = 7;
			val2 = 3;
			val1 = scval1-730;
			end
		else if(scval1>=740 && scval1<750)
			begin
			val3 = 7;
			val2 = 4;
			val1 = scval1-740;
			end
		else if(scval1>=750 && scval1<760)
			begin
			val3 = 7;
			val2 = 5;
			val1 = scval1-750;
			end
		else if(scval1>=760 && scval1<770)
			begin
			val3 = 7;
			val2 = 6;
			val1 = scval1-760;
			end
		else if(scval1>=770 && scval1<780)
			begin
			val3 = 7;
			val2 = 7;
			val1 = scval1-770;
			end
		else if(scval1>=780 && scval1<790)
			begin
			val3 = 7;
			val2 = 8;
			val1 = scval1-780;
			end
		else if(scval1>=790 && scval1<800)
			begin
			val3 = 7;
			val2 = 9;
			val1 = scval1-790;
			end
		else if(scval1>=800 && scval1<810)
			begin
			val3 = 8;
			val2 = 0;
			val1 = scval1-800;
			end
		else if(scval1>=810 && scval1<820)
			begin
			val3 = 8;
			val2 = 1;
			val1 = scval1-810;
			end
		else if(scval1>=820 && scval1<830)
			begin
			val3 = 8;
			val2 = 2;
			val1 = scval1-820;
			end
		else if(scval1>=830 && scval1<840)
			begin
			val3 = 8;
			val2 = 3;
			val1 = scval1-830;
			end
		else if(scval1>=840 && scval1<850)
			begin
			val3 = 8;
			val2 = 4;
			val1 = scval1-840;
			end
		else if(scval1>=850 && scval1<860)
			begin
			val3 = 8;
			val2 = 5;
			val1 = scval1-850;
			end
		else if(scval1>=860 && scval1<870)
			begin
			val3 = 8;
			val2 = 6;
			val1 = scval1-860;
			end
		else if(scval1>=870 && scval1<880)
			begin
			val3 = 8;
			val2 = 7;
			val1 = scval1-870;
			end
		else if(scval1>=880 && scval1<890)
			begin
			val3 = 8;
			val2 = 8;
			val1 = scval1-880;
			end
		else if(scval1>=890 && scval1<900)
			begin
			val3 = 8;
			val2 = 9;
			val1 = scval1-890;
			end
		else if(scval1>=900 && scval1<910)
			begin
			val3 = 9;
			val2 = 0;
			val1 = scval1-900;
			end
		else if(scval1>=910 && scval1<920)
			begin
			val3 = 9;
			val2 = 1;
			val1 = scval1-910;
			end
		else if(scval1>=920 && scval1<930)
			begin
			val3 = 9;
			val2 = 2;
			val1 = scval1-920;
			end
		else if(scval1>=930 && scval1<940)
			begin
			val3 = 9;
			val2 = 3;
			val1 = scval1-930;
			end
		else if(scval1>=940 && scval1<950)
			begin
			val3 = 9;
			val2 = 4;
			val1 = scval1-940;
			end
		else if(scval1>=950 && scval1<960)
			begin
			val3 = 9;
			val2 = 5;
			val1 = scval1-950;
			end
		else if(scval1>=960 && scval1<970)
			begin
			val3 = 9;
			val2 = 6;
			val1 = scval1-960;
			end
		else if(scval1>=970 && scval1<980)
			begin
			val3 = 9;
			val2 = 7;
			val1 = scval1-970;
			end
		else if(scval1>=980 && scval1<990)
			begin
			val3 = 9;
			val2 = 8;
			val1 = scval1-980;
			end
		else if(scval1>=990 && scval1<1000)
			begin
			val3 = 9;
			val2 = 9;
			val1 = scval1-990;
			end		
		else if(scval1>=1000 && scval1<1010)
			begin			
			val4 = 1;
			val3 = 0;
			val2 = 1;
			val1 = scval1-1000;
			end
		else if(scval1>=1010 && scval1<1020)
			begin			
			val4 = 1;
			val3=0;
			val2 = 1;
			val1 = scval1-1010;
			end
		else if(scval1>=1020 && scval1<1030)
			begin			
			val3=0;
			val4 = 1;
			val2 = 2;
			val1 = scval1-1020;
			end
		else if(scval1>=1030 && scval1<1040)
			begin			
			val3=0;
			val4 = 1;
			val2 = 3;
			val1 = scval1-1030;
			end
		else if(scval1>=1040 && scval1<1050)
			begin			
			val3=0;
			val4 = 1;
			val2 = 4;
			val1 = scval1-1040;
			end
		else if(scval1>=1050 && scval1<1060)
			begin			
			val3=0;
			val4 = 1;
			val2 = 5;
			val1 = scval1-1050;
			end
		else if(scval1>=1060 && scval1<1070)
			begin			
			val3=0;
			val4 = 1;
			val2 = 6;
			val1 = scval1-1060;
			end
		else if(scval1>=1070 && scval1<1080)
			begin			
			val4 = 1;
			val3=0;
			val2 = 7;
			val1 = scval1-1070;
			end
		else if(scval1>=1080 && scval1<1090)
			begin			val4 = 1;val2 = 8;
			val1 = scval1-1080;
			end
		else if(scval1>=1090 && scval1<1100)
			begin			
			val4 = 1;
			val3=0;
			val2 = 8;
			val1 = scval1-190;
			end
		else if(scval1>=1100 && scval1<1110)
			begin			
			val4 = 1;
			val3 = 1;
			val2 = 0;
			val1 = scval1-1100;
			end
		else if(scval1>=1110 && scval1<1120)
			begin			
			val4 = 1;
			val3 = 1;
			val2 = 1;
			val1 = scval1-1110;
			end
		else if(scval1>=1120 && scval1<1130)
			begin			
			val4 = 1;
			val3 = 1;
			val2 = 2;
			val1 = scval1-1120;
			end
		else if(scval1>=1130 && scval1<1140)
			begin			
			val4 = 1;
			val3 = 1;
			val2 = 3;
			val1 = scval1-1130;
			end
		else if(scval1>=1140 && scval1<1150)
			begin			
			val4 = 1;
			val3 = 1;
			val2 = 4;
			val1 = scval1-1140;
			end
		else if(scval1>=1150 && scval1<1160)
			begin			
			val4 = 1;
			val3 = 1;
			val2 = 5;
			val1 = scval1-1150;
			end
		else if(scval1>=1160 && scval1<1170)
			begin			
			val4 = 1;
			val3 = 1;
			val2 = 6;
			val1 = scval1-1160;
			end
		else if(scval1>=1170 && scval1<1180)
			begin			
			val4 = 1;
			val3 = 1;
			val2 = 7;
			val1 = scval1-1170;
			end
		else if(scval1>=1180 && scval1<1190)
			begin			
			val4 = 1;
			val3 = 1;
			val2 = 8;
			val1 = scval1-1180;
			end
		else if(scval1>=1190 && scval1<1200)
			begin			
			val4 = 1;
			val3 = 1;
			val2 = 9;
			val1 = scval1-1190;
			end
		else if(scval1>=1200 && scval1<1210)
			begin			val4 = 1;val3 = 2;
			val2 = 0;
			val1 = scval1-1200;
			end
		else if(scval1>=1210 && scval1<1220)
			begin			
			val4 = 1;
			val3 = 2;
			val2 = 1;
			val1 = scval1-1210;
			end
		else if(scval1>=1220 && scval1<1230)
			begin			
			val4 = 1;
			val3 = 2;
			val2 = 2;
			val1 = scval1-1220;
			end
		else if(scval1>=1230 && scval1<1240)
			begin			
			val4 = 1;
			val3 = 2;
			val2 = 3;
			val1 = scval1-1230;
			end
		else if(scval1>=1240 && scval1<1250)
			begin			
			val4 = 1;
			val3 = 2;
			val2 = 4;
			val1 = scval1-1240;
			end
		else if(scval1>=1250 && scval1<1260)
			begin			
			val4 = 1;
			val3 = 2;
			val2 = 5;
			val1 = scval1-1250;
			end
		else if(scval1>=1260 && scval1<1270)
			begin			
			val4 = 1;
			val3 = 2;
			val2 = 6;
			val1 = scval1-1260;
			end
		else if(scval1>=1270 && scval1<1280)
			begin			
			val4 = 1;
			val3 = 2;
			val2 = 7;
			val1 = scval1-1270;
			end
		else if(scval1>=1280 && scval1<1290)
			begin			
			val4 = 1;
			val3 = 2;
			val2 = 8;
			val1 = scval1-1280;
			end
		else if(scval1>=1290 && scval1<1300)
			begin			
			val4 = 1;
			val3 = 2;
			val2 = 9;
			val1 = scval1-1290;
			end
		else if(scval1>=1300 && scval1<1310)
			begin			
			val4 = 1;
			val3 = 3;
			val2 = 0;
			val1 = scval1-1300;
			end
		else if(scval1>=1310 && scval1<1320)
			begin			
			val4 = 1;
			val3 = 3;
			val2 = 1;
			val1 = scval1-1310;
			end
		else if(scval1>=1320 && scval1<1330)
			begin			
			val4 = 1;
			val3 = 3;
			val2 = 2;
			val1 = scval1-1320;
			end
		else if(scval1>=1330 && scval1<1340)
			begin			
			val4 = 1;
			val3 = 3;
			val2 = 3;
			val1 = scval1-1330;
			end
		else if(scval1>=1340 && scval1<1350)
			begin			
			val4 = 1;
			val3 = 3;
			val2 = 4;
			val1 = scval1-1340;
			end
		else if(scval1>=1350 && scval1<1360)
			begin			
			val4 = 1;
			val3 = 3;
			val2 = 5;
			val1 = scval1-1350;
			end
		else if(scval1>=1360 && scval1<1370)
			begin			
			val4 = 1;
			val3 = 3;
			val2 = 6;
			val1 = scval1-1360;
			end
		else if(scval1>=1370 && scval1<1380)
			begin			
			val4 = 1;
			val3 = 3;
			val2 = 7;
			val1 = scval1-1370;
			end
		else if(scval1>=1380 && scval1<1390)
			begin			
			val4 = 1;
			val3 = 3;
			val2 = 8;
			val1 = scval1-1380;
			end
		else if(scval1>=1390 && scval1<1400)
			begin			
			val4 = 1;
			val3 = 3;
			val2 = 9;
			val1 = scval1-1390;
			end
		else if(scval1>=1400 && scval1<1410)
			begin			
			val4 = 1;
			val3 = 4;
			val2 = 0;
			val1 = scval1-1400;
			end
		else if(scval1>=1410 && scval1<1420)
			begin			
			val4 = 1;
			val3 = 4;
			val2 = 1;
			val1 = scval1-1410;
			end
		else if(scval1>=1420 && scval1<1430)
			begin			
			val4 = 1;
			val3 = 4;
			val2 = 2;
			val1 = scval1-1420;
			end
		else if(scval1>=1430 && scval1<1440)
			begin			
			val4 = 1;
			val3 = 4;
			val2 = 3;
			val1 = scval1-1430;
			end
		else if(scval1>=1440 && scval1<1450)
			begin			
			val4 = 1;
			val3 = 4;
			val2 = 4;
			val1 = scval1-1440;
			end
		else if(scval1>=1450 && scval1<1460)
			begin			
			val4 = 1;
			val3 = 4;
			val2 = 5;
			val1 = scval1-1450;
			end
		else if(scval1>=1460 && scval1<1470)
			begin			
			val4 = 1;
			val3 = 4;
			val2 = 6;
			val1 = scval1-1460;
			end
		else if(scval1>=1470 && scval1<1480)
			begin			
			val4 = 1;
			val3 = 4;
			val2 = 7;
			val1 = scval1-1470;
			end
		else if(scval1>=1480 && scval1<1490)
			begin			
			val4 = 1;
			val3 = 4;
			val2 = 8;
			val1 = scval1-1480;
			end
		else if(scval1>=1490 && scval1<1500)
			begin			
			val4 = 1;
			val3 = 4;
			val2 = 9;
			val1 = scval1-1490;
			end
		else if(scval1>=1500 && scval1<1510)
			begin			
			val4 = 1;
			val3 = 5;
			val2 = 0;
			val1 = scval1-1500;
			end
		else if(scval1>=1510 && scval1<1520)
			begin			
			val4 = 1;
			val3 = 5;
			val2 = 1;
			val1 = scval1-1510;
			end
		else if(scval1>=1520 && scval1<1530)
			begin			
			val4 = 1;
			val3 = 5;
			val2 = 2;
			val1 = scval1-1520;
			end
		else if(scval1>=1530 && scval1<1540)
			begin			
			val4 = 1;
			val3 = 5;
			val2 = 3;
			val1 = scval1-1530;
			end
		else if(scval1>=1540 && scval1<1550)
			begin			
			val4 = 1;
			val3 = 5;
			val2 = 4;
			val1 = scval1-1540;
			end
		else if(scval1>=1550 && scval1<1560)
			begin			
			val4 = 1;
			val3 = 5;
			val2 = 5;
			val1 = scval1-1550;
			end
		else if(scval1>=1560 && scval1<1570)
			begin			
			val4 = 1;
			val3 = 5;
			val2 = 6;
			val1 = scval1-1560;
			end
		else if(scval1>=1570 && scval1<1580)
			begin			
			val4 = 1;
			val3 = 5;
			val2 = 7;
			val1 = scval1-1570;
			end
		else if(scval1>=1580 && scval1<1590)
			begin			
			val4 = 1;
			val3 = 5;
			val2 = 8;
			val1 = scval1-1580;
			end
		else if(scval1>=1590 && scval1<1600)
			begin			
			val4 = 1;
			val3 = 5;
			val2 = 9;
			val1 = scval1-1590;
			end
		else 
			begin
			val4 = 0;
			val3 = 0;
			val2 = 0;
			val1 = 0;
			end
		end
	 
		font_rom fL(.addr(1216+DrawY-250), .data(font_reg0)); //ADDED
		font_rom fE1(.addr(1616+DrawY-250), .data(font_reg1)); 
		font_rom fV(.addr(1888+DrawY-250), .data(font_reg2)); 
		font_rom fE2(.addr(1616+DrawY-250), .data(font_reg3)); 
		font_rom fL1(.addr(1216+DrawY-250), .data(font_reg4)); 
		font_rom fcol1(.addr(928+DrawY-250), .data(font_reg5)); 
		font_rom fx1(.addr(((int'(level)+48)*16)+DrawY-250), .data(font_reg19)); //level
		//font_rom x(.addr(2'h4c*16), .data(font_reg)); //
		font_rom fS(.addr(1328+DrawY-270), .data(font_reg6)); 
		font_rom fC(.addr(1584+DrawY-270), .data(font_reg7)); 
		font_rom fO(.addr(1776+DrawY-270), .data(font_reg8)); 
		font_rom fR(.addr(1824+DrawY-270), .data(font_reg9)); 
		font_rom fE3(.addr(1616+DrawY-270), .data(font_reg10)); 
		font_rom fcol2(.addr(928+DrawY-270), .data(font_reg11)); 
		font_rom fx5(.addr(((val4+48)*16)+DrawY-270), .data(font_reg23));	
		font_rom fx2(.addr(((val3+48)*16)+DrawY-270), .data(font_reg20));	 
		font_rom fx3(.addr((val2+48)*16+DrawY-270), .data(font_reg21)); 
		font_rom fx4(.addr((val1+48)*16+DrawY-270), .data(font_reg22)); //score
		font_rom fL2(.addr(1216+DrawY-290), .data(font_reg12)); 
		font_rom fI(.addr(1680+DrawY-290), .data(font_reg13)); 
		font_rom fV1(.addr(1888+DrawY-290), .data(font_reg14)); 
		font_rom fE4(.addr(1616+DrawY-290), .data(font_reg15)); 
		font_rom fS2(.addr(1840+DrawY-290), .data(font_reg16)); 
		font_rom fcol3(.addr(928+DrawY-290), .data(font_reg17)); 
		font_rom fx0(.addr(((int'(lives)+48)*16)+DrawY-290), .data(font_reg18));		//lives

    always_comb
    begin:Ball_on_proc
        if ( ( DistX*DistX + DistY*DistY) <= (SizeBall * SizeBall) ) 
            ball_on = 1'b1;
        else 
            ball_on = 1'b0;
     end 
	 
	 always_comb
	 begin:Paddle_on_proc
		if(((DrawX - PaddleX1)<=paddleSize)&&((DrawY - PaddleY1)<=50))
			paddle_on = 1'b1;
		else
			paddle_on = 1'b0;
	 end
	 always_comb
	 begin: Brick_on_proc_1			//POSSIBLE CHANGE TO THIS CODE, IF WE ADD BRICK_ON TO EACH BRICK (&& EACH THING WITH CORRESPONDING BRICK_ON)
		if(((DrawX-bX1<=57)&&(DrawY-bY1<=10)&&(brick1==3'b010||brick1==3'b001))||((DrawX-bX2<=57)&&(DrawY-bY2<=10)&&(brick2==3'b010||brick2==3'b001))||
			((DrawX-bX3<=57)&&(DrawY-bY3<=10)&&(brick3==3'b010||brick3==3'b001))||((DrawX-bX4<=57)&&(DrawY-bY4<=10)&&(brick4==3'b010||brick4==3'b001))||
			((DrawX-bX5<=57)&&(DrawY-bY5<=10)&&(brick5==3'b010||brick5==3'b001))||((DrawX-bX6<=57)&&(DrawY-bY6<=10)&&(brick6==3'b010||brick6==3'b001))||
			((DrawX-bX7<=57)&&(DrawY-bY7<=10)&&(brick7==3'b010||brick7==3'b001))||((DrawX-bX8<=57)&&(DrawY-bY8<=10)&&(brick8==3'b010||brick8==3'b001))||
			((DrawX-bX9<=57)&&(DrawY-bY9<=10)&&(brick9==3'b010||brick9==3'b001))||((DrawX-bX10<=57)&&(DrawY-bY10<=10)&&(brick10==3'b010||brick10==3'b001))||
			((DrawX-bX11<=57)&&(DrawY-bY11<=10)&&(brick11==3'b010||brick11==3'b001))||((DrawX-bX12<=57)&&(DrawY-bY12<=10)&&(brick12==3'b010||brick12==3'b001))||
			((DrawX-bX13<=57)&&(DrawY-bY13<=10)&&(brick13==3'b010||brick13==3'b001))||((DrawX-bX14<=57)&&(DrawY-bY14<=10)&&(brick14==3'b010||brick14==3'b001))||
			((DrawX-bX15<=57)&&(DrawY-bY15<=10)&&(brick15==3'b010||brick15==3'b001))||((DrawX-bX16<=57)&&(DrawY-bY16<=10)&&(brick16==3'b010||brick16==3'b001))||
			((DrawX-bX17<=57)&&(DrawY-bY17<=10)&&(brick17==3'b010||brick17==3'b001))||((DrawX-bX18<=57)&&(DrawY-bY18<=10)&&(brick18==3'b010||brick18==3'b001))||
			((DrawX-bX19<=57)&&(DrawY-bY19<=10)&&(brick19==3'b010||brick19==3'b001))||((DrawX-bX20<=57)&&(DrawY-bY20<=10)&&(brick20==3'b010||brick20==3'b001))||
			((DrawX-bX21<=57)&&(DrawY-bY21<=10)&&(brick21==3'b010||brick21==3'b001))||((DrawX-bX22<=57)&&(DrawY-bY22<=10)&&(brick22==3'b010||brick22==3'b001))||
			((DrawX-bX23<=57)&&(DrawY-bY23<=10)&&(brick23==3'b010||brick23==3'b001))||((DrawX-bX24<=57)&&(DrawY-bY24<=10)&&(brick24==3'b010||brick24==3'b001))||
			((DrawX-bX25<=57)&&(DrawY-bY25<=10)&&(brick25==3'b010||brick25==3'b001))||((DrawX-bX26<=57)&&(DrawY-bY26<=10)&&(brick26==3'b010||brick26==3'b001))||
			((DrawX-bX27<=57)&&(DrawY-bY27<=10)&&(brick27==3'b010||brick27==3'b001))||((DrawX-bX28<=57)&&(DrawY-bY28<=10)&&(brick28==3'b010||brick28==3'b001))||
			((DrawX-bX29<=57)&&(DrawY-bY29<=10)&&(brick29==3'b010||brick29==3'b001))||((DrawX-bX30<=57)&&(DrawY-bY30<=10)&&(brick30==3'b010||brick30==3'b001))||
			((DrawX-bX31<=57)&&(DrawY-bY31<=10)&&(brick31==3'b010||brick31==3'b001))||((DrawX-bX32<=57)&&(DrawY-bY32<=10)&&(brick32==3'b010||brick32==3'b001))||
			((DrawX-bX33<=57)&&(DrawY-bY33<=10)&&(brick33==3'b010||brick33==3'b001))||((DrawX-bX34<=57)&&(DrawY-bY34<=10)&&(brick34==3'b010||brick34==3'b001))||
			((DrawX-bX35<=57)&&(DrawY-bY35<=10)&&(brick35==3'b010||brick35==3'b001))||((DrawX-bX36<=57)&&(DrawY-bY36<=10)&&(brick36==3'b010||brick36==3'b001))||
			((DrawX-bX37<=57)&&(DrawY-bY37<=10)&&(brick37==3'b010||brick37==3'b001))||((DrawX-bX38<=57)&&(DrawY-bY38<=10)&&(brick38==3'b010||brick38==3'b001))||
			((DrawX-bX39<=57)&&(DrawY-bY39<=10)&&(brick39==3'b010||brick39==3'b001))||((DrawX-bX40<=57)&&(DrawY-bY40<=10)&&(brick40==3'b010||brick40==3'b001))||
			((DrawX-bX41<=57)&&(DrawY-bY41<=10)&&(brick41==3'b010||brick41==3'b001))||((DrawX-bX42<=57)&&(DrawY-bY42<=10)&&(brick42==3'b010||brick42==3'b001))||
			((DrawX-bX43<=57)&&(DrawY-bY43<=10)&&(brick43==3'b010||brick43==3'b001))||((DrawX-bX44<=57)&&(DrawY-bY44<=10)&&(brick44==3'b010||brick44==3'b001))||
			((DrawX-bX45<=57)&&(DrawY-bY45<=10)&&(brick45==3'b010||brick45==3'b001))||((DrawX-bX46<=57)&&(DrawY-bY46<=10)&&(brick46==3'b010||brick46==3'b001))||
			((DrawX-bX47<=57)&&(DrawY-bY47<=10)&&(brick47==3'b010||brick47==3'b001))||((DrawX-bX48<=57)&&(DrawY-bY48<=10)&&(brick48==3'b010||brick48==3'b001))||
			((DrawX-bX49<=57)&&(DrawY-bY49<=10)&&(brick49==3'b010||brick49==3'b001))||((DrawX-bX50<=57)&&(DrawY-bY50<=10)&&(brick50==3'b010||brick50==3'b001))||
			((DrawX-bX51<=57)&&(DrawY-bY51<=10)&&(brick51==3'b010||brick51==3'b001))||((DrawX-bX52<=57)&&(DrawY-bY52<=10)&&(brick52==3'b010||brick52==3'b001))||
			((DrawX-bX53<=57)&&(DrawY-bY53<=10)&&(brick53==3'b010||brick53==3'b001))||((DrawX-bX54<=57)&&(DrawY-bY54<=10)&&(brick54==3'b010||brick54==3'b001))||
			((DrawX-bX55<=57)&&(DrawY-bY55<=10)&&(brick55==3'b010||brick55==3'b001))||((DrawX-bX56<=57)&&(DrawY-bY56<=10)&&(brick56==3'b010||brick56==3'b001))||
			((DrawX-bX57<=57)&&(DrawY-bY57<=10)&&(brick57==3'b010||brick57==3'b001))||((DrawX-bX58<=57)&&(DrawY-bY58<=10)&&(brick58==3'b010||brick58==3'b001))||
			((DrawX-bX59<=57)&&(DrawY-bY59<=10)&&(brick59==3'b010||brick59==3'b001))||((DrawX-bX60<=57)&&(DrawY-bY60<=10)&&(brick60==3'b010||brick60==3'b001))||
			((DrawX-bX61<=57)&&(DrawY-bY61<=10)&&(brick61==3'b010||brick61==3'b001))||((DrawX-bX62<=57)&&(DrawY-bY62<=10)&&(brick62==3'b010||brick62==3'b001))||
			((DrawX-bX63<=57)&&(DrawY-bY63<=10)&&(brick63==3'b010||brick63==3'b001))||((DrawX-bX64<=57)&&(DrawY-bY64<=10)&&(brick64==3'b010||brick64==3'b001))||
			((DrawX-bX65<=57)&&(DrawY-bY65<=10)&&(brick65==3'b010||brick65==3'b001))||((DrawX-bX66<=57)&&(DrawY-bY66<=10)&&(brick66==3'b010||brick66==3'b001))||
			((DrawX-bX67<=57)&&(DrawY-bY67<=10)&&(brick67==3'b010||brick67==3'b001))||((DrawX-bX68<=57)&&(DrawY-bY68<=10)&&(brick68==3'b010||brick68==3'b001))||
			((DrawX-bX69<=57)&&(DrawY-bY69<=10)&&(brick69==3'b010||brick69==3'b001))||((DrawX-bX70<=57)&&(DrawY-bY70<=10)&&(brick70==3'b010||brick70==3'b001))||
			((DrawX-bX71<=57)&&(DrawY-bY71<=10)&&(brick71==3'b010||brick71==3'b001))||((DrawX-bX72<=57)&&(DrawY-bY72<=10)&&(brick72==3'b010||brick72==3'b001))||
			((DrawX-bX73<=57)&&(DrawY-bY73<=10)&&(brick73==3'b010||brick73==3'b001))||((DrawX-bX74<=57)&&(DrawY-bY74<=10)&&(brick74==3'b010||brick74==3'b001))||
			((DrawX-bX75<=57)&&(DrawY-bY75<=10)&&(brick75==3'b010||brick75==3'b001))||((DrawX-bX76<=57)&&(DrawY-bY76<=10)&&(brick76==3'b010||brick76==3'b001))||
			((DrawX-bX77<=57)&&(DrawY-bY77<=10)&&(brick77==3'b010||brick77==3'b001))||((DrawX-bX78<=57)&&(DrawY-bY78<=10)&&(brick78==3'b010||brick78==3'b001))||
			((DrawX-bX79<=57)&&(DrawY-bY79<=10)&&(brick79==3'b010||brick79==3'b001))||((DrawX-bX80<=57)&&(DrawY-bY80<=10)&&(brick80==3'b010||brick80==3'b001))||
			((DrawX-bX81<=57)&&(DrawY-bY81<=10)&&(brick81==3'b010||brick81==3'b001))||((DrawX-bX82<=57)&&(DrawY-bY82<=10)&&(brick82==3'b010||brick82==3'b001))||
			((DrawX-bX83<=57)&&(DrawY-bY83<=10)&&(brick83==3'b010||brick83==3'b001))||((DrawX-bX84<=57)&&(DrawY-bY84<=10)&&(brick84==3'b010||brick84==3'b001))||
			((DrawX-bX85<=57)&&(DrawY-bY85<=10)&&(brick85==3'b010||brick85==3'b001))||((DrawX-bX86<=57)&&(DrawY-bY86<=10)&&(brick86==3'b010||brick86==3'b001))||
			((DrawX-bX87<=57)&&(DrawY-bY87<=10)&&(brick87==3'b010||brick87==3'b001))||((DrawX-bX88<=57)&&(DrawY-bY88<=10)&&(brick88==3'b010||brick88==3'b001))||
			((DrawX-bX89<=57)&&(DrawY-bY89<=10)&&(brick89==3'b010||brick89==3'b001))||((DrawX-bX90<=57)&&(DrawY-bY90<=10)&&(brick90==3'b010||brick90==3'b001))||
			((DrawX-bX91<=57)&&(DrawY-bY91<=10)&&(brick91==3'b010||brick91==3'b001))||((DrawX-bX92<=57)&&(DrawY-bY92<=10)&&(brick92==3'b010||brick92==3'b001))||
			((DrawX-bX93<=57)&&(DrawY-bY93<=10)&&(brick93==3'b010||brick93==3'b001))||((DrawX-bX94<=57)&&(DrawY-bY94<=10)&&(brick94==3'b010||brick94==3'b001))||
			((DrawX-bX95<=57)&&(DrawY-bY95<=10)&&(brick95==3'b010||brick95==3'b001))||((DrawX-bX96<=57)&&(DrawY-bY96<=10)&&(brick96==3'b010||brick96==3'b001))||
			((DrawX-bX97<=57)&&(DrawY-bY97<=10)&&(brick97==3'b010||brick97==3'b001))||((DrawX-bX98<=57)&&(DrawY-bY98<=10)&&(brick98==3'b010||brick98==3'b001))||
			((DrawX-bX99<=57)&&(DrawY-bY99<=10)&&(brick99==3'b010||brick99==3'b001))||((DrawX-bX60<=57)&&(DrawY-bY110<=10)&&(brick110==3'b010||brick110==3'b001))||
			((DrawX-bX101<=57)&&(DrawY-bY101<=10)&&(brick101==3'b010||brick101==3'b001))||((DrawX-bX102<=57)&&(DrawY-bY102<=10)&&(brick102==3'b010||brick102==3'b001))||
			((DrawX-bX103<=57)&&(DrawY-bY103<=10)&&(brick103==3'b010||brick103==3'b001))||((DrawX-bX104<=57)&&(DrawY-bY104<=10)&&(brick104==3'b010||brick104==3'b001))||
			((DrawX-bX105<=57)&&(DrawY-bY105<=10)&&(brick105==3'b010||brick105==3'b001))||((DrawX-bX106<=57)&&(DrawY-bY106<=10)&&(brick106==3'b010||brick106==3'b001))||
			((DrawX-bX107<=57)&&(DrawY-bY107<=10)&&(brick107==3'b010||brick107==3'b001))||((DrawX-bX108<=57)&&(DrawY-bY108<=10)&&(brick108==3'b010||brick108==3'b001))||
			((DrawX-bX109<=57)&&(DrawY-bY109<=10)&&(brick109==3'b010||brick109==3'b001))||((DrawX-bX110<=57)&&(DrawY-bY110<=10)&&(brick110==3'b010||brick110==3'b001)))
				brick_on_1=1'b1;
				
	 else
			brick_on_1=1'b0;
    end	
	 
	 always_comb						//ADDED
		begin:Sprite_on_proc
			if(DrawX>=180 && DrawX<=187 && DrawY>=250 && DrawY<=265)
				l0_on = font_reg0[187-DrawX];
			else
				l0_on = 1'b0;		
			if(DrawX>=190 && DrawX<=197 && DrawY>=250 && DrawY<=265)
				e0_on = font_reg1[197-DrawX];
			else
				e0_on = 1'b0;			
			if(DrawX>=200 && DrawX<=207 && DrawY>=250 && DrawY<=265)
				v0_on = font_reg2[207-DrawX];
			else
				v0_on = 1'b0;	
			if(DrawX>=210 && DrawX<=217 && DrawY>=250 && DrawY<=265)
				e1_on = font_reg3[217-DrawX];
			else
				e1_on = 1'b0;	
			if(DrawX>=220 && DrawX<=227 && DrawY>=250 && DrawY<=265)
				l1_on = font_reg4[227-DrawX];
			else
				l1_on = 1'b0;	
			if(DrawX>=230 && DrawX<=237 && DrawY>=250 && DrawY<=265)
				col0_on = font_reg5[237-DrawX];
			else
				col0_on = 1'b0;
			if(DrawX>=240 && DrawX<=247 && DrawY>=250 && DrawY<=265)
				levels_on = font_reg19[247-DrawX];
			else
				levels_on = 1'b0;	
			if(DrawX>=180 && DrawX<=187 && DrawY>=270 && DrawY<=285)
				s0_on = font_reg6[187-DrawX];
			else
				s0_on = 1'b0;		
			if(DrawX>=190 && DrawX<=197 && DrawY>=270 && DrawY<=285)
				c0_on = font_reg7[197-DrawX];
			else
				c0_on = 1'b0;						
			if(DrawX>=200 && DrawX<=207 && DrawY>=270 && DrawY<=285)
				o0_on = font_reg8[207-DrawX];
			else
				o0_on = 1'b0;	
			if(DrawX>=210 && DrawX<=217 && DrawY>=270 && DrawY<=285)
				r0_on = font_reg9[217-DrawX];
			else
				r0_on = 1'b0;	
			if(DrawX>=220 && DrawX<=227 && DrawY>=270 && DrawY<=285)
				e2_on = font_reg10[227-DrawX];
			else
				e2_on = 1'b0;	
			if(DrawX>=230 && DrawX<=237 && DrawY>=270 && DrawY<=285)
				col1_on = font_reg11[237-DrawX];
			else
				col1_on = 1'b0;	
			if(DrawX>=240 && DrawX<=247 && DrawY>=270 && DrawY<=285)
				score4_on = font_reg23[247-DrawX];
			else
				score4_on = 1'b0;	//score
			if(DrawX>=250 && DrawX<=257 && DrawY>=270 && DrawY<=285)//score
				score1_on = font_reg20[257-DrawX];
			else
				score1_on = 1'b0;	
			if(DrawX>=260 && DrawX<=267 && DrawY>=270 && DrawY<=285)
				score2_on = font_reg21[267-DrawX];
			else
				score2_on = 1'b0;	
			if(DrawX>=270 && DrawX<=277 && DrawY>=270 && DrawY<=285)
				score3_on = font_reg22[277-DrawX];
			else
				score3_on = 1'b0;	//score
			if(DrawX>=180 && DrawX<=187 && DrawY>=290 && DrawY<=305)//lives
				l2_on = font_reg12[187-DrawX];
			else
				l2_on = 1'b0;	
			if(DrawX>=190 && DrawX<=197 && DrawY>=290 && DrawY<=305)
				i0_on = font_reg13[197-DrawX];
			else
				i0_on = 1'b0;	
			if(DrawX>=200 && DrawX<=207 && DrawY>=290 && DrawY<=305)
				v1_on = font_reg14[207-DrawX];
			else
				v1_on = 1'b0;			
			if(DrawX>=210 && DrawX<=217 && DrawY>=290 && DrawY<=305)
				e1_on = font_reg15[217-DrawX];
			else
				e1_on = 1'b0;
			if(DrawX>=220 && DrawX<=227 && DrawY>=290 && DrawY<=305)
				s1_on = font_reg16[227-DrawX];
			else
				s1_on = 1'b0;
			if(DrawX>=230 && DrawX<=237 && DrawY>=290 && DrawY<=305)
				col2_on = font_reg17[237-DrawX];
			else
				col2_on = 1'b0;
			if(DrawX>=240 && DrawX<=247 && DrawY>=290 && DrawY<=305)
				lives_on = font_reg18[247-DrawX];
			else
				lives_on = 1'b0;
		end
	 
	 
	 always_comb
	 begin: Brick_on_proc_2			//POSSIBLE CHANGE TO THIS CODE, IF WE ADD BRICK_ON TO EACH BRICK (&& EACH THING WITH CORRESPONDING BRICK_ON)
		if(((DrawX-bX1<=57)&&(DrawY-bY1<=10)&&(brick1==3'b011||brick1==3'b101||brick1==3'b100))||((DrawX-bX2<=57)&&(DrawY-bY2<=10)&&(brick2==3'b011||brick2==3'b101||brick2==3'b100))||
			((DrawX-bX3<=57)&&(DrawY-bY3<=10)&&(brick3==3'b011||brick3==3'b101||brick3==3'b100))||((DrawX-bX4<=57)&&(DrawY-bY4<=10)&&(brick4==3'b011||brick4==3'b101||brick4==3'b100))||
			((DrawX-bX5<=57)&&(DrawY-bY5<=10)&&(brick5==3'b011||brick5==3'b101||brick5==3'b100))||((DrawX-bX6<=57)&&(DrawY-bY6<=10)&&(brick6==3'b011||brick6==3'b101||brick6==3'b100))||
			((DrawX-bX7<=57)&&(DrawY-bY7<=10)&&(brick7==3'b011||brick7==3'b101||brick7==3'b100))||((DrawX-bX8<=57)&&(DrawY-bY8<=10)&&(brick8==3'b011||brick8==3'b101||brick8==3'b100))||
			((DrawX-bX9<=57)&&(DrawY-bY9<=10)&&(brick9==3'b011||brick9==3'b101||brick9==3'b100))||((DrawX-bX10<=57)&&(DrawY-bY10<=10)&&(brick10==3'b011||brick10==3'b101||brick10==3'b100))||
			((DrawX-bX11<=57)&&(DrawY-bY11<=10)&&(brick11==3'b011||brick11==3'b101||brick11==3'b100))||((DrawX-bX12<=57)&&(DrawY-bY12<=10)&&(brick12==3'b011||brick12==3'b101||brick12==3'b100))||
			((DrawX-bX13<=57)&&(DrawY-bY13<=10)&&(brick13==3'b011||brick13==3'b101||brick13==3'b100))||((DrawX-bX14<=57)&&(DrawY-bY14<=10)&&(brick14==3'b011||brick14==3'b101||brick14==3'b100))||
			((DrawX-bX15<=57)&&(DrawY-bY15<=10)&&(brick15==3'b011||brick15==3'b101||brick15==3'b100))||((DrawX-bX16<=57)&&(DrawY-bY16<=10)&&(brick16==3'b011||brick16==3'b101||brick16==3'b100))||
			((DrawX-bX17<=57)&&(DrawY-bY17<=10)&&(brick17==3'b011||brick17==3'b101||brick17==3'b100))||((DrawX-bX18<=57)&&(DrawY-bY18<=10)&&(brick18==3'b011||brick18==3'b101||brick18==3'b100))||
			((DrawX-bX19<=57)&&(DrawY-bY19<=10)&&(brick19==3'b011||brick19==3'b101||brick19==3'b100))||((DrawX-bX20<=57)&&(DrawY-bY20<=10)&&(brick20==3'b011||brick20==3'b101||brick20==3'b100))||
			((DrawX-bX21<=57)&&(DrawY-bY21<=10)&&(brick21==3'b011||brick21==3'b101||brick21==3'b100))||((DrawX-bX22<=57)&&(DrawY-bY22<=10)&&(brick22==3'b011||brick22==3'b101||brick22==3'b100))||
			((DrawX-bX23<=57)&&(DrawY-bY23<=10)&&(brick23==3'b011||brick23==3'b101||brick23==3'b100))||((DrawX-bX24<=57)&&(DrawY-bY24<=10)&&(brick24==3'b011||brick24==3'b101||brick24==3'b100))||
			((DrawX-bX25<=57)&&(DrawY-bY25<=10)&&(brick25==3'b011||brick25==3'b101||brick25==3'b100))||((DrawX-bX26<=57)&&(DrawY-bY26<=10)&&(brick26==3'b011||brick26==3'b101||brick26==3'b100))||
			((DrawX-bX27<=57)&&(DrawY-bY27<=10)&&(brick27==3'b011||brick27==3'b101||brick27==3'b100))||((DrawX-bX28<=57)&&(DrawY-bY28<=10)&&(brick28==3'b011||brick28==3'b101||brick28==3'b100))||
			((DrawX-bX29<=57)&&(DrawY-bY29<=10)&&(brick29==3'b011||brick29==3'b101||brick29==3'b100))||((DrawX-bX30<=57)&&(DrawY-bY30<=10)&&(brick30==3'b011||brick30==3'b101||brick30==3'b100))||
			((DrawX-bX31<=57)&&(DrawY-bY31<=10)&&(brick31==3'b011||brick31==3'b101||brick31==3'b100))||((DrawX-bX32<=57)&&(DrawY-bY32<=10)&&(brick32==3'b011||brick32==3'b101||brick32==3'b100))||
			((DrawX-bX33<=57)&&(DrawY-bY33<=10)&&(brick33==3'b011||brick33==3'b101||brick33==3'b100))||((DrawX-bX34<=57)&&(DrawY-bY34<=10)&&(brick34==3'b011||brick34==3'b101||brick34==3'b100))||
			((DrawX-bX35<=57)&&(DrawY-bY35<=10)&&(brick35==3'b011||brick35==3'b101||brick35==3'b100))||((DrawX-bX36<=57)&&(DrawY-bY36<=10)&&(brick36==3'b011||brick36==3'b101||brick36==3'b100))||
			((DrawX-bX37<=57)&&(DrawY-bY37<=10)&&(brick37==3'b011||brick37==3'b101||brick37==3'b100))||((DrawX-bX38<=57)&&(DrawY-bY38<=10)&&(brick38==3'b011||brick38==3'b101||brick38==3'b100))||
			((DrawX-bX39<=57)&&(DrawY-bY39<=10)&&(brick39==3'b011||brick39==3'b101||brick39==3'b100))||((DrawX-bX40<=57)&&(DrawY-bY40<=10)&&(brick40==3'b011||brick40==3'b101||brick40==3'b100))||
			((DrawX-bX41<=57)&&(DrawY-bY41<=10)&&(brick41==3'b011||brick41==3'b101||brick41==3'b100))||((DrawX-bX42<=57)&&(DrawY-bY42<=10)&&(brick42==3'b011||brick42==3'b101||brick42==3'b100))||
			((DrawX-bX43<=57)&&(DrawY-bY43<=10)&&(brick43==3'b011||brick43==3'b101||brick43==3'b100))||((DrawX-bX44<=57)&&(DrawY-bY44<=10)&&(brick44==3'b011||brick44==3'b101||brick44==3'b100))||
			((DrawX-bX45<=57)&&(DrawY-bY45<=10)&&(brick45==3'b011||brick45==3'b101||brick45==3'b100))||((DrawX-bX46<=57)&&(DrawY-bY46<=10)&&(brick46==3'b011||brick46==3'b101||brick46==3'b100))||
			((DrawX-bX47<=57)&&(DrawY-bY47<=10)&&(brick47==3'b011||brick47==3'b101||brick47==3'b100))||((DrawX-bX48<=57)&&(DrawY-bY48<=10)&&(brick48==3'b011||brick48==3'b101||brick48==3'b100))||
			((DrawX-bX49<=57)&&(DrawY-bY49<=10)&&(brick49==3'b011||brick49==3'b101||brick49==3'b100))||((DrawX-bX50<=57)&&(DrawY-bY50<=10)&&(brick50==3'b011||brick50==3'b101||brick50==3'b100))||
			((DrawX-bX51<=57)&&(DrawY-bY51<=10)&&(brick51==3'b011||brick51==3'b101||brick51==3'b100))||((DrawX-bX52<=57)&&(DrawY-bY52<=10)&&(brick52==3'b011||brick52==3'b101||brick52==3'b100))||
			((DrawX-bX53<=57)&&(DrawY-bY53<=10)&&(brick53==3'b011||brick53==3'b101||brick53==3'b100))||((DrawX-bX54<=57)&&(DrawY-bY54<=10)&&(brick54==3'b011||brick54==3'b101||brick54==3'b100))||
			((DrawX-bX55<=57)&&(DrawY-bY55<=10)&&(brick55==3'b011||brick55==3'b101||brick55==3'b100))||((DrawX-bX56<=57)&&(DrawY-bY56<=10)&&(brick56==3'b011||brick56==3'b101||brick56==3'b100))||
			((DrawX-bX57<=57)&&(DrawY-bY57<=10)&&(brick57==3'b011||brick57==3'b101||brick57==3'b100))||((DrawX-bX58<=57)&&(DrawY-bY58<=10)&&(brick58==3'b011||brick58==3'b101||brick58==3'b100))||
			((DrawX-bX59<=57)&&(DrawY-bY59<=10)&&(brick59==3'b011||brick59==3'b101||brick59==3'b100))||((DrawX-bX60<=57)&&(DrawY-bY60<=10)&&(brick60==3'b011||brick60==3'b101||brick60==3'b100))||
			((DrawX-bX61<=57)&&(DrawY-bY61<=10)&&(brick61==3'b011||brick61==3'b101||brick61==3'b100))||((DrawX-bX62<=57)&&(DrawY-bY62<=10)&&(brick62==3'b011||brick62==3'b101||brick62==3'b100))||
			((DrawX-bX63<=57)&&(DrawY-bY63<=10)&&(brick63==3'b011||brick63==3'b101||brick63==3'b100))||((DrawX-bX64<=57)&&(DrawY-bY64<=10)&&(brick64==3'b011||brick64==3'b101||brick64==3'b100))||
			((DrawX-bX65<=57)&&(DrawY-bY65<=10)&&(brick65==3'b011||brick65==3'b101||brick65==3'b100))||((DrawX-bX66<=57)&&(DrawY-bY66<=10)&&(brick66==3'b011||brick66==3'b101||brick66==3'b100))||
			((DrawX-bX67<=57)&&(DrawY-bY67<=10)&&(brick67==3'b011||brick67==3'b101||brick67==3'b100))||((DrawX-bX68<=57)&&(DrawY-bY68<=10)&&(brick68==3'b011||brick68==3'b101||brick68==3'b100))||
			((DrawX-bX69<=57)&&(DrawY-bY69<=10)&&(brick69==3'b011||brick69==3'b101||brick69==3'b100))||((DrawX-bX70<=57)&&(DrawY-bY70<=10)&&(brick70==3'b011||brick70==3'b101||brick70==3'b100))||
			((DrawX-bX71<=57)&&(DrawY-bY71<=10)&&(brick71==3'b011||brick71==3'b101||brick71==3'b100))||((DrawX-bX72<=57)&&(DrawY-bY72<=10)&&(brick72==3'b011||brick72==3'b101||brick72==3'b100))||
			((DrawX-bX73<=57)&&(DrawY-bY73<=10)&&(brick73==3'b011||brick73==3'b101||brick73==3'b100))||((DrawX-bX74<=57)&&(DrawY-bY74<=10)&&(brick74==3'b011||brick74==3'b101||brick74==3'b100))||
			((DrawX-bX75<=57)&&(DrawY-bY75<=10)&&(brick75==3'b011||brick75==3'b101||brick75==3'b100))||((DrawX-bX76<=57)&&(DrawY-bY76<=10)&&(brick76==3'b011||brick76==3'b101||brick76==3'b100))||
			((DrawX-bX77<=57)&&(DrawY-bY77<=10)&&(brick77==3'b011||brick77==3'b101||brick77==3'b100))||((DrawX-bX78<=57)&&(DrawY-bY78<=10)&&(brick78==3'b011||brick78==3'b101||brick78==3'b100))||
			((DrawX-bX79<=57)&&(DrawY-bY79<=10)&&(brick79==3'b011||brick79==3'b101||brick79==3'b100))||((DrawX-bX80<=57)&&(DrawY-bY80<=10)&&(brick80==3'b011||brick80==3'b101||brick80==3'b100))||
			((DrawX-bX81<=57)&&(DrawY-bY81<=10)&&(brick81==3'b011||brick81==3'b101||brick81==3'b100))||((DrawX-bX82<=57)&&(DrawY-bY82<=10)&&(brick82==3'b011||brick82==3'b101||brick82==3'b100))||
			((DrawX-bX83<=57)&&(DrawY-bY83<=10)&&(brick83==3'b011||brick83==3'b101||brick83==3'b100))||((DrawX-bX84<=57)&&(DrawY-bY84<=10)&&(brick84==3'b011||brick84==3'b101||brick84==3'b100))||
			((DrawX-bX85<=57)&&(DrawY-bY85<=10)&&(brick85==3'b011||brick85==3'b101||brick85==3'b100))||((DrawX-bX86<=57)&&(DrawY-bY86<=10)&&(brick86==3'b011||brick86==3'b101||brick86==3'b100))||
			((DrawX-bX87<=57)&&(DrawY-bY87<=10)&&(brick87==3'b011||brick87==3'b101||brick87==3'b100))||((DrawX-bX88<=57)&&(DrawY-bY88<=10)&&(brick88==3'b011||brick88==3'b101||brick88==3'b100))||
			((DrawX-bX89<=57)&&(DrawY-bY89<=10)&&(brick89==3'b011||brick89==3'b101||brick89==3'b100))||((DrawX-bX90<=57)&&(DrawY-bY90<=10)&&(brick90==3'b011||brick90==3'b101||brick90==3'b100))||
			((DrawX-bX91<=57)&&(DrawY-bY91<=10)&&(brick91==3'b011||brick91==3'b101||brick91==3'b100))||((DrawX-bX92<=57)&&(DrawY-bY92<=10)&&(brick92==3'b011||brick92==3'b101||brick92==3'b100))||
			((DrawX-bX93<=57)&&(DrawY-bY93<=10)&&(brick93==3'b011||brick93==3'b101||brick93==3'b100))||((DrawX-bX94<=57)&&(DrawY-bY94<=10)&&(brick94==3'b011||brick94==3'b101||brick94==3'b100))||
			((DrawX-bX95<=57)&&(DrawY-bY95<=10)&&(brick95==3'b011||brick95==3'b101||brick95==3'b100))||((DrawX-bX96<=57)&&(DrawY-bY96<=10)&&(brick96==3'b011||brick96==3'b101||brick96==3'b100))||
			((DrawX-bX97<=57)&&(DrawY-bY97<=10)&&(brick97==3'b011||brick97==3'b101||brick97==3'b100))||((DrawX-bX98<=57)&&(DrawY-bY98<=10)&&(brick98==3'b011||brick98==3'b101||brick98==3'b100))||
			((DrawX-bX99<=57)&&(DrawY-bY99<=10)&&(brick99==3'b011||brick99==3'b101||brick99==3'b100))||((DrawX-bX60<=57)&&(DrawY-bY100<=10)&&(brick100==3'b011||brick100==3'b101||brick100==3'b100))||
			((DrawX-bX101<=57)&&(DrawY-bY101<=10)&&(brick101==3'b011||brick101==3'b101||brick101==3'b100))||((DrawX-bX102<=57)&&(DrawY-bY102<=10)&&(brick102==3'b011||brick102==3'b101||brick102==3'b100))||
			((DrawX-bX103<=57)&&(DrawY-bY103<=10)&&(brick103==3'b011||brick103==3'b101||brick103==3'b100))||((DrawX-bX104<=57)&&(DrawY-bY104<=10)&&(brick104==3'b011||brick104==3'b101||brick104==3'b100))||
			((DrawX-bX105<=57)&&(DrawY-bY105<=10)&&(brick105==3'b011||brick105==3'b101||brick105==3'b100))||((DrawX-bX106<=57)&&(DrawY-bY106<=10)&&(brick106==3'b011||brick106==3'b101||brick106==3'b100))||
			((DrawX-bX107<=57)&&(DrawY-bY107<=10)&&(brick107==3'b011||brick107==3'b101||brick107==3'b100))||((DrawX-bX108<=57)&&(DrawY-bY108<=10)&&(brick108==3'b011||brick108==3'b101||brick108==3'b100))||
			((DrawX-bX109<=57)&&(DrawY-bY109<=10)&&(brick109==3'b011||brick109==3'b101||brick109==3'b100))||((DrawX-bX110<=57)&&(DrawY-bY110<=10)&&(brick110==3'b011||brick110==3'b101||brick110==3'b100)))
				brick_on_2=1'b1;
				
	 else
			brick_on_2=1'b0;
    end	
	 always_comb
	 begin: Brick_on_proc_3			//POSSIBLE CHANGE TO THIS CODE, IF WE ADD BRICK_ON TO EACH BRICK (&& EACH THING WITH CORRESPONDING BRICK_ON)
		if(((DrawX-bX1<=57)&&(DrawY-bY1<=10)&&(brick1==3'b111||brick1==3'b110))||((DrawX-bX2<=57)&&(DrawY-bY2<=10)&&(brick2==3'b111||brick2==3'b110))||
			((DrawX-bX3<=57)&&(DrawY-bY3<=10)&&(brick3==3'b111||brick3==3'b110))||((DrawX-bX4<=57)&&(DrawY-bY4<=10)&&(brick4==3'b111||brick4==3'b110))||
			((DrawX-bX5<=57)&&(DrawY-bY5<=10)&&(brick5==3'b111||brick5==3'b110))||((DrawX-bX6<=57)&&(DrawY-bY6<=10)&&(brick6==3'b111||brick6==3'b110))||
			((DrawX-bX7<=57)&&(DrawY-bY7<=10)&&(brick7==3'b111||brick7==3'b110))||((DrawX-bX8<=57)&&(DrawY-bY8<=10)&&(brick8==3'b111||brick8==3'b110))||
			((DrawX-bX9<=57)&&(DrawY-bY9<=10)&&(brick9==3'b111||brick9==3'b110))||((DrawX-bX10<=57)&&(DrawY-bY10<=10)&&(brick10==3'b111||brick10==3'b110))||
			((DrawX-bX11<=57)&&(DrawY-bY11<=10)&&(brick11==3'b111||brick11==3'b110))||((DrawX-bX12<=57)&&(DrawY-bY12<=10)&&(brick12==3'b111||brick12==3'b110))||
			((DrawX-bX13<=57)&&(DrawY-bY13<=10)&&(brick13==3'b111||brick13==3'b110))||((DrawX-bX14<=57)&&(DrawY-bY14<=10)&&(brick14==3'b111||brick14==3'b110))||
			((DrawX-bX15<=57)&&(DrawY-bY15<=10)&&(brick15==3'b111||brick15==3'b110))||((DrawX-bX16<=57)&&(DrawY-bY16<=10)&&(brick16==3'b111||brick16==3'b110))||
			((DrawX-bX17<=57)&&(DrawY-bY17<=10)&&(brick17==3'b111||brick17==3'b110))||((DrawX-bX18<=57)&&(DrawY-bY18<=10)&&(brick18==3'b111||brick18==3'b110))||
			((DrawX-bX19<=57)&&(DrawY-bY19<=10)&&(brick19==3'b111||brick19==3'b110))||((DrawX-bX20<=57)&&(DrawY-bY20<=10)&&(brick20==3'b111||brick20==3'b110))||
			((DrawX-bX21<=57)&&(DrawY-bY21<=10)&&(brick21==3'b111||brick21==3'b110))||((DrawX-bX22<=57)&&(DrawY-bY22<=10)&&(brick22==3'b111||brick22==3'b110))||
			((DrawX-bX23<=57)&&(DrawY-bY23<=10)&&(brick23==3'b111||brick23==3'b110))||((DrawX-bX24<=57)&&(DrawY-bY24<=10)&&(brick24==3'b111||brick24==3'b110))||
			((DrawX-bX25<=57)&&(DrawY-bY25<=10)&&(brick25==3'b111||brick25==3'b110))||((DrawX-bX26<=57)&&(DrawY-bY26<=10)&&(brick26==3'b111||brick26==3'b110))||
			((DrawX-bX27<=57)&&(DrawY-bY27<=10)&&(brick27==3'b111||brick27==3'b110))||((DrawX-bX28<=57)&&(DrawY-bY28<=10)&&(brick28==3'b111||brick28==3'b110))||
			((DrawX-bX29<=57)&&(DrawY-bY29<=10)&&(brick29==3'b111||brick29==3'b110))||((DrawX-bX30<=57)&&(DrawY-bY30<=10)&&(brick30==3'b111||brick30==3'b110))||
			((DrawX-bX31<=57)&&(DrawY-bY31<=10)&&(brick31==3'b111||brick31==3'b110))||((DrawX-bX32<=57)&&(DrawY-bY32<=10)&&(brick32==3'b111||brick32==3'b110))||
			((DrawX-bX33<=57)&&(DrawY-bY33<=10)&&(brick33==3'b111||brick33==3'b110))||((DrawX-bX34<=57)&&(DrawY-bY34<=10)&&(brick34==3'b111||brick34==3'b110))||
			((DrawX-bX35<=57)&&(DrawY-bY35<=10)&&(brick35==3'b111||brick35==3'b110))||((DrawX-bX36<=57)&&(DrawY-bY36<=10)&&(brick36==3'b111||brick36==3'b110))||
			((DrawX-bX37<=57)&&(DrawY-bY37<=10)&&(brick37==3'b111||brick37==3'b110))||((DrawX-bX38<=57)&&(DrawY-bY38<=10)&&(brick38==3'b111||brick38==3'b110))||
			((DrawX-bX39<=57)&&(DrawY-bY39<=10)&&(brick39==3'b111||brick39==3'b110))||((DrawX-bX40<=57)&&(DrawY-bY40<=10)&&(brick40==3'b111||brick40==3'b110))||
			((DrawX-bX41<=57)&&(DrawY-bY41<=10)&&(brick41==3'b111||brick41==3'b110))||((DrawX-bX42<=57)&&(DrawY-bY42<=10)&&(brick42==3'b111||brick42==3'b110))||
			((DrawX-bX43<=57)&&(DrawY-bY43<=10)&&(brick43==3'b111||brick43==3'b110))||((DrawX-bX44<=57)&&(DrawY-bY44<=10)&&(brick44==3'b111||brick44==3'b110))||
			((DrawX-bX45<=57)&&(DrawY-bY45<=10)&&(brick45==3'b111||brick45==3'b110))||((DrawX-bX46<=57)&&(DrawY-bY46<=10)&&(brick46==3'b111||brick46==3'b110))||
			((DrawX-bX47<=57)&&(DrawY-bY47<=10)&&(brick47==3'b111||brick47==3'b110))||((DrawX-bX48<=57)&&(DrawY-bY48<=10)&&(brick48==3'b111||brick48==3'b110))||
			((DrawX-bX49<=57)&&(DrawY-bY49<=10)&&(brick49==3'b111||brick49==3'b110))||((DrawX-bX50<=57)&&(DrawY-bY50<=10)&&(brick50==3'b111||brick50==3'b110))||
			((DrawX-bX51<=57)&&(DrawY-bY51<=10)&&(brick51==3'b111||brick51==3'b110))||((DrawX-bX52<=57)&&(DrawY-bY52<=10)&&(brick52==3'b111||brick52==3'b110))||
			((DrawX-bX53<=57)&&(DrawY-bY53<=10)&&(brick53==3'b111||brick53==3'b110))||((DrawX-bX54<=57)&&(DrawY-bY54<=10)&&(brick54==3'b111||brick54==3'b110))||
			((DrawX-bX55<=57)&&(DrawY-bY55<=10)&&(brick55==3'b111||brick55==3'b110))||((DrawX-bX56<=57)&&(DrawY-bY56<=10)&&(brick56==3'b111||brick56==3'b110))||
			((DrawX-bX57<=57)&&(DrawY-bY57<=10)&&(brick57==3'b111||brick57==3'b110))||((DrawX-bX58<=57)&&(DrawY-bY58<=10)&&(brick58==3'b111||brick58==3'b110))||
			((DrawX-bX59<=57)&&(DrawY-bY59<=10)&&(brick59==3'b111||brick59==3'b110))||((DrawX-bX60<=57)&&(DrawY-bY60<=10)&&(brick60==3'b111||brick60==3'b110))||
			((DrawX-bX61<=57)&&(DrawY-bY61<=10)&&(brick61==3'b111||brick61==3'b110))||((DrawX-bX62<=57)&&(DrawY-bY62<=10)&&(brick62==3'b111||brick62==3'b110))||
			((DrawX-bX63<=57)&&(DrawY-bY63<=10)&&(brick63==3'b111||brick63==3'b110))||((DrawX-bX64<=57)&&(DrawY-bY64<=10)&&(brick64==3'b111||brick64==3'b110))||
			((DrawX-bX65<=57)&&(DrawY-bY65<=10)&&(brick65==3'b111||brick65==3'b110))||((DrawX-bX66<=57)&&(DrawY-bY66<=10)&&(brick66==3'b111||brick66==3'b110))||
			((DrawX-bX67<=57)&&(DrawY-bY67<=10)&&(brick67==3'b111||brick67==3'b110))||((DrawX-bX68<=57)&&(DrawY-bY68<=10)&&(brick68==3'b111||brick68==3'b110))||
			((DrawX-bX69<=57)&&(DrawY-bY69<=10)&&(brick69==3'b111||brick69==3'b110))||((DrawX-bX70<=57)&&(DrawY-bY70<=10)&&(brick70==3'b111||brick70==3'b110))||
			((DrawX-bX71<=57)&&(DrawY-bY71<=10)&&(brick71==3'b111||brick71==3'b110))||((DrawX-bX72<=57)&&(DrawY-bY72<=10)&&(brick72==3'b111||brick72==3'b110))||
			((DrawX-bX73<=57)&&(DrawY-bY73<=10)&&(brick73==3'b111||brick73==3'b110))||((DrawX-bX74<=57)&&(DrawY-bY74<=10)&&(brick74==3'b111||brick74==3'b110))||
			((DrawX-bX75<=57)&&(DrawY-bY75<=10)&&(brick75==3'b111||brick75==3'b110))||((DrawX-bX76<=57)&&(DrawY-bY76<=10)&&(brick76==3'b111||brick76==3'b110))||
			((DrawX-bX77<=57)&&(DrawY-bY77<=10)&&(brick77==3'b111||brick77==3'b110))||((DrawX-bX78<=57)&&(DrawY-bY78<=10)&&(brick78==3'b111||brick78==3'b110))||
			((DrawX-bX79<=57)&&(DrawY-bY79<=10)&&(brick79==3'b111||brick79==3'b110))||((DrawX-bX80<=57)&&(DrawY-bY80<=10)&&(brick80==3'b111||brick80==3'b110))||
			((DrawX-bX81<=57)&&(DrawY-bY81<=10)&&(brick81==3'b111||brick81==3'b110))||((DrawX-bX82<=57)&&(DrawY-bY82<=10)&&(brick82==3'b111||brick82==3'b110))||
			((DrawX-bX83<=57)&&(DrawY-bY83<=10)&&(brick83==3'b111||brick83==3'b110))||((DrawX-bX84<=57)&&(DrawY-bY84<=10)&&(brick84==3'b111||brick84==3'b110))||
			((DrawX-bX85<=57)&&(DrawY-bY85<=10)&&(brick85==3'b111||brick85==3'b110))||((DrawX-bX86<=57)&&(DrawY-bY86<=10)&&(brick86==3'b111||brick86==3'b110))||
			((DrawX-bX87<=57)&&(DrawY-bY87<=10)&&(brick87==3'b111||brick87==3'b110))||((DrawX-bX88<=57)&&(DrawY-bY88<=10)&&(brick88==3'b111||brick88==3'b110))||
			((DrawX-bX89<=57)&&(DrawY-bY89<=10)&&(brick89==3'b111||brick89==3'b110))||((DrawX-bX90<=57)&&(DrawY-bY90<=10)&&(brick90==3'b111||brick90==3'b110))||
			((DrawX-bX91<=57)&&(DrawY-bY91<=10)&&(brick91==3'b111||brick91==3'b110))||((DrawX-bX92<=57)&&(DrawY-bY92<=10)&&(brick92==3'b111||brick92==3'b110))||
			((DrawX-bX93<=57)&&(DrawY-bY93<=10)&&(brick93==3'b111||brick93==3'b110))||((DrawX-bX94<=57)&&(DrawY-bY94<=10)&&(brick94==3'b111||brick94==3'b110))||
			((DrawX-bX95<=57)&&(DrawY-bY95<=10)&&(brick95==3'b111||brick95==3'b110))||((DrawX-bX96<=57)&&(DrawY-bY96<=10)&&(brick96==3'b111||brick96==3'b110))||
			((DrawX-bX97<=57)&&(DrawY-bY97<=10)&&(brick97==3'b111||brick97==3'b110))||((DrawX-bX98<=57)&&(DrawY-bY98<=10)&&(brick98==3'b111||brick98==3'b110))||
			((DrawX-bX99<=57)&&(DrawY-bY99<=10)&&(brick99==3'b111||brick99==3'b110))||((DrawX-bX60<=57)&&(DrawY-bY110<=10)&&(brick110==3'b111||brick110==3'b110))||
			((DrawX-bX101<=57)&&(DrawY-bY101<=10)&&(brick101==3'b111||brick101==3'b110))||((DrawX-bX102<=57)&&(DrawY-bY102<=10)&&(brick102==3'b111||brick102==3'b110))||
			((DrawX-bX103<=57)&&(DrawY-bY103<=10)&&(brick103==3'b111||brick103==3'b110))||((DrawX-bX104<=57)&&(DrawY-bY104<=10)&&(brick104==3'b111||brick104==3'b110))||
			((DrawX-bX105<=57)&&(DrawY-bY105<=10)&&(brick105==3'b111||brick105==3'b110))||((DrawX-bX106<=57)&&(DrawY-bY106<=10)&&(brick106==3'b111||brick106==3'b110))||
			((DrawX-bX107<=57)&&(DrawY-bY107<=10)&&(brick107==3'b111||brick107==3'b110))||((DrawX-bX108<=57)&&(DrawY-bY108<=10)&&(brick108==3'b111||brick108==3'b110))||
			((DrawX-bX109<=57)&&(DrawY-bY109<=10)&&(brick109==3'b111||brick109==3'b110))||((DrawX-bX110<=57)&&(DrawY-bY110<=10)&&(brick110==3'b111||brick110==3'b110)))
				brick_on_3=1'b1;
				
	 else
			brick_on_3=1'b0;
    end	
	 
	 always_comb
	 begin:Pow_on_proc
		if(((DrawX - PowX)<=10)&&((DrawY - PowY)<=10)&&power_show==1'b1)
			power_on = 1'b1;
		else
			power_on = 1'b0;
	 end
	 
	 always_comb
    begin:RGB_Display
        if ((ball_on == 1'b1)) 
        begin 
            Red = 10'b1111000000;
            Green = 10'b0101010101;
            Blue = 10'b0000000000;
        end    
	     else if ((paddle_on == 1'b1)) 
        begin 
            Red = 10'b0101010101;
            Green = 10'b1111000000;
            Blue = 10'b0000000000;
        end 
		  else if (brick_on_1==1'b1)
		  begin 
            Red = 10'b1111000000;
            Green = 10'b0101010101;
            Blue = 10'b0000000000;
        end 
		  else if (brick_on_2==1'b1)
		  begin 
            Red = 10'b1111111111;
            Green = 10'b1111111111;
            Blue = 10'b0000000000;
        end 
		  else if (brick_on_3==1'b1)
		  begin 
            Red = 10'b1010101010;
            Green = 10'b0101010101;
            Blue = 10'b1010101010;
        end 
		  else if (l0_on||e0_on||v0_on||e1_on||l1_on||s0_on|| c0_on||o0_on||r0_on||e2_on||l2_on||i0_on||
		  v1_on||e3_on||s1_on||col0_on||col1_on||col2_on||lives_on||score1_on||score2_on||score3_on||levels_on||score4_on)
		  begin
		      Red = 10'b1111111100;
            Green = 10'b1111111100;
            Blue = 10'b1111111100;
			end
		  else 
        begin 
            Red = 10'b0000000000;
            Green = 10'b0000000000;
            Blue = DrawX[9:0]; 
        end      
		  if (power_on ==1'b1)
		  begin
		      Red = 10'b1111111100;
            Green = 10'b1111111100;
            Blue = 10'b1111111100;				
		  end
    end 	 

    
endmodule
