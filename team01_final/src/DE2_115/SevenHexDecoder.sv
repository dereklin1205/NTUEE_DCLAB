module SevenHexDecoder (
	input        [3:0] i_hex,
	output logic [6:0] o_seven_1,
	output logic [6:0] o_seven_2,
	output logic [6:0] o_seven_3
);

/* The layout of seven segment display, 1: dark
 *    00
 *   5  1
 *    66
 *   4  2
 *    33
 */
parameter R = 7'b1001110;
parameter L = 7'b1000111;
parameter C = 7'b1000110;
parameter F = 7'b0001110;
parameter T = 7'b0000111;
parameter B = 7'b0000000;
parameter D = 7'b1000000;

always_comb begin
	o_seven_2 = C; 
	
	if(i_hex[3]) begin
		o_seven_1 = C;
	end else begin
		o_seven_1 = 7'b1111111;
	end

	
	case(i_hex[2:0])
		1: begin 
			o_seven_3 = T;
		end
		2: begin
			o_seven_3 = F;
		end
		3: begin
			o_seven_3 = R;
		end
		4: begin
			o_seven_3 = B;
		end
		5: begin
			o_seven_3 = L;
		end
		6: begin
			o_seven_3 = D;
		end
		default: begin
			o_seven_3 = 7'b1111111;
		end
	endcase
end
	

endmodule
