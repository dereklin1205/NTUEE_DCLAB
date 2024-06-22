module I2Csensor (
    input i_clk,
    input i_rst_n,
    input i_start,
    output [2:0] o_rgb_color,  // The color
    output o_done,
    output o_sclk,
    output o_ack_write,
    output o_ack_read,
    input i_ack, // motor done
    inout io_sdat
);

localparam S_IDLE = 4'd0;
localparam S_SETTING = 4'd1;  //enable write to set the module
localparam S_WAIT_FOR_MOTOR = 4'd2;             //wait motor acknowledge
localparam S_WAIT_FOR_REQUIRE = 4'd3; // wait for the motor requirement for color sensor
localparam S_READ_FLAGS = 4'd4;                 //read flags value[1] to check if module finish reading the rgb
localparam S_READ_FLAGS_FAILED = 4'd5;          //if failed, redo it
localparam S_READ_FLAGS_FAILED_WAIT = 4'd6;      // wait for Reader to pull down done signal
localparam S_WAIT_SENSOR = 4'd7;                // wait sensor to pull down done signal
localparam S_WAIT_WAIT_SENSOR = 4'd8;
localparam S_SENSOR    = 4'd9;                  // wait for done signal of sensor

localparam S_TRANSLATE = 4'd10;                   // Trnaslate rgb value [47:0] to color [R,W,Y,O,R,B]

localparam DEVICE_ADDR = 7'h44;
localparam CONFIG_1 = 8'b00001101;
localparam CONFIG_2 = 8'b00111111;
localparam CONFIG1_ADDR =8'h01 ;
localparam CONFIG2_ADDR =8'h02;
localparam STATUS_FLAGS_ADDR = 8'h08;
localparam GREEN_LOW = 8'h09;
localparam GREEN_HIGH = 8'h0A;
localparam RED_LOW = 8'h0B;
localparam RED_HIGH = 8'h0C;
localparam BLUE_LOW = 8'h0D;
localparam BLUE_HIGH = 8'h0E;

logic [2:0] bytes_number_r, bytes_number_w;
logic [3:0] state_r, state_w; // read rgb value     rgbvalue (green low, green high, red low, red high, blue low, blue high)
logic write_done, read_done;
logic done_r, done_w;
logic [7:0] register_addr_r, register_addr_w;
logic [2:0] rgb_color_r, rgb_color_w; // color
logic [15:0] write_data_r, write_data_w;
logic writer_start_r, writer_start_w;
logic write_sclk, read_sclk;
logic [47:0] rgb_value;
logic read_start_r, read_start_w;
logic translate_start_r, translate_start_w;
logic translate_finish;
wire io_sdat_read;
wire io_sdat_write;
//assignment
assign o_rgb_color = rgb_color_r;
assign o_done = done_r;
assign o_sclk = (state_r == S_SETTING) ? write_sclk : read_sclk;
assign io_sdat_read = (state_r == S_SETTING || state_r == S_IDLE || o_ack_read) ? 1'bz : io_sdat;
assign io_sdat = (state_r == S_SETTING || state_r == S_IDLE) ? io_sdat_write : ((o_ack_read) ? io_sdat_read : 1'bz);

//states like WAIT_SENSOR and GET_FALGS_FAILED are meant to wait a cycle until output of read module pull the done signal down
//since the start signal is pull high next cycle and the done signal will be pull down next next cycle.
always_comb begin
    state_w = state_r;
    done_w = done_r;
    register_addr_w = register_addr_r;
    rgb_color_w = rgb_color_r;
    write_data_w = write_data_r;
    writer_start_w = writer_start_r;
    bytes_number_w = bytes_number_r;
    translate_start_w = translate_start_r;
    read_start_w = read_start_r;
    writer_start_w = writer_start_r;
    case (state_r)
        S_IDLE: begin   //reset then redo setting
            state_w = S_SETTING;
            writer_start_w = 1;
            bytes_number_w = 3'd2;
            register_addr_w = CONFIG1_ADDR;
            write_data_w = 16'b0000110100111111;
        end
        S_SETTING: begin
            writer_start_w = 0;
            if(write_done)begin
                state_w = S_WAIT_FOR_REQUIRE;
                bytes_number_w = 0;
                read_start_w = 0;
            end else begin
                state_w = state_r;
            end
        end 
        S_WAIT_FOR_MOTOR:begin
                if(i_ack) begin
                    state_w = S_WAIT_FOR_REQUIRE;
                    done_w = 0;
                end
                else begin
                    state_w = state_r;
                    done_w  = done_r;
                end
            end
        S_WAIT_FOR_REQUIRE : begin
            if(i_start)begin
                read_start_w = 1;
                state_w = S_READ_FLAGS_FAILED;
                register_addr_w = STATUS_FLAGS_ADDR;
                bytes_number_w = 0;
            end
            else begin
                read_start_w = 0;
                state_w = state_r;
                bytes_number_w = 0;
            end
        end
        S_READ_FLAGS : begin
            read_start_w = 0;
            if(read_done) begin
                if(rgb_value[1]) begin //complete conversion
                    state_w = S_WAIT_SENSOR;
                    register_addr_w = GREEN_LOW;
                    read_start_w = 1;
                    bytes_number_w = 5;
                end
                else begin
                    read_start_w = 1;
                    register_addr_w = STATUS_FLAGS_ADDR;
                    bytes_number_w = 0;
                    state_w = S_READ_FLAGS_FAILED;
                end
            end else begin
                state_w = state_r;
            end
        end

        S_READ_FLAGS_FAILED : begin
            state_w = S_READ_FLAGS_FAILED_WAIT;
            read_start_w = 5;
        end
        S_READ_FLAGS_FAILED_WAIT:begin
            state_w = S_READ_FLAGS;
        end
        S_WAIT_SENSOR: begin
            state_w = S_WAIT_WAIT_SENSOR;
            read_start_w = 0;
        end
        S_WAIT_WAIT_SENSOR : begin
            state_w = S_SENSOR;
        end
        S_SENSOR : begin
            if(read_done) begin
                state_w = S_TRANSLATE;
                translate_start_w = 1;
            end
            else begin
                state_w = state_r;
            end
        end
        S_TRANSLATE : begin
            state_w = S_WAIT_FOR_MOTOR;
            rgb_color_w = 2;
            done_w = 1;
            
        end

        
    endcase
    
end

I2cInitializer writer(
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
    .bytes_number(bytes_number_r),
    .device_addr(DEVICE_ADDR),
    .register_addr(register_addr_r),
    .input_da(write_data_r),
    .i_start(writer_start_r),
    .o_finished(write_done),
    .o_sclk(write_sclk),
    .ack_now(o_ack_write),
    .io_sdat(io_sdat_write)
);

I2C_READ_DATA reader(
    .i_clk(i_clk),
    .i_start(read_start_r),
    .i_rst_n(i_rst_n),
    .device_addr(DEVICE_ADDR),
    .register_addr(register_addr_r),
    .bytes_number(bytes_number_r), 
    .rgb_color(rgb_value),
    .o_sclk(read_sclk),
    .o_done(read_done),
    .io_sdat(io_sdat_read),   //sdat may occur error
    .ack_now(o_ack_read)
);

always_ff @(posedge i_clk or negedge i_rst_n)begin
    if(!i_rst_n)begin
        state_r <= S_IDLE;
        bytes_number_r <=0;
        done_r <=0;
        register_addr_r <= 0;
        rgb_color_r <= 0;
        writer_start_r <= 0;
        read_start_r <= 0;
        write_data_r <= 0;
        translate_start_r <= 0;
    end
    else begin
        state_r <= state_w;
        bytes_number_r <= bytes_number_w;
        done_r <= done_w;
        register_addr_r <= register_addr_w;
        rgb_color_r <= rgb_color_w;
        writer_start_r <= writer_start_w;
        read_start_r <= read_start_w;
        write_data_r <= write_data_w;
        translate_start_r <= translate_start_w;
    end
end

endmodule