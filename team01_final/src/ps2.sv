module ps2_keyboard_driver(clk,rst_n,ps2k_clk,ps2k_data,sm_bit,sm_seg,ps2_state);
 
input clk;		
input rst_n;	
input ps2k_clk;	
input ps2k_data;		
wire [7:0] ps2_byte;	// 1byte key value 
output ps2_state;		//if pressed? 1 for pressed
output reg [1:0] sm_bit='b01;
//output reg [7:0]sm_seg;
output reg [3:0]sm_seg;

//------------------------------------------
reg ps2k_clk_r0,ps2k_clk_r1,ps2k_clk_r2;	
wire neg_ps2k_clk;	

parameter F_C = 4'b0010;    //2
parameter F_CC = 4'b0011;   //3
parameter R_C = 4'b0100;    //4
parameter R_CC = 4'b0101;   //5
parameter L_C = 4'b0110;    //6
parameter L_CC = 4'b0111;   //7
parameter T_C = 4'b1000;    //8
parameter T_CC = 4'b1001;   //9
parameter B_C = 4'b1010;    //A
parameter B_CC = 4'b1011;   //B
parameter D_C = 4'b1100;    //C
parameter D_CC = 4'b1101;   //D


always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
			ps2k_clk_r0 <= 1'b0;
			ps2k_clk_r1 <= 1'b0;
			ps2k_clk_r2 <= 1'b0;
		end
	else begin								
			ps2k_clk_r0 <= ps2k_clk;
			ps2k_clk_r1 <= ps2k_clk_r0;
			ps2k_clk_r2 <= ps2k_clk_r1;
		end
end
 
assign neg_ps2k_clk = ~ps2k_clk_r1 & ps2k_clk_r2;	
 

reg[7:0] ps2_byte_r;		
reg[7:0] temp_data;			
reg[3:0] num;				
 
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
			num <= 4'd0;
			temp_data <= 8'd0;
		end
	else if(neg_ps2k_clk) begin	
			case (num)
			
				4'd0:	num <= num+1'b1;
				4'd1:	begin
							num <= num+1'b1;
							temp_data[0] <= ps2k_data;	//bit0
						end
				4'd2:	begin
							num <= num+1'b1;
							temp_data[1] <= ps2k_data;	//bit1
						end
				4'd3:	begin
							num <= num+1'b1;
							temp_data[2] <= ps2k_data;	//bit2
						end
				4'd4:	begin
							num <= num+1'b1;
							temp_data[3] <= ps2k_data;	//bit3
						end
				4'd5:	begin
							num <= num+1'b1;
							temp_data[4] <= ps2k_data;	//bit4
						end
				4'd6:	begin
							num <= num+1'b1;
							temp_data[5] <= ps2k_data;	//bit5
						end
				4'd7:	begin
							num <= num+1'b1;
							temp_data[6] <= ps2k_data;	//bit6
						end
				4'd8:	begin
							num <= num+1'b1;
							temp_data[7] <= ps2k_data;	//bit7
						end
				4'd9:	begin
							num <= num+1'b1;	
						end
				4'd10: begin
							num <= 4'd0;	
						end
				default: ;
				endcase
		end	
end
 
reg key_f0;		
reg ps2_state_r;	

always @ (posedge clk or negedge rst_n) begin	
	if(!rst_n) begin
			key_f0 <= 1'b0;
			ps2_state_r <= 1'b0;
		end
	else if(num==4'd10) 
			begin	
				if(temp_data == 8'hf0) key_f0 <= 1'b1;
				else begin
					if(!key_f0) begin	
									ps2_state_r <= 1'b1;
									ps2_byte_r <= temp_data;	
					end
					else begin
									ps2_state_r <= 1'b0;
									key_f0 <= 1'b0;
					end
				end
			end
    end
reg[7:0] ps2_asci;	
 
always @ (ps2_byte_r) begin
	case (ps2_byte_r)		
        8'h16: sm_seg = F_C;	    // 1 -> F_C
        8'h1e: sm_seg = F_CC;	    // 2 -> F_CC
        8'h26: sm_seg = R_C;  	    // 3 -> R_C
        8'h25: sm_seg = R_CC;       // 4 -> R_CC
        8'h2e: sm_seg = L_C;        // 5 -> L_C
        8'h36: sm_seg = L_CC;       // 6 -> L_CC
        8'h3d: sm_seg = T_C;        // 7 -> T_C
        8'h3e: sm_seg = T_CC;       // 8 -> T_CC
        8'h46: sm_seg = B_C;        // 9 -> B_C
        8'h45: sm_seg = B_CC;       // 0 -> B_CC
        8'h4e: sm_seg = D_C;        // - -> D_C
        8'h55: sm_seg = D_CC;       // = -> D_CC
		default: sm_seg = 0;
		endcase
end
 
assign ps2_byte = ps2_asci;	 
assign ps2_state = ps2_state_r;

endmodule