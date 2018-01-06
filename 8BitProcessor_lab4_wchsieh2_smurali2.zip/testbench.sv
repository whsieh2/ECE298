module testbench();
//This file gives values for our processor to use and when used with the simulator will give us waveforms.
timeunit 10ns;
timeprecision 1ns;
logic Clk = 0;
logic Reset, LoadA, LoadB, Execute;
logic[7:0]	Din;
logic[2:0]	F;
logic[1:0]	R;
logic[3:0]	LED;
logic[7:0]	Aval,
				Bval;
logic[6:0]	AhexL,
				AhexU,
				BhexL,
				BhexU;
			
logic[7:0]	ans_1a, ans_2b;
integer ErrorCnt = 0;

processor processor0(Clk,Reset,LoadA,LoadB,Execute, Din, F,R, LED, Aval, Bval, AhexL,BhexL, AhexU, BhexU);		
always #1 Clk=~Clk;

initial begin
Reset=0;
LoadA=1;
LoadB=1;
Execute=1;
Din=8'h33;
F=3'b010;
R=2'b010;

#2 Reset = 1;
#2 LoadA = 0;
#2 LoadA = 1;
#2 LoadB = 0;
   Din = 8'h55;
#2 LoadB = 1;
   Din = 8'h00;

#2 Execute = 0;

#22 Execute = 1;
	 ans_1a = (8'h33 ^ 8'h55);
    if (Aval != ans_1a)
		ErrorCnt++;
    if (Bval != 8'h55)
		ErrorCnt++;
	  F = 3'b110;
     R = 2'b01;

#2 Execute = 0;
#2 Execute = 1;

#22 Execute = 0;
	if (Aval != ans_1a)
		ErrorCnt++;
	ans_2b = ~(ans_1a ^ 8'h55);
	if (Bval != ans_2b)
		ErrorCnt++;
	R = 2'b11;
#2 Execute = 1;

#22 if (Aval != ans_2b)
		ErrorCnt++;
	 if (Bval != ans_1a)
		ErrorCnt++;
//end//change

if (ErrorCnt == 0)
	$display("Sucess");
else 
	$display("Try again");
end

endmodule		