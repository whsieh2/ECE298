/*module DFF ( input logic Clk, D,
				  output logic REps2);
				  
logic q1,q2;
always @ (posedge Clk) 
begin 
	REps2 = 1'b0;
	q2=q1;
	q1 = D;
	if(q1 == 1'b0 && q2 ==1'b1)
		REps2=1'b1;
end
endmodule
*/

module DFF(input Clk, D,
				output logic Q);
				
always @ (posedge Clk)
begin
	Q=D;
end
endmodule
