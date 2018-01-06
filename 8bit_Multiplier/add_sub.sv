module add_sub(input logic [7:0] A,S,output logic [8:0] Out, input logic fn, exec);
logic [8:0] OutVal; // internal out
logic [8:0] C;
logic [7:0] BB;
logic A8,BB8;
assign A8 = A[7];
assign C[0] = fn; // cin
assign BB8 = BB[7];
always_comb
begin
	if (exec)
		Out = OutVal;
	else 
		Out = {A8,A};
	if (fn)
		BB = ~S;
	else 
		BB = S;
end

/*logic Aext,Sext;
logic [7:0] Sval;
logic [8:0] C, OutVal;
assign C[0] = fn; // carry in value, can be same as fn
assign Aext = A[7];
assign Sext = Sval[7];
always_comb
begin
	case(fn)
		1'b0: Sval = S; // ADD
		1'b1: Sval = ~(S); // SUB
		default: Sval = S;
	endcase
	case(exec)
		1'b0: Out = {Aext,A}; // hold Reg A
		1'b1: Out = OutVal; // A+S
		default: Out = {Aext,A};
	endcase
end*/

// Full adder primitives
FA one(.x(A[0]), .y(BB[0]),.z(C[0]),.c(C[1]),.s(OutVal[0]));
	FA two(.x(A[1]), .y(BB[1]),.z(C[1]),.c(C[2]),.s(OutVal[1]));
	FA three(.x(A[2]), .y(BB[2]),.z(C[2]),.c(C[3]),.s(OutVal[2]));
	FA four(.x(A[3]), .y(BB[3]),.z(C[3]),.c(C[4]),.s(OutVal[3]));
	FA five(.x(A[4]), .y(BB[4]),.z(C[4]),.c(C[5]),.s(OutVal[4]));
	FA six(.x(A[5]), .y(BB[5]),.z(C[5]),.c(C[6]),.s(OutVal[5]));
	FA seven(.x(A[6]), .y(BB[6]),.z(C[6]),.c(C[7]),.s(OutVal[6]));
	FA eight(.x(A[7]), .y(BB[7]),.z(C[7]),.c(C[8]),.s(OutVal[7]));
	FA nine(.x(A8), .y(BB8),.z(C[8]),.s(OutVal[8]));
endmodule
	
		
	