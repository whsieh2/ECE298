module direction(input					Clk,
					  input  logic [7:0] keyCode, sR2data,
					  output logic up, left, down, right);

	always_ff @ (posedge Clk)
		begin
			if (sR2data != 8'hf0)
				begin
					if (keyCode == 8'h1d)
						begin
							up    <= 1'b1;
							left  <= 1'b0;
							down  <= 1'b0;
							right <= 1'b0;
						end
					else if (keyCode == 8'h1c)
						begin
							up    <= 1'b0;
							left  <= 1'b1;
							down  <= 1'b0;
							right <= 1'b0;
						end
					else if (keyCode == 8'h1b)
						begin
							up    <= 1'b0;
							left  <= 1'b0;
							down  <= 1'b1;
							right <= 1'b0;
						end
					else if (keyCode == 8'h23)
						begin
							up    <= 1'b0;
							left  <= 1'b0;
							down  <= 1'b0;
							right <= 1'b1;
						end
					else 
						begin
							up    <= 1'b0;
							left  <= 1'b0;
							down  <= 1'b0;
							right <= 1'b0;
						end
				end
		end
		
endmodule