module control(input logic ClearA_LoadB, Run, Reset, Clk, M, counter_msb,output logic shift, add,sub, Clr_Ld, counter_r);
//NOTES:
// add,sub goto adder_execution flag, if either are high, adder executes
// add, sub must also goto LOAD of register A to parallel load data from adder
// 
enum logic [5:0] {W, A,B,C,D,E,F,G,H,I,J,K,L,Ms,N,O,P,Q} curr_state, next_state;

//assign Clr_Ld = ClearA_LoadB;
always @ (posedge Clk or posedge Run or posedge Reset or posedge ClearA_LoadB) 
begin
	// external interrupt
	if (Reset)
		curr_state = W;
	else
		curr_state = next_state;
		
	if (Run)
		counter_r = 1'b1; // reset debouncer
end
	
always_comb
begin
   // state transitions
	next_state = curr_state;
	unique case (curr_state)
		W : if (Run)
					next_state = A;
		A : next_state = B;
		B : next_state = C;
		C : next_state = D;
		D : next_state = E;
		E : next_state = F;
		F : next_state = G;
		G : next_state = H;
		H : next_state = I;
		I : next_state = J;
		J : next_state = K;
		K : next_state = L;
		L : next_state = Ms;
		Ms : next_state = N;
		N : next_state = O;
		O : next_state = P;
		P : next_state = Q;
		Q : if (~Run)
				next_state = W;
	endcase
end		

always @ (Run or curr_state)
begin
	case (curr_state)
	W: // handle clear and load
		begin
			if (ClearA_LoadB)
				Clr_Ld = 1'b1;
		end
	A: // A = A + S if M=1
		begin
		if (M)
			begin
			add = 1'b1;
			sub = 1'b0;
			shift = 1'b0;
			end
		else
			begin
			add = 1'b0;
			sub = 1'b0;
			shift = 1'b0;
			end
		end
	B: //shift XAB 1
		begin
			add = 1'b0;
			sub = 1'b0;
			shift = 1'b1;
		end
	C: // A = A + S if M=1
		begin
		if (M)
			begin
			add = 1'b1;
			sub = 1'b0;
			shift = 1'b0;
			end
		else
			begin
			add = 1'b0;
			sub = 1'b0;
			shift = 1'b0;
			end
		end
	D: //shift XAB 2
		begin
			add = 1'b0;
			sub = 1'b0;
			shift = 1'b1;
		end
	E: // A = A + S if M=1
		begin
		if (M)
			begin
			add = 1'b1;
			sub = 1'b0;
			shift = 1'b0;
			end
		else
			begin
			add = 1'b0;
			sub = 1'b0;
			shift = 1'b0;
			end
		end
	F: //shift XAB 3
		begin
			add = 1'b0;
			sub = 1'b0;
			shift = 1'b1;
		end
	G: // A = A + S if M=1
		begin
		if (M)
			begin
			add = 1'b1;
			sub = 1'b0;
			shift = 1'b0;
			end
		else
			begin
			add = 1'b0;
			sub = 1'b0;
			shift = 1'b0;
			end
		end
	H: //shift XAB 4
		begin
			add = 1'b0;
			sub = 1'b0;
			shift = 1'b1;
		end
	I: // A = A + S if M=1
		begin
		if (M)
			begin
			add = 1'b1;
			sub = 1'b0;
			shift = 1'b0;
			end
		else
			begin
			add = 1'b0;
			sub = 1'b0;
			shift = 1'b0;
			end
		end
	J: //shift XAB 5
		begin
			add = 1'b0;
			sub = 1'b0;
			shift = 1'b1;
		end
	K: // A = A + S if M=1
		begin
		if (M)
			begin
			add = 1'b1;
			sub = 1'b0;
			shift = 1'b0;
			end
		else
			begin
			add = 1'b0;
			sub = 1'b0;
			shift = 1'b0;
			end
		end
	L: //shift XAB 6
		begin
			add = 1'b0;
			sub = 1'b0;
			shift = 1'b1;
		end
	Ms: // A = A + S if M=1
		begin
		if (M)
			begin
			add = 1'b1;
			sub = 1'b0;
			shift = 1'b0;
			end
		else
			begin
			add = 1'b0;
			sub = 1'b0;
			shift = 1'b0;
			end
		end
	N: //shift XAB 7
		begin
			add = 1'b0;
			sub = 1'b0;
			shift = 1'b1;
		end
	O: // A = A - S if M=1 || LAST ARITHMETIC STEP
		begin
		if (M)
			begin
			add = 1'b0;
			sub = 1'b1;
			shift = 1'b0;
			end
		else
			begin
			add = 1'b0;
			sub = 1'b0;
			shift = 1'b0;
			end
		end
	P: //shift XAB 8 STOP EXECUTION, GOTO FINAL STATE Q
		begin
			add = 1'b0;
			sub = 1'b0;
			shift = 1'b1;
		end
			
	default: // also case Q
		begin
			add = 1'b0;
			sub = 1'b0;
			shift = 1'b0;
		end
	endcase
end
endmodule