module Top (
    input i_clk_12m,
    input i_clk_2k,
    input i_clk_100k,
    input i_rst_n, //key[0] 
    input i_start, //key[1] for decoder
    input i_start_s, //key[3] for state determination
    //sensor
    inout sda,
    inout scl,

    input i_finish_load,
    input [3:0] i_input_move,

    output logic [4:0] o_top_state,
    //motor
    output M_1_en, // maybe we can integrate step and dir as a pin and control merely by en
    output M_2_en,
    output M_3_en,
    output M_4_en,
    output M_5_en,
    output M_6_en,
    output M_step,
    output M_dir,
    output M_ms,

    //ls
    inout LS_1_sdat,
    inout LS_2_sdat,
    output LS_1_sclk,
    output LS_2_sclk,

    output [3:0] current_move
);

//declaration
typedef enum {
    S_INIT,
    S_SOLVE,
    S_IDLE, // press a key to start solving
    S_ROTATE, // motor work
    S_DONE
} State;
State state_w, state_r;
logic [2:0] c_state [0:47];
logic alg_done, alg_finish, sd_done, mtr_done, ls_1_done, ls_2_done,dd_done, dd_finish, sp_done;
logic alg_start_w, alg_start_r;
logic sd_start_w, sd_start_r;
logic mtr_start_w, mtr_start_r;
logic [3:0] move_combo [0:31];
logic [3:0] move_queue[0:255];
logic [2:0] face;
logic ack;
logic [2:0] init_c_state [0:47];
logic [2:0] temp_c_state [0:47];
logic [2:0] corner_color, edge_color;

assign temp_c_state [0] = 3'b001;
assign temp_c_state [1] = 3'b010;
assign temp_c_state [2] = 3'b011;
assign temp_c_state [3] = 3'b100;
assign temp_c_state [4] = 3'b000;
assign temp_c_state [5] = 3'b101;
assign temp_c_state [6] = 3'b001;
assign temp_c_state [7] = 3'b010;
assign temp_c_state [8] = 3'b011;
assign temp_c_state [9] = 3'b100;
assign temp_c_state [10] = 3'b000;
assign temp_c_state [11] = 3'b101;
assign temp_c_state [12] = 3'b001;
assign temp_c_state [13] = 3'b010;
assign temp_c_state [14] = 3'b011;
assign temp_c_state [15] = 3'b100;
assign temp_c_state [16] = 3'b000;
assign temp_c_state [17] = 3'b101;
assign temp_c_state [18] = 3'b001;
assign temp_c_state [19] = 3'b010;
assign temp_c_state [20] = 3'b011;
assign temp_c_state [21] = 3'b100;
assign temp_c_state [22] = 3'b000;
assign temp_c_state [23] = 3'b101;
assign temp_c_state [24] = 3'b001;
assign temp_c_state [25] = 3'b010;
assign temp_c_state [26] = 3'b011;
assign temp_c_state [27] = 3'b100;
assign temp_c_state [28] = 3'b000;
assign temp_c_state [29] = 3'b101;
assign temp_c_state [30] = 3'b001;
assign temp_c_state [31] = 3'b010;
assign temp_c_state [32] = 3'b011;
assign temp_c_state [33] = 3'b100;
assign temp_c_state [34] = 3'b000;
assign temp_c_state [35] = 3'b101;
assign temp_c_state [36] = 3'b001;
assign temp_c_state [37] = 3'b010;
assign temp_c_state [38] = 3'b011;
assign temp_c_state [39] = 3'b100;
assign temp_c_state [40] = 3'b000;
assign temp_c_state [41] = 3'b101;
assign temp_c_state [42] = 3'b001;
assign temp_c_state [43] = 3'b010;
assign temp_c_state [44] = 3'b011;
assign temp_c_state [45] = 3'b100;
assign temp_c_state [46] = 3'b000;
assign temp_c_state [47] = 3'b101;
assign M_ms = 0;

//instantiation
Algorithm alg (
    .i_clk(i_clk_12m),
    .i_rst_n(i_rst_n),
    .i_start(sd_done),
    .i_load(i_start),
    .i_move(i_input_move),
    .i_finish_load(i_finish_load),
    .i_c_state(c_state),
    .i_SD_done(sd_done),
    .i_Motor_done(mtr_done),
    .i_dd_done(dd_done),

    .o_face(face),
    .o_done(alg_done),
    .o_finish(alg_finish),
    .o_move_combo(move_combo)
);

State_Determination sd(
    .i_clk(i_clk_12m),
    .i_rst_n(i_rst_n),
    .i_start(i_start_s),
    .i_move_combo(move_combo),
    .i_init_c_state(temp_c_state),
    .i_alg_done(alg_done),

    .o_done(sd_done),
    .o_next_c_state(c_state)
);

motor mtr(
    .clk(i_clk_12m),
    .rst_n(i_rst_n),
    .motor_start(alg_done),
    .color(face),
    .m_s(move_combo),
    .i_dd_done(dd_done),
    .motor_done(mtr_done),
    .move_queue(move_queue)
);

Driver_Decoder dd(
    .i_clk(i_clk_2k),//2k
    .i_rst_n(i_rst_n),
    .i_start(i_start),
    .i_move_queue(move_queue),
    .i_ls_done(ls_1_done && ls_2_done),

    //output acknowledge for light sensor
    .o_ack(ack),

    .o_en_1(M_1_en), //white
    .o_en_2(M_2_en), //green
    .o_en_3(M_3_en), //red
    .o_en_4(M_4_en), //blue
    .o_en_5(M_5_en), //orange
    .o_en_6(M_6_en), //yellow
    .o_dir(M_dir),
    .o_step(M_step),
    .o_done(dd_done),
    .o_finished(dd_finish),
    .en_move(current_move)
);

always_comb begin
    state_w = state_r;
    alg_start_w = alg_start_r;
    sd_start_w = sd_start_r;
    mtr_start_w = mtr_start_r;
    // dd_start_w = dd_start_r;
    
    case (state_r)
        S_INIT: begin // press key[1] to start sensing color
            // sd_start_w = 1;
            if(i_start_s) begin
                state_w = S_SOLVE;
            end
            o_top_state = 5'b00001;
        end 
        S_SOLVE: begin
            sd_start_w = 0;
            if (alg_finish && mtr_done && sd_done) begin
                state_w = S_IDLE;
            end
            o_top_state = 5'b00011;
        end
        S_IDLE: begin
            if(i_start) begin
                state_w = S_ROTATE;
            end
            o_top_state = 5'b00111;
        end
        S_ROTATE: begin
            if(dd_done) begin
                state_w = S_DONE;
            end
            o_top_state = 5'b01111;
        end
        S_DONE: begin
            if(i_start) begin
                state_w = S_INIT;
                alg_start_w = 0;
                sd_start_w = 0;
                mtr_start_w = 0;
            end
            o_top_state = 5'b11111;
        end
    endcase
end

always_ff @( posedge i_clk_12m or negedge i_rst_n ) begin
    if (!i_rst_n) begin
        state_r <= S_INIT;
        alg_start_r <= 0;
        sd_start_r <= 0;
        mtr_start_r <= 0;
    end
    else begin
        state_r <= state_w;
        alg_start_r <= alg_start_w;
        sd_start_r <= sd_start_w;
        mtr_start_r <= mtr_start_w;
    end
end

endmodule
