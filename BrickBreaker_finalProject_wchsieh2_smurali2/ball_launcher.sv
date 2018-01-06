module ball_launcher (input frame_clk, noMore, Reset,
							 output logic [9:0] step_X_initial, step_Y_initial); 
logic [3:0] count;				
always_ff @ (posedge frame_clk)
	begin
	if(noMore)				//ANGLE CHANGER
		begin
			if (Reset)
				begin
				step_X_initial <= 3;// - 2'b10;
				step_Y_initial <=3 + 2'b10;// ~(3 + 2'b10)+1'b1;
				count <=4'b0;
				end
			else if ((count == 4'b0)&&noMore)
			begin
				step_X_initial <= 3;// - 2'b10;
				step_Y_initial <=3 + 2'b10;// ~(3 + 2'b10)+1'b1;
				count <=count + 1'b1;
			end
			else if ((count == 4'b0001)&&noMore)
			begin
				step_X_initial <= 3;// - 2'b01;
				step_Y_initial <= 3 + 2'b01;//~(3 + 2'b01)+1'b1;
				count <=count + 1'b1;
			end
			else if ((count == 4'b0010)&&noMore)
			begin
				step_X_initial <= 3;
				step_Y_initial <= 3;//~(3)+1'b1;	
				count <=count + 1'b1;
			end
			else if ((count == 4'b0011)&&noMore)
			begin
				step_X_initial <= 3;// + 2'b01;
				step_Y_initial <=3 - 2'b01;// ~(3 - 2'b01)+1'b1;
				count <=count + 1'b1;
			end
			else if ((count == 4'b0100)&&noMore)
			begin
				step_X_initial <= 3;// + 2'b10;
				step_Y_initial <=3 - 2'b10;// ~(3 - 2'b10)+1'b1;	
				count <=4'b0000;	
				//count <=count + 1'b1;
			end
		  else if ((count == 4'b0101)&&noMore)
			begin
				step_X_initial <= ~(3) +1'b1;// - 2'b10
				step_Y_initial <= 3 + 2'b10;//~(3 + 2'b10)+1'b1;			
				count <=count + 1'b1;
			end
			else if ((count == 4'b0110)&&noMore)
			begin
				step_X_initial <= ~(3)+1'b1;//-2'b01
				step_Y_initial <= 3+2'b01;///~(3+2'b01)+1'b1;
				count <=count + 1'b1;
			end
			else if ((count == 4'b0111)&&noMore)
			begin
				step_X_initial <= ~(3) + 2'b01;
				step_Y_initial <=3;//~(3)+1'b1;
				count <=3'b1000;
			end
			else if ((count == 4'b1000)&&noMore)
			begin
				step_X_initial <= ~(3) + 2'b01;// +2'b01
				step_Y_initial <=3 - 2'b01 ;//~(3 - 2'b01)+1'b1;
				count <=4'b1001;
			end
			else if ((count == 4'b1001)&&noMore)
			begin
				step_X_initial <= ~(3) + 2'b01;// +2'b10
				step_Y_initial <= 3 - 2'b10;//~(3 - 2'b10)+1'b1;
				count <=4'b0000;
			end*/
		end

	end
endmodule
