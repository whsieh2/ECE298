module small_lc3(input logic Clk, Reset, Run, Continue,
						input logic [15:0] S,
					output [11:0] LED, 
					output logic [6:0] HEX0,HEX1,HEX2,HEX3,
					output logic CE, UB, LB, OE, WE,
					output logic [17:0] ADDR,
					inout[15:0] Data
					//inout[15:0] busline
					);
						// top level
//logic [3:0] IR0, IR1, IR2, IR3;	
logic[15:0] IRout;				
tri [15:0] busline;
//wire[15:0] mem;
logic [3:0] Hex0, Hex1, Hex2, Hex3;
logic Reset_h, Run_h, Continue_h;
always_comb
begin
	Reset_h = ~Reset; 
	Run_h = ~Run;
	Continue_h = ~Continue;
end


test_memory testmem(.*, .Reset(Reset_h),.I_O(Data), .A(ADDR)); //remove for DE2 board

fetch fetch_one(.*, .ADDR(ADDR),.Reset(Reset_h), .Continue(Continue_h), .Run(Run_h), .bus(busline)); //use your own hexdriver 
	
Mem2IO Mem2IO_one ( 	.*, .Reset(Reset_h), .A(ADDR), .Switches(S), .Data_CPU(busline), .Data_Mem(Data), .hex0(Hex0), .hex1(Hex1), .hex2(Hex2), .hex3(Hex3));
//removed for sims


HexDriver numba_1(.In0(Hex0),.Out0(HEX0));   //used for part I of the lab
HexDriver numba_2(.In0(Hex1),.Out0(HEX1));
HexDriver numba_3(.In0(Hex2),.Out0(HEX2));
HexDriver numba_14(.In0(Hex3),.Out0(HEX3));





		
/*HexDriver Hex0(.In0(IRout[3:0]),.Out0(HEX0));   //used for part I of the lab
HexDriver Hex1(.In0(IRout[7:4]),.Out0(HEX1));
HexDriver Hex2(.In0(IRout[11:8]),.Out0(HEX2));
HexDriver Hex3(.In0(IRout[15:12]),.Out0(HEX3));*/


endmodule