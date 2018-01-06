//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//    paddle.sv                                                            --
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


module  paddle ( input Reset, frame_clk, up, left, down, right, noMore,levelChange,PaddleSizeUpPow, PaddleSizeDownPow,PowOn,
               output logic [9:0]  paddleX1, paddleY1, paddleSize);
    
    logic [9:0] paddle_X1_Pos, paddle_X_Motion,paddle_Y1_Pos,paddle_Y_Motion, paddle_Size;
    parameter [9:0] paddle_X_Bot_Left=300;  // Center position on the X axis
    parameter [9:0] paddle_Y_Bot_Right=465; //479// Center position on the Y axis
    parameter [9:0] paddle_X_Min=8;       // Leftmost point on the X axis
    parameter [9:0] paddle_X_Max=637; //639    // Rightmost point on the X axis
    parameter [9:0] paddle_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] paddle_Y_Max=475;     // Bottommost point on the Y axis
    parameter [9:0] paddle_X_Step=8;      // Step size on the X axis
    parameter [9:0] paddle_Y_Step=2;      // Step size on the Y axis
	 parameter [9:0] paddleBig=150;	
	 parameter [9:0] paddleSmall=35;
	 parameter [9:0] paddleNormal=75;
    always_ff @ (posedge Reset or posedge frame_clk)
    begin: Move_paddle
        if (Reset)  // Asynchronous Reset
        begin 
            paddle_Y_Motion <= 0;
				paddle_X_Motion <= 0;
				paddle_Y1_Pos <= paddle_Y_Bot_Right;
				paddle_X1_Pos <= paddle_X_Bot_Left;
				paddle_Size<=paddleNormal;
        end
        else if(levelChange)
		  begin
		      paddle_Y_Motion <= 0;
				paddle_X_Motion <= 0;
				paddle_Y1_Pos <= paddle_Y_Bot_Right;
				paddle_X1_Pos <= paddle_X_Bot_Left;
				paddle_Size<=paddleNormal;
		  end
		  else 
		  begin 
				if(PowOn)
				begin
					if ((PaddleSizeUpPow))
						paddle_Size<=paddleBig;
					else if((PaddleSizeDownPow))
						paddle_Size<=paddleSmall;
				end
				else if(~PowOn)
					paddle_Size<=paddleNormal;
		  		 if ( (paddle_X1_Pos + paddle_Size) >= paddle_X_Max )  // paddle is at the right edge, BOUNCE!
				 begin
					 paddle_X_Motion <= ~(3) + 1'b1;
				 end
				 else if ((paddle_X1_Pos) <= paddle_X_Min+8) // paddle is at the left edge, BOUNCE!
				 begin 
					 paddle_X_Motion <= 3;
				 end
				 else if ((right && ~up && ~left && ~down)&&~noMore&&( (paddle_X1_Pos + paddle_Size) <= paddle_X_Max ))
				     begin
						  paddle_X_Motion <= paddle_X_Step;
					  end
				 else if ((left && ~up && ~down && ~right)&&~(noMore)&&((paddle_X1_Pos) >= paddle_X_Min+8))
					  begin
						  paddle_X_Motion <= (~ (paddle_X_Step) + 1'b1);
						  end
					
				 else



					paddle_X_Motion <=0;
			
				 
				 paddle_X1_Pos <= (paddle_X1_Pos + paddle_X_Motion);
				 paddle_Y1_Pos <= (paddle_Y1_Pos + paddle_Y_Motion);
			

			
			end  
    end
       
    assign paddleX1 = paddle_X1_Pos;	 
	 assign paddleY1 = paddle_Y1_Pos;
	 assign paddleSize = paddle_Size;
     

endmodule
