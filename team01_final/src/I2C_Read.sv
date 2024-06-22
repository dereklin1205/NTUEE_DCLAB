module I2C_READ_DATA(
    input i_clk,
    input i_start,
    input i_rst_n,
    input [6:0] device_addr,
    input [7:0] register_addr,
    input [2:0] bytes_number, 
    output logic [47:0] rgb_color,
    output o_sclk,
    output o_done,
    inout io_sdat,
    output logic ack_now
);

// parameter
    localparam S_IDLE                = 6'd0;
    localparam S_START1              = 6'd1;

    localparam S_ADDR_STAGE1         = 6'd2;
    localparam S_ADDR_STAGE2         = 6'd3;
    localparam S_READWRITEBIT1       = 6'd4;
    localparam S_READWRITEBIT2       = 6'd5;
    localparam S_ADDR_ACK1           = 6'd6;
    localparam S_ADDR_ACK2           = 6'd7;
    localparam S_ADDR_ACK3           = 6'd8;

    localparam S_REG_STAGE1          = 6'd9;
    localparam S_REG_STAGE2          = 6'd10;
    localparam S_REG_ACK1            = 6'd11;
    localparam S_REG_ACK2            = 6'd12;
    localparam S_REG_ACK3            = 6'd13;
    localparam S_REG_STOP1           = 6'd14;
    localparam S_REG_STOP2           = 6'd15;

    localparam S_START2              = 6'd16;
    localparam S_ADDR_STAGE3         = 6'd17;
    localparam S_ADDR_STAGE4         = 6'd18;
    localparam S_READWRITEBIT3       = 6'd19;
    localparam S_READWRITEBIT4       = 6'd20;
    localparam S_ADDR_ACK4           = 6'd21;
    localparam S_ADDR_ACK5           = 6'd22;
    localparam S_ADDR_ACK6           = 6'd23;

    localparam S_DATA_STAGE1         = 6'd24;
    localparam S_DATA_STAGE2         = 6'd25;
    localparam S_DATA_ACK1           = 6'd26;
    localparam S_DATA_ACK2           = 6'd27;
    localparam S_NACK                = 6'd28;
    localparam S_DATA_STOP1          = 6'd29;
    localparam S_DATA_STOP2          = 6'd30;
    localparam S_DATA_STOP3          = 6'd31;

logic [5:0] state;
logic [7:0] bits_counter;
logic [2:0] bytes_counter;
logic done, sdat, sclk;
assign o_sclk = sclk;
assign io_sdat = (state == S_ADDR_ACK2||state == S_ADDR_ACK3||state == S_REG_ACK2 || state == S_REG_ACK3 ||state == S_ADDR_ACK5 || state == S_ADDR_ACK6 || state == S_DATA_STAGE1 || state == S_DATA_STAGE2)? 1'bz : sdat;
assign o_done = done;

