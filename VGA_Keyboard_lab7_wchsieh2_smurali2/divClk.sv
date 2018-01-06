module divClk(input Clock,	
					output newclk);
					
//divive clk for DFF by 512
//9 bit counter that counts to 511, and when it reaches 512. Starts at 0, when it's 512, set to 1. Or inverse the original signal
integer counter = 0;
always_ff @ (posedge Clock)
begin
	if(counter !=512)
		counter++;
	else if (counter == 512)
	begin
		newclk=~newclk;
		counter = 0;
	end
end

endmodule 