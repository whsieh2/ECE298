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


module  BouncingBall ( input         Clk,			//50 MHz clock input
                                     Reset,
												 ps2clk,		//Ps/2 keyboard clock
												 ps2data,	//PS/2 Keyboard data
                       output [9:0]  Red,
							                Green,
												 Blue, 
							  output        VGA_clk,
							                sync,
												 blank,
												 vs,
												 hs );
    
    logic Reset_h, vssig;
    logic [9:0] drawxsig, drawysig, ballxsig, ballysig, ballsizesig;
	logic [2:0] makeCode;
	logic [3:0]dataOut0a;
	logic [3:0]dataOut0b;
	 
   assign {Reset_h}=~ (Reset);  // The push buttons are active low
	
	keyBoard keyboard_instance(.*,
										.Clk(Clk),
										.ps2clock(ps2clk),
										.data(ps2data),
										.outData(makeCode), 
										.dataOut0(dataOut0), 
										.dataOut0a(dataOut0a[3:0]), 
										.dataOut0b(dataOut0b[3:0]));
   
   vga_controller vgasync_instance(.*,
	                                .Clk(Clk),
											  .Reset(Reset_h),
											  .pixel_clk(VGA_clk),
											  .DrawX(drawxsig),
											  .DrawY(drawysig) );
   
   ball ball_instance(.Reset(Reset_h),
	                   .frame_clk(vs),
							 .keyinput(makeCode),			 // Vertical Sync used as an "ad hoc" 60 Hz clock signal
	                   .BallX(ballxsig),  // (This is why we registered it in the vga controller!)
							 .BallY(ballysig),
							 .BallS(ballsizesig));
   
   color_mapper color_instance(.*,
	                            .BallX(ballxsig),
										 .BallY(ballysig),
										 .DrawX(drawxsig),
										 .DrawY(drawysig),
										 .Ball_size(ballsizesig));
										 
	HexDriver HexAL(.In0(dataOut0a[3:0]), .Out0(AhexL));
	HexDriver HexAU(.In0(dataOut0b[3:0]), .Out0(AhexU));

    

endmodule