always_ff @( posedge i_clk or negedge i_rst_n ) begin
    if(!i_rst_n) begin
        state <= S_IDLE;
        bits_counter <= 0;
        bytes_counter <=0;
        done <= 0;
        sdat<= 1;
        sclk <=1;
        rgb_color <= 48'd0;
    end
    else begin
        case (state)
            S_IDLE          : begin
                if (i_start)begin
                    done <= 0;
                    state <= S_START1;
                    bits_counter <= 0;
                    ack_now<=0;
                    bytes_counter <= bytes_number;
                end
                else begin
                ack_now <=0;
                bits_counter <= 0;
                sdat <= 1;
                done <=1;
                sclk <= 1;
                bytes_counter <= 0;
                end

            end
            S_START1        : begin
                sdat <= 0;
                sclk <= 1;
                bytes_counter <= bytes_number;
                state <= S_ADDR_STAGE1;
                bits_counter <= 6;
            end
            S_ADDR_STAGE1   : begin
                sclk <= 0;
                sdat <= device_addr[bits_counter];
                state <= S_ADDR_STAGE2;
            end
            S_ADDR_STAGE2   : begin
                sclk <= 1;
                if (bits_counter >= 1) begin
                    bits_counter<= bits_counter - 1;
                    state <= S_ADDR_STAGE1;
                end
                else begin
                    sdat <= 0;
                    state <= S_READWRITEBIT1;
                end
            end
            S_READWRITEBIT1 : begin
                sclk <= 0;
                sdat <= 0;
                state <= S_READWRITEBIT2;
            end
            S_READWRITEBIT2 : begin
                sclk <= 1;
                state <= S_ADDR_ACK1;
            end
            S_ADDR_ACK1     : begin
                sclk <= 0;
                sdat <= 1'bz;
                ack_now <=1;
                state <= S_ADDR_ACK2;
            end
            S_ADDR_ACK2     : begin
                sclk <= 1;
                ack_now <=1;
                bits_counter <= 7;
                state <= S_ADDR_ACK3;
            end
            S_ADDR_ACK3     : begin
                sclk <= 0;
                ack_now <=0;
                if (sdat == 1'b1)begin
                    bits_counter <= 0;
                    state <= S_IDLE;
                end else begin
                    state <= S_REG_STAGE2;
                    sdat <= register_addr[bits_counter];              
                end 
            end
            S_REG_STAGE1    : begin
                sclk <= 0;
                sdat <= register_addr[bits_counter];
                state <= S_REG_STAGE2;
            end
            S_REG_STAGE2    : begin
                sclk <= 1;
                if (bits_counter > 0) begin
                    bits_counter <= bits_counter - 1;
                    state <= S_REG_STAGE1;
                end else begin
                    state <= S_REG_ACK1;
                end
            end
            S_REG_ACK1      : begin
                sclk <= 0;
                ack_now <=1;
                sdat <= 1'bz;
                state <= S_REG_ACK2;
            end
            S_REG_ACK2      : begin
                sclk <= 1;
                ack_now <=1;
                state <= S_REG_ACK3;
            end
            S_REG_ACK3      : begin
                sclk <= 0;
                ack_now <=0;
                if (sdat == 1'b1)begin
                    state <= S_IDLE;
                    bits_counter <= 0;
                end else begin
                    state <= S_REG_STOP1;
                    sdat <= 0;
                    bits_counter <= 0;
                end 
            end
            S_REG_STOP1     : begin
                sclk <= 1;
                state <= S_REG_STOP2;
            end
            S_REG_STOP2     : begin
                sdat <= 1;
                state <= S_START2;
            end
            S_START2        : begin
                sdat <= 0;
                state <= S_ADDR_STAGE3;
                bits_counter <= 6;
            end
            S_ADDR_STAGE3   : begin
                sclk <= 0;
                sdat <= device_addr[bits_counter];
                state <= S_ADDR_STAGE4;
            end
            S_ADDR_STAGE4   : begin
                sclk <=1;
                if (bits_counter >= 1) begin
                    bits_counter <= bits_counter -1;
                    state <= S_ADDR_STAGE3;
                end else begin
                    state <= S_READWRITEBIT3;
                end
            end
            S_READWRITEBIT3 : begin
                sclk <= 0;
                sdat <= 1;
                state <= S_READWRITEBIT4;
            end
            S_READWRITEBIT4 : begin
                sclk <= 1;
                state <= S_ADDR_ACK4;
            end
            S_ADDR_ACK4     : begin
                sclk <= 0;
                ack_now <=1;
                sdat <= 1'bz;
                state <= S_ADDR_ACK5;
            end
            S_ADDR_ACK5     : begin
                sclk <= 1;
                ack_now <=1;
                bits_counter <= 7;
                state <= S_ADDR_ACK6;
            end
            S_ADDR_ACK6     : begin
                sclk <= 0;
                ack_now <=0;
                if (sdat == 1'b1)begin
                    bits_counter <= 0;
                    state <= S_IDLE;
                end else begin
                    state <= S_DATA_STAGE1;
                    sdat <= 1'bz;              
                end 
            end
            S_DATA_STAGE1   : begin
                sclk <= 1;
                state <= S_DATA_STAGE2;
            end
            S_DATA_STAGE2   : begin
                sclk <= 0;
                rgb_color[(bytes_counter<<3) + bits_counter] <= io_sdat;
                if (bits_counter > 0) begin
                    state <= S_DATA_STAGE1;
                    bits_counter <= bits_counter - 1;
                    
                end
                else if (bits_counter == 0 && bytes_counter == 0) begin
                    state <= S_NACK;
                    ack_now <=1;
                    sdat <= 1;
                end
                else begin
                    state <= S_DATA_ACK1;
                    ack_now <=1;
                    bytes_counter <= bytes_counter - 1;
                    sdat <= 0;
                end
            end
            S_DATA_ACK1     : begin
                sclk <= 1;
                ack_now <=1;
                state <= S_DATA_ACK2;
                bits_counter <= 7;
            end
            S_DATA_ACK2     : begin
                sclk <= 0;
                ack_now <=0;
                state <= S_DATA_STAGE1;
                sdat <= 1'bz;
            end
            S_NACK          : begin
                sclk <= 1;
                ack_now <=1;
                state <= S_DATA_STOP1;
                bits_counter <= 0;
            end
            S_DATA_STOP1    : begin
                sclk <= 0;
                ack_now <=0;
                sdat <= 0;
                state <= S_DATA_STOP2;
            end
            S_DATA_STOP2    : begin
                sclk <= 1;
                sdat <= 0;
                state <= S_DATA_STOP3;
            end
            S_DATA_STOP3    : begin
                sdat <= 1;
                state <= S_IDLE;
                done <= 1;
            end
        endcase
    end
end
endmodule