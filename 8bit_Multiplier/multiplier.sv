module multiplier(input logic [7:0] S,
						input logic Clk, Reset, Run, ClearA_LoadB,
						output logic [6:0] AhexU, AhexL, BhexU, BhexL,
						output logic [7:0] Aval, Bval,
						output logic X);

logic M_val, shift_xab,add,sub, adder_execute, clr_ld, shiftOutA, shiftOutX, clearA;
logic Reset_h, Run_h,ClearA_LoadB_h, Counter_clear, control_counter_clear;
logic [8:0] Adata;
logic [10:0] count_val;
assign adder_execute = add|sub;
assign clearA = ~ClearA_LoadB | ~Reset;
assign Counter_clear = ~Reset | control_counter_clear;
assign X = shiftOutX;
always_comb
begin
	Reset_h = ~Reset;
	Run_h = ~Run;
	ClearA_LoadB_h = ~ClearA_LoadB;
end
//modules

//counter counter1(.Clk(Clk),
					//  .Reset(Counter_clear),
					  //.count(count_val)
					  //);

control control_unit(//.counter_msb(count_val[19]),
							//.counter_r(counter_r),
							.Clk(Clk),
							.Run(Run_h),
							.ClearA_LoadB(ClearA_LoadB_h),
							.Reset(Reset_h),
							.M(M_val),
							.shift(shift_xab),
							.add(add),
							.sub(sub),
							.Clr_Ld(clr_ld),
							.counter_msb(count_val[10])
							//.clear_counter(control_counter_clear)
							);
add_sub nine_bit(.A(Aval),
					  .S(S),
					  .fn(sub),
					  .exec(adder_execute),
					  .Out(Adata));
Dreg X_reg(.Clk(Clk),
       .Load(adder_execute), // parallel load when adder works
		 .Reset(Reset_h),
		 .D(Adata[8]),
		 .Q(shiftOutX));

reg_8 A(.Clk(Clk),
		  .Reset(clearA),
		  .Shift_In(shiftOutX),
		  .Load(adder_execute), // parallel load when adder works
		  .Shift_En(shift_xab),
		  .D(Adata[7:0]),
		  .Shift_Out(shiftOutA),
		  .Data_out(Aval));
		  
reg_8 B(.Clk(Clk),
		  .Reset(Reset_h),
		  .Shift_In(shiftOutA),
		  .Load(ClearA_LoadB_h),
		  .Shift_En(shift_xab),
		  .D(S),
		  .Shift_Out(M_val),
		  .Data_out(Bval));
//displays
HexDriver HexAL(.In0(Aval[3:0]), .Out0(AhexL));
HexDriver HexAU(.In0(Aval[7:4]), .Out0(AhexU));
HexDriver HexBL(.In0(Bval[3:0]), .Out0(BhexL));
HexDriver HexBU(.In0(Bval[7:4]), . Out0(BhexU));
endmodule
							