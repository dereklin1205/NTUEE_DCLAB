module FiveDecoder (
    input i_clk,
	input        [2:0] i_hex,
	output logic [6:0] o_seven_1st,
	output logic [6:0] o_seven_2nd,
    output logic [6:0] o_seven_3rd,
    output logic [6:0] o_seven_4th,
    output logic [6:0] o_seven_5th
);
logic [6:0] seven_1st_r, seven_1st_w;
logic [6:0] seven_2nd_r, seven_2nd_w;
logic [6:0] seven_3rd_r, seven_3rd_w;
logic [6:0] seven_4th_r, seven_4th_w;
logic [6:0] seven_5th_r, seven_5th_w;
/* The layout of seven segment display, 1: dark
 *    00
 *   5  1
 *    66
 *   4  2
 *    33
 */
parameter D0 = 7'b1000000;
parameter D1 = 7'b1111001;
parameter D2 = 7'b0100100;
parameter D3 = 7'b0110000;
parameter D4 = 7'b0011001;
parameter D5 = 7'b0010010;
parameter D6 = 7'b0000010;
parameter D7 = 7'b1011000;
parameter D8 = 7'b0000000;
parameter D9 = 7'b0010000;
parameter A  = 7'b0001000;
parameter B  = 7'b0000011;
parameter C  = 7'b1000110;
parameter D  = 7'b0100001;
parameter E  = 7'b0000110;
parameter H  = 7'b0001001;
parameter F  = 7'b0001110;
parameter L  = 7'b1000111;
parameter N  = 7'b0101011;
parameter P  = 7'b0001100;
parameter R  = 7'b1001110;
parameter S  = 7'b0010010;
parameter U  = 7'b1000001;
parameter Y  = 7'b0011001;
// parameter NE = 7'b0111111;
parameter DK = 7'b1111111;
assign o_seven_1st = seven_1st_r;
assign o_seven_2nd = seven_2nd_r;
assign o_seven_3rd = seven_3rd_r;
assign o_seven_4th = seven_4th_r;
assign o_seven_5th = seven_5th_r;
//i_hex =0: IDLE  
//i_hex = 1 : PLAY
//i_hex = 2 : REC
//i_hex = 3 : pause
always_comb begin
    case(i_hex)
        3'd0: begin seven_5th_w = D1; seven_4th_w = D; seven_3rd_w = L; seven_2nd_w = E; seven_1st_w = DK; end
        3'd1: begin seven_5th_w = P; seven_4th_w = L; seven_3rd_w = A; seven_2nd_w = Y; seven_1st_w = DK; end
        3'd2: begin seven_5th_w = R; seven_4th_w = E; seven_3rd_w = C; seven_2nd_w = DK; seven_1st_w = DK; end
        3'd3: begin seven_5th_w = P; seven_4th_w = A; seven_3rd_w = U; seven_2nd_w = S; seven_1st_w = E; end
        default: begin  seven_5th_w = DK; seven_4th_w = DK; seven_3rd_w = DK; seven_2nd_w = DK; seven_1st_w = DK; end
    endcase
end
always_ff @(posedge i_clk)begin
    seven_1st_r <= seven_1st_w;
    seven_2nd_r <= seven_2nd_w;
    seven_3rd_r <= seven_3rd_w;
    seven_4th_r <= seven_4th_w;
    seven_5th_r <= seven_5th_w;
end









endmodule