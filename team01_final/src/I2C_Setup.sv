module I2cInitializer (
	input i_rst_n,
	input i_clk, 
    input [2:0] bytes_number,
    input [7:0] register_addr,
    input [6:0] device_addr,
    input [15:0] input_da,
	input i_start,
	output o_finished,
	output o_sclk,
	inout io_sdat,
    output logic ack_now
	 // you are outputing (you are not outputing only when you are "ack"ing.)
);

// TO DO: 
// Sequentially send all Initialization controls
// Each control has 24 bits and 3 acknowlege signals
// for each control : send 8 bits, set data to z to recieve acknowlege , repeat x3
// wait between each transmission

// parameters

// STATES declaration
localparam S_IDLE                = 6'd0;
localparam S_START               = 6'd1;
localparam S_ADDR_STAGE1         = 6'd2;
localparam S_ADDR_STAGE2         = 6'd3;
localparam S_READWRITEBIT1       = 6'd4;
localparam S_READWRITEBIT2       = 6'd5;
localparam S_ADDR_ACK1           = 6'd6;
localparam S_ADDR_ACK2           = 6'd7;
localparam S_ADDR_ACK3           = 6'd8;
localparam S_REG_STAGE1          = 6'd9;
localparam S_REG_STAGE2                 = 6'd10;
localparam S_REG_ACK1               = 6'd11;
localparam S_REG_ACK2               = 6'd12;
localparam S_REG_ACK3               = 6'd13;
localparam S_DATA_STAGE1                = 6'd14;
localparam S_DATA_STAGE2                = 6'd15;
localparam S_DATA_ACK1              = 6'd16;
localparam S_DATA_ACK2              = 6'd17;
localparam S_DATA_ACK3              = 6'd18;
localparam S_STOP1              = 6'd19;
localparam S_STOP2              = 6'd20;
localparam S_DONE                  =6'd21;



// register declaration
logic [5:0] state;
 // count the number of commands, 0-6
logic [2:0] bytes_counter;  //count the number of bytes sent, 0-2
logic [6:0] bits_counter; // count the number of bits sent 0-7
logic finished;         // finish signal
logic sdat, sclk;
// OUTPUT ASSIGNMENT
assign o_sclk = sclk;
assign io_sdat = (state == S_ADDR_ACK2 || state == S_ADDR_ACK3 || state == S_REG_ACK2 || state == S_REG_ACK3 || state == S_DATA_ACK2 || state == S_DATA_ACK3 )? 1'bz : sdat;
assign o_finished = finished;
//FINITE STATE MACHINE
always_ff @(posedge i_clk or negedge i_rst_n)begin
    if(!i_rst_n) begin
        sdat <= 1;
        sclk <=1;
        bytes_counter <=0;
        bits_counter <=0;
        state <= S_IDLE;
    end
    else begin
        ack_now <=0;
        case(state)
            
            S_IDLE : begin 
                sclk <=1;
                sdat <=1;
                if(i_start)begin
                    state <= S_START;
                    bytes_counter <=bytes_number;
                    bits_counter <=6;
                    finished <=0;
                    
                end
                else begin
                    state <=S_IDLE;
                    bytes_counter <=0;
                    bits_counter <=0;
                    finished <=0;
                end
            end
            S_START :begin
                state <= S_ADDR_STAGE1;
                bits_counter <= 6;
                sdat <= 0;
                sclk <=1;
            end
            S_ADDR_STAGE1: begin
                sclk <= 0;
                sdat <= device_addr[bits_counter];
                state <= S_ADDR_STAGE2;
            end
            S_ADDR_STAGE2: begin
                sclk <= 1;
                if( bits_counter >0)begin
                    state <= S_ADDR_STAGE1;
                    bits_counter <= bits_counter -1;

                end
                else begin
                    state <= S_READWRITEBIT1;
                end
             end
            S_READWRITEBIT1: begin
                sclk <= 0;
                sdat <= 0;
                state <= S_READWRITEBIT2;
            end
            S_READWRITEBIT2: begin
                sclk <= 1;
                state <= S_ADDR_ACK1;
            end
            S_ADDR_ACK1: begin
                sclk <= 0;
                sdat <= 1'bz;
                ack_now <=1;
                state <= S_ADDR_ACK2;
            end
            S_ADDR_ACK2: begin
                sclk <= 1;
                state <= S_ADDR_ACK3;
                ack_now <=1;
                bits_counter <= 7;
            end
            S_ADDR_ACK3 : begin
                sclk <= 0;
                ack_now <=0;
                if(sdat == 1'b1) begin
                    bits_counter <= 0;
                    state <= S_IDLE;
                end
                else begin
                    state <= S_REG_STAGE2;
                    sdat <= register_addr[bits_counter];
                end
            end
            S_REG_STAGE1: begin
                sdat <= register_addr[bits_counter];
                sclk <= 0;
                state <= S_REG_STAGE2;
            end
            S_REG_STAGE2: begin
                sclk <= 1;
                if (bits_counter > 0) begin
                    bits_counter <= bits_counter - 1;
                    state <= S_REG_STAGE1;
                end
                else begin
                    state <= S_REG_ACK1;
                end
            end
            S_REG_ACK1: begin
                sdat <= 1'bz;
                sclk <= 0;
                ack_now <=1;
                state <= S_REG_ACK2;
            end
            S_REG_ACK2: begin
                sclk <= 1;
                state <= S_REG_ACK3;
                bits_counter <= 7;
                ack_now <=1;
            end
            S_REG_ACK3    : begin
                ack_now <=0;
                sclk <= 0;
                if(sdat == 1'b1) begin
                    state <= S_IDLE;
                    bits_counter <= 0;
                end
                else if (bytes_counter != 0) begin
                    bytes_counter <= bytes_counter - 1;
                    state <= S_DATA_STAGE2;
                    sdat <= input_da[(bytes_counter<<<3)-1];
                end
                else begin
                    state <= S_STOP1;
                    sdat <= 0;
                end
            end 
            S_DATA_STAGE1 : begin
                sdat <= input_da[(bytes_counter<<<3)+bits_counter];
                sclk <= 0;
                state <= S_DATA_STAGE2;
            end 
            S_DATA_STAGE2 : begin
                sclk <= 1;
                if (bits_counter > 0) begin
                    bits_counter <= bits_counter - 1;
                    state <= S_DATA_STAGE1;
                end
                else begin
                    state <= S_REG_ACK1;
                end
            end 
            S_STOP1       : begin
                sclk <= 1; 
                sdat <= 0;
                state <=S_STOP2;
            end 
            S_STOP2       : begin
                sdat <= 1;
                finished <=1;
                state <= S_DONE;
            end 
            S_DONE: begin
                state <=S_DONE;
                bytes_counter <=0;
                bits_counter <=0;
                finished <=1;
            end

    endcase
    end
end 
endmodule