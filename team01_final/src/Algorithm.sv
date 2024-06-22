module Algorithm (
    input i_clk,
    input i_rst_n,
    input i_start,
    input i_load,
    input i_finish_load,
    input [3:0] i_move,
    input [2:0] i_c_state [0:47],
    input i_SD_done,
    input i_Motor_done,
    input i_dd_done,
    output [2:0] o_face,
    output o_done,
    output o_finish,
    output [3:0] o_move_combo [0:31]
);
//parameter declaration
typedef enum {
    S_IDLE,
    S_RANDOM,
    S_RANDOM_WAIT,
    S_WAIT,
    S_1_CROSS,
    S_1_CORNER,
    S_2_EDGE,
    S_3_CROSS,
    S_3_EDGE,
    S_3_CORNER,
    S_3_FINALIZE
} State;

parameter W = 3'd0;
parameter G = 3'd1;
parameter R = 3'd2;
parameter B = 3'd3; 
parameter O = 3'd4;
parameter Y = 3'd5;
// white = 0
// green = 1
// red = 2
// blue = 3
// orange = 4
// yellow = 5
parameter NOP = 4'b0000;
parameter CHANGE_VIEW = 4'b0001;
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
parameter FRONT_TO_TOP = 4'b1111;

//logic declaration
State state_w, state_r;
State prev_state_w, prev_state_r;
logic done_w, done_r;
logic finish_w, finish_r;
logic [3:0] move_combo_w [0:31];
logic [3:0] move_combo_r [0:31];
logic [5:0] edge_found[0:1];
logic [5:0] corner_found [0:2];
logic [2:0] color_1_r, color_1_w, color_2_r, color_2_w, color_3_r, color_3_w;
logic [2:0] face_w, face_r;
logic stage_complete_w, stage_complete_r;
logic [3:0] state_count_w, state_count_r;
logic [1:0] face_count_w, face_count_r;
logic Right_w, Right_r;
logic [2:0] counter_for_top_corner_w, counter_for_top_corner_r;
logic [20:0] o_random1_r, o_random1_w, o_random2_r, o_random2_w;
logic safe_w, safe_r;
logic stall_w, stall_r;

logic [2:0] i ;
integer j ;
integer k ;

//assignment
assign o_done = done_r;
assign o_finish = finish_r;
assign o_face = face_r;
assign o_move_combo = move_combo_r;

Find_edge find_edge1(
    .i_c_state(i_c_state),
    .i_color_1(color_1_r),
    .i_color_2(color_2_r),
    .o_edge(edge_found)
);
Find_Corner find_Corner1(
    .i_c_state(i_c_state),
    .i_color_1(color_1_r),
    .i_color_2(color_2_r),
    .i_color_3(color_3_r),
    .o_corner(corner_found)
);

//combinational ckt
always_comb begin
    stall_w = stall_r;
    state_w = state_r;
    done_w = done_r;
    finish_w = finish_r;
    prev_state_w = prev_state_r;
    for (j = 0;j < 32 ; j++) begin
        move_combo_w[j] = move_combo_r[j];
    end
    state_count_w = state_count_r;
    stage_complete_w = stage_complete_r;
    color_1_w = color_1_r;
    color_2_w = color_2_r;
    color_3_w = color_3_r;
    face_count_w = face_count_r;
    face_w = face_r;
    Right_w = Right_r;
    counter_for_top_corner_w = counter_for_top_corner_r;
	i = 0;
    o_random1_w = o_random1_r + 1;
    o_random2_w = o_random2_r + 3;
    safe_w = safe_r;
    case (state_r)
        S_IDLE :begin
            if (i_start) begin
                state_w = S_RANDOM;
                done_w = 0;
                for (j = 0;j < 32 ; j++) begin
                    move_combo_w[j] = NOP;
                end
                state_count_w = 0;
                color_1_w = W;
                color_2_w = G;
                Right_w = 0;
                stage_complete_w = 0;
                face_count_w = 0;
                face_w = G;
                finish_w = 0;
                stall_w = 0;
            end
        end
        S_RANDOM :begin
            done_w = 0;
            if(i_load && !stall_r && !i_dd_done) begin
                move_combo_w[0] = i_move;
                done_w = 1;
                state_w = S_RANDOM_WAIT;
            end
            

            if(i_finish_load) begin
                state_w = S_1_CROSS;
            end
        end
        S_RANDOM_WAIT:begin
            if(i_dd_done) begin
                safe_w = 1;
            end
            for (j = 0;j < 32 ; j++) begin
                    move_combo_w[j] = NOP;
            end
            if(safe_r && !i_dd_done) begin
                state_w = S_RANDOM;
                safe_w = 0;
            end
            done_w = 0;
        end
        S_WAIT :begin
            done_w = 0;
            if (i_SD_done && i_Motor_done) begin
                for (j = 0;j < 32 ; j++) begin
                    move_combo_w[j] = NOP;
                end
                if (stage_complete_r) begin
                    state_count_w =0;
                    stage_complete_w = 0;
                    case (prev_state_r)
                        S_1_CROSS: begin
                            state_w = S_1_CORNER;
                            state_count_w = 0;
                            face_count_w = 0;
                            color_1_w = W;
                            color_2_w = G;
                            color_3_w = R;
                        end
                        S_1_CORNER: begin
                            state_w = S_2_EDGE;
                            state_count_w = 0;
                            face_count_w = 0;
                            color_1_w = G;
                            color_2_w = R;
                        end
                        S_2_EDGE:begin
                            state_w = S_3_CROSS;
                            state_count_w = 0;
                            face_count_w = 0;
                        end
                        S_3_CROSS:begin
                            state_w = S_3_EDGE;
                            color_1_w = Y;
                            color_2_w = G;
                            state_count_w = 0;
                            face_count_w = 0;
                        end
                        S_3_EDGE:begin
                            state_w = S_3_CORNER;
                            counter_for_top_corner_w =0;
                            state_count_w = 0;
                            face_count_w = 0;
                            color_1_w = 1;
                            color_2_w = 4;
                            color_3_w = 5;
                        end
                        S_3_CORNER:begin
                            state_w = S_3_FINALIZE;
                            state_count_w = 0;
                            face_count_w = 0;
                        end
                        S_3_FINALIZE:begin
                            state_w = S_WAIT; 
                            state_count_w = 0;
                            face_count_w = 0;
                            finish_w = 1;
                            stage_complete_w = 1;
                        end
                    endcase
                end
                else begin
                    case (prev_state_r)
                        S_1_CROSS: begin
                            state_w = prev_state_r; 
                        end
                        S_1_CORNER: begin
                            state_w = prev_state_r; 
                        end
                        S_2_EDGE: begin
                            state_w = prev_state_r; 
                        end
                        S_3_CROSS: begin
                            state_w = prev_state_r; 
                        end
                        S_3_EDGE: begin
                            state_w = prev_state_r; 
                        end
                        S_3_CORNER: begin
                            state_w = prev_state_r; 
                        end
                        S_3_FINALIZE: begin
                            state_w = prev_state_r; 
                        end
                    endcase
                end
            end
        end
        S_1_CROSS :begin
            prev_state_w = S_1_CROSS;
            face_w = color_2_r;
            state_w = S_WAIT;
            done_w = 1;
            case (state_count_r)
                0: begin
                    state_count_w = state_count_r + 1;
                    if(edge_found[0] == 24 && edge_found[1] == 40) begin
                        move_combo_w[0] = F_C;
                    end
                    else if(edge_found[0] == 30 && edge_found[1] == 43) begin 
                    end
                    else if(edge_found[0] == 31 && edge_found[1] == 44) begin
                        move_combo_w[0] = R_C;
                        move_combo_w[1] = D_CC;
                        move_combo_w[2] = R_CC;
                    end
                    else if(edge_found[0] ==33 && edge_found[1] == 42)begin
                        move_combo_w[0] = F_C;
                        move_combo_w[1] = F_C;
                    end
                    else if(edge_found[0] == 29 && edge_found[1] == 36)begin
                        move_combo_w[0] = F_CC;
                    end
                    else if(edge_found[0] == 32 && edge_found[1] == 45)begin
                        move_combo_w[0] = L_CC;
                        move_combo_w[1] = D_C;
                        move_combo_w[2] = L_C;
                    end
                    else if(edge_found[0] == 25 && edge_found[1] == 34)begin
                        move_combo_w[0] = R_CC;
                    end
                    else if(edge_found[0] == 26 && edge_found[1] == 28)begin
                        move_combo_w[0] = B_C;
                        move_combo_w[1] = B_C;
                        move_combo_w[2] = D_C;
                        move_combo_w[3] = D_C;
                    end
                    else if(edge_found[0] == 27 && edge_found[1] == 46)begin
                        move_combo_w[0] = L_C;
                        move_combo_w[1] = F_C;
                        move_combo_w[2] = F_C;
                    end
                    else if(edge_found[0] == 35 && edge_found[1] == 37)begin
                        move_combo_w[0] = D_CC;
                    end
                    else if(edge_found[0] == 38 && edge_found[1] == 41)begin
                        move_combo_w[0] = D_C;
                        move_combo_w[1] = D_C;
                    end
                    else if(edge_found[0] == 39 && edge_found[1] == 47)begin
                        move_combo_w[0] = D_C;
                    end
                end
                1:begin
                    state_count_w = 0;
                    if(face_count_r == 3) stage_complete_w = 1;
                    face_count_w = face_count_r + 1;
                    color_2_w = {1'b0, color_2_r[1:0]+1};
                    i = 0;
                    if(edge_found[0]==30 && edge_found[1] == 43)begin
                        if(i_c_state[edge_found[0]] == color_2_r && i_c_state[edge_found[1]] == color_1_r)begin
                            move_combo_w[0] = F_CC;
                            i = 1;
                        end
                        else begin
                            move_combo_w[0] = T_CC;
                            move_combo_w[1] = R_C;
                            move_combo_w[2] = T_C;
                            i = 3;
                        end
                    end
                    else if(edge_found[0] == 29 && edge_found[1] == 36)begin
                        if(i_c_state[edge_found[0]] == color_1_r && i_c_state[edge_found[1]] == color_2_r)begin
                            move_combo_w[0] = F_CC;
                            move_combo_w[1] = F_CC;
                            i = 2;
                        end
                        else begin
                            move_combo_w[0] = F_CC;
                            move_combo_w[1] = T_CC;
                            move_combo_w[2] = R_C;
                            move_combo_w[3] = T_C;
                            i = 4;
                        end
                    end
                    else if(edge_found[0] == 24 && edge_found[1] == 40)begin
                        if(i_c_state[edge_found[0]] == color_1_r && i_c_state[edge_found[1]] == color_2_r)begin
                            move_combo_w[0] = F_C;
                            move_combo_w[1] = T_CC;
                            move_combo_w[2] = R_C;
                            move_combo_w[3] = T_C;
                            i = 5;
                        end
                        else begin
                            i = 0;
                        end
                    end
                    move_combo_w[i] = CHANGE_VIEW;
                end
            endcase
        end
        S_1_CORNER :begin
            prev_state_w = S_1_CORNER;
            face_w = color_2_r;
            state_w = S_WAIT;
            done_w = 1;
            case (state_count_r)
                0: begin
                    state_count_w = state_count_r + 1;
                    if(corner_found[0] == 1 && corner_found[1] == 6 && corner_found[2] == 16) begin
                        move_combo_w[0] = R_CC;
                        move_combo_w[1] = D_CC;
                        move_combo_w[2] = R_C;
                        move_combo_w[3] = D_C;
                    end
                    else if(corner_found[0] == 2 && corner_found[1] == 7 && corner_found[2] == 10) begin
                        move_combo_w[0] = R_C;
                        move_combo_w[1] = D_C;
                        move_combo_w[2] = R_CC;
                        move_combo_w[3] = D_C;
                        move_combo_w[4] = D_C;
                    end
                    else if(corner_found[0] ==3 && corner_found[1] == 4 && corner_found[2] == 8) begin
                        move_combo_w[0] = L_CC;
                        move_combo_w[1] = D_C;
                        move_combo_w[2] = D_C;
                        move_combo_w[3] = L_C;
                    end
                    else if(corner_found[0] == 0 && corner_found[1] == 9 && corner_found[2] ==22) begin
                        move_combo_w[0] = L_C;
                        move_combo_w[1] = D_C;
                        move_combo_w[2] = L_CC;
                    end
                    else if(corner_found[0] == 5 && corner_found[1] == 15 && corner_found[2] == 18) begin
                        move_combo_w[0] = D_C;
                    end
                    else if(corner_found[0] == 14 && corner_found[1] == 21 && corner_found[2] == 23) begin
                        move_combo_w[0] = D_C;
                        move_combo_w[1] = D_C;
                    end
                    else if(corner_found[0] == 13 && corner_found[1] == 17 && corner_found[2] == 20) begin
                        move_combo_w[0] = D_CC;
                    end
                    else if(corner_found[0] == 11 && corner_found[1] == 12 && corner_found[2] == 19) begin

                    end
                end 
                1: begin
                    state_count_w = 0;
                    if(face_count_r == 3) stage_complete_w = 1;
                    face_count_w = face_count_r + 1;
                    color_2_w = {1'b0, color_2_r[1:0]+1};
                    color_3_w = {1'b0, color_3_r[1:0]+1};
                    if(i_c_state[11] == color_1_r && i_c_state[12] == color_3_r && i_c_state[19] == color_2_r) begin
                        move_combo_w[0] = R_CC;
                        move_combo_w[1] = D_CC;
                        move_combo_w[2] = D_CC;
                        move_combo_w[3] = R_C;
                        move_combo_w[4] = D_C;
                        move_combo_w[5] = R_CC;
                        move_combo_w[6] = D_CC;
                        move_combo_w[7] = R_C;
                        move_combo_w[8] = CHANGE_VIEW;
                    end
                    else if(i_c_state[11] == color_3_r && i_c_state[12] == color_2_r && i_c_state[19] == color_1_r) begin
                        move_combo_w[0] = R_CC;
                        move_combo_w[1] = D_CC;
                        move_combo_w[2] = R_C;
                        move_combo_w[3] = CHANGE_VIEW;
                    end
                    else if(i_c_state[11] == color_2_r && i_c_state[12] == color_1_r && i_c_state[19] == color_3_r) begin
                        move_combo_w[0] = F_C;
                        move_combo_w[1] = D_C;
                        move_combo_w[2] = F_CC;
                        move_combo_w[3] = CHANGE_VIEW;
                    end
                    else begin
                        move_combo_w[0] = CHANGE_VIEW;
                    end
                end 
            endcase
        end
        S_2_EDGE :begin
            prev_state_w = S_2_EDGE;
            face_w = color_1_r;
            state_w = S_WAIT;
            done_w = 1;
            case (state_count_r)
                0: begin
                    state_count_w = state_count_r + 1;
                    if(edge_found[0] == 30 && edge_found[1] == 43) begin
                        move_combo_w[0] = D_CC;
                        move_combo_w[1] = R_CC;
                        move_combo_w[2] = D_C;
                        move_combo_w[3] = R_C;
                        move_combo_w[4] = D_C;
                        move_combo_w[5] = F_C;
                        move_combo_w[6] = D_CC;
                        move_combo_w[7] = F_CC;
                    end
                    else if(edge_found[0] == 31 && edge_found[1] == 44) begin
                        move_combo_w[0] = CHANGE_VIEW;
                        move_combo_w[1] = D_CC;
                        move_combo_w[2] = R_CC;
                        move_combo_w[3] = D_C;
                        move_combo_w[4] = R_C;
                        move_combo_w[5] = D_C;
                        move_combo_w[6] = F_C;
                        move_combo_w[7] = D_CC;
                        move_combo_w[8] = F_CC;
                        move_combo_w[9] = CHANGE_VIEW;
                        move_combo_w[10] = CHANGE_VIEW;
                        move_combo_w[11] = CHANGE_VIEW;
                    end
                    else if(edge_found[0] == 32 && edge_found[1] == 45) begin
                        move_combo_w[0] = CHANGE_VIEW;
                        move_combo_w[1] = CHANGE_VIEW;
                        move_combo_w[2] = D_CC;
                        move_combo_w[3] = R_CC;
                        move_combo_w[4] = D_C;
                        move_combo_w[5] = R_C;
                        move_combo_w[6] = D_C;
                        move_combo_w[7] = F_C;
                        move_combo_w[8] = D_CC;
                        move_combo_w[9] = F_CC;
                        move_combo_w[10] = CHANGE_VIEW;
                        move_combo_w[11] = CHANGE_VIEW;
                    end
                    else if(edge_found[0] == 33 && edge_found[1] == 42) begin
                        move_combo_w[0] = CHANGE_VIEW;
                        move_combo_w[1] = CHANGE_VIEW;
                        move_combo_w[2] = CHANGE_VIEW;
                        move_combo_w[3] = D_CC;
                        move_combo_w[4] = R_CC;
                        move_combo_w[5] = D_C;
                        move_combo_w[6] = R_C;
                        move_combo_w[7] = D_C;
                        move_combo_w[8] = F_C;
                        move_combo_w[9] = D_CC;
                        move_combo_w[10] = F_CC;
                        move_combo_w[11] = CHANGE_VIEW;
                    end
                end
                1: begin
                    state_count_w = state_count_r + 1;
                    if(edge_found[0] == 29 && edge_found[1] == 36) begin
                        
                    end
                    else if(edge_found[0] == 35 && edge_found[1] == 37) begin
                        move_combo_w[0] = D_CC;
                    end
                    else if(edge_found[0] == 38 && edge_found[1] == 41) begin
                        move_combo_w[0] = D_CC;
                        move_combo_w[1] = D_CC;
                    end
                    else if(edge_found[0] == 39 && edge_found[1] == 47) begin
                        move_combo_w[0] = D_C;
                    end
                end
                2: begin
                    state_count_w = 0;
                    if(face_count_r == 3) stage_complete_w = 1;
                    face_count_w = face_count_r + 1;
                    color_1_w = {1'b0, color_1_r[1:0]+1};
                    color_2_w = {1'b0, color_2_r[1:0]+1};
                    if(i_c_state[36] == color_1_r) begin
                        move_combo_w[0] = D_CC;
                        move_combo_w[1] = R_CC;
                        move_combo_w[2] = D_C;
                        move_combo_w[3] = R_C;
                        move_combo_w[4] = D_C;
                        move_combo_w[5] = F_C;
                        move_combo_w[6] = D_CC;
                        move_combo_w[7] = F_CC;
                        move_combo_w[8] = CHANGE_VIEW;
                    end
                    else begin
                        move_combo_w[0] = D_C;
                        move_combo_w[1] = CHANGE_VIEW;
                        move_combo_w[2] = D_C;
                        move_combo_w[3] = L_C;
                        move_combo_w[4] = D_CC;
                        move_combo_w[5] = L_CC;
                        move_combo_w[6] = D_CC;
                        move_combo_w[7] = F_CC;
                        move_combo_w[8] = D_C;
                        move_combo_w[9] = F_C;
                    end
                end
            endcase
        end
        S_3_CROSS :begin
            prev_state_w = S_3_CROSS;
            stage_complete_w = 1;
            face_w = color_2_r;
            move_combo_w[0] = FRONT_TO_TOP;
            move_combo_w[1] = FRONT_TO_TOP;    
            state_w = S_WAIT;
            done_w = 1;
            if(i_c_state[29] == 5 && i_c_state[35] == 5 && i_c_state[41] == 5 && i_c_state[47] == 5) begin
                // 29->28, 35 -> 34, 41 ->40 , 47 ->46
                move_combo_w[2] = CHANGE_VIEW;
                move_combo_w[3] = CHANGE_VIEW;
            end
            else if(i_c_state[47] == 5 && i_c_state[35] == 5) begin
                move_combo_w[2] = F_C;
                move_combo_w[3] = R_C;
                move_combo_w[4] = T_C;
                move_combo_w[5] = R_CC;
                move_combo_w[6] = T_CC;
                move_combo_w[7] = F_CC;
                move_combo_w[8] = CHANGE_VIEW;
                move_combo_w[9] = CHANGE_VIEW;
            end
            else if(i_c_state[29] == 5 && i_c_state[41] == 5) begin
                move_combo_w[2] = T_C;
                move_combo_w[3] = F_C;
                move_combo_w[4] = R_C;
                move_combo_w[5] = T_C;
                move_combo_w[6] = R_CC;
                move_combo_w[7] = T_CC;
                move_combo_w[8] = F_CC;
                move_combo_w[9] = CHANGE_VIEW;
                move_combo_w[10] = CHANGE_VIEW;
            end
            else if(i_c_state[47] == 5 && i_c_state[29] == 5) begin
                move_combo_w[2] = F_C;
                move_combo_w[3] = T_C;
                move_combo_w[4] = R_C;
                move_combo_w[5] = T_CC;
                move_combo_w[6] = R_CC;
                move_combo_w[7] = F_CC;
                move_combo_w[8] = CHANGE_VIEW;
                move_combo_w[9] = CHANGE_VIEW;
            end
            else if(i_c_state[29] == 5 && i_c_state[35] == 5) begin
                move_combo_w[2] = T_CC;
                move_combo_w[3] = F_C;
                move_combo_w[4] = T_C;
                move_combo_w[5] = R_C;
                move_combo_w[6] = T_CC;
                move_combo_w[7] = R_CC;
                move_combo_w[8] = F_CC;
                move_combo_w[9] = CHANGE_VIEW;
                move_combo_w[10] = CHANGE_VIEW;
            end
            else if(i_c_state[41] == 5 && i_c_state[35] == 5) begin
                move_combo_w[2] = T_CC;
                move_combo_w[3] = T_CC;
                move_combo_w[4] = F_C;
                move_combo_w[5] = T_C;
                move_combo_w[6] = R_C;
                move_combo_w[7] = T_CC;
                move_combo_w[8] = R_CC;
                move_combo_w[9] = F_CC;
                move_combo_w[10] = CHANGE_VIEW;
                move_combo_w[11] = CHANGE_VIEW;
            end
            else if(i_c_state[47] == 5 && i_c_state[41] == 5) begin
                move_combo_w[2] = T_C;
                move_combo_w[3] = F_C;
                move_combo_w[4] = T_C;
                move_combo_w[5] = R_C;
                move_combo_w[6] = T_CC;
                move_combo_w[7] = R_CC;
                move_combo_w[8] = F_CC;
                move_combo_w[9] = CHANGE_VIEW;
                move_combo_w[10] = CHANGE_VIEW;
            end
            else begin
                move_combo_w[2] = F_C;
                move_combo_w[3] = R_C;
                move_combo_w[4] = T_C;
                move_combo_w[5] = R_CC;
                move_combo_w[6] = T_CC;
                move_combo_w[7] = F_CC;
                move_combo_w[8] = FRONT_TO_TOP;   // denied the effect of Front to top at the start since we have to giet into s_3_cross again
                move_combo_w[9] = FRONT_TO_TOP;
                stage_complete_w = 0;
            end
        end
        S_3_EDGE :begin
            prev_state_w = S_3_EDGE;
            stage_complete_w = 0;  
            state_w = S_WAIT;
            done_w = 1;
            face_w = color_2_r;
            color_2_w = color_2_r;
            case(color_2_r)
                3'd1: begin
                    color_2_w = O;
                    if(edge_found[0] == 24 && edge_found[1] == 40) begin
                        move_combo_w[0] = CHANGE_VIEW;
                    end
                    else if(edge_found[0] == 25 && edge_found[1] == 34) begin
                        move_combo_w[0] = T_C;
                        move_combo_w[1] = CHANGE_VIEW;
                    end
                    else if(edge_found[0] == 26 && edge_found[1] == 28) begin
                        move_combo_w[0] = T_C;
                        move_combo_w[1] = T_C;
                        move_combo_w[2] = CHANGE_VIEW;
                    end
                    else if(edge_found[0] == 27 && edge_found[1] == 46)begin
                        move_combo_w[0] = T_CC;
                        move_combo_w[1] = CHANGE_VIEW;
                    end
                    else begin
                        move_combo_w[0] = CHANGE_VIEW;
                    end
                    end
                3'd4:begin
                    color_2_w = B;
                    if(i_c_state[26] == color_2_r)begin
                        move_combo_w[0] = CHANGE_VIEW;
                        move_combo_w[1] = CHANGE_VIEW;
                        move_combo_w[2] = R_C;
                        move_combo_w[3] = T_C;
                        move_combo_w[4] = R_CC;
                        move_combo_w[5] = T_C;
                        move_combo_w[6] = R_C;
                        move_combo_w[7] = T_C;
                        move_combo_w[8] = T_C;
                        move_combo_w[9] = R_CC;
                        move_combo_w[10] = T_C;
                        move_combo_w[11] = CHANGE_VIEW;
                        move_combo_w[12] = CHANGE_VIEW;
                        move_combo_w[13] = CHANGE_VIEW;
                        move_combo_w[14] = R_C;
                        move_combo_w[15] = T_C;
                        move_combo_w[16] = R_CC;
                        move_combo_w[17] = T_C;
                        move_combo_w[18] = R_C;
                        move_combo_w[19] = T_C;
                        move_combo_w[20] = T_C;
                        move_combo_w[21] = R_CC;
                        move_combo_w[22] = T_C;
                    end
                    else if(i_c_state[25] == color_2_r)begin
                        move_combo_w[0] = CHANGE_VIEW;
                        move_combo_w[1] = R_C;
                        move_combo_w[2] = T_C;
                        move_combo_w[3] = R_CC;
                        move_combo_w[4] = T_C;
                        move_combo_w[5] = R_C;
                        move_combo_w[6] = T_C;
                        move_combo_w[7] = T_C;
                        move_combo_w[8] = R_CC;
                        move_combo_w[9] = T_C;
                    end
                    else if(i_c_state[24] == color_2_r)begin
                        move_combo_w[0] = CHANGE_VIEW;
                    end
                    end
                3'd3: begin
                    color_2_w = G;
                    stage_complete_w = 1;
                    if(i_c_state[24] == color_2_r)begin
                        move_combo_w[0] = CHANGE_VIEW;
                        move_combo_w[1] = CHANGE_VIEW;
                    end
                    else if(i_c_state[25] == color_2_r)begin
                        move_combo_w[0] = CHANGE_VIEW;
                        move_combo_w[1] = R_C;
                        move_combo_w[2] = T_C;
                        move_combo_w[3] = R_CC;
                        move_combo_w[4] = T_C;
                        move_combo_w[5] = R_C;
                        move_combo_w[6] = T_C;
                        move_combo_w[7] = T_C;
                        move_combo_w[8] = R_CC;
                        move_combo_w[9] = T_C;
                        move_combo_w[10] = CHANGE_VIEW;
                    end
                end
            endcase     
        end
        S_3_CORNER :begin
            prev_state_w = S_3_CORNER;
            done_w = 1;
            state_w = S_WAIT;
            face_w = color_1_r;
            case (state_count_r)
                0: begin
                    color_1_w = 4;
                    color_2_w = 3;
                    state_count_w = state_count_r + 1;
                    if(corner_found[0] == 1 && corner_found[1] == 6 && corner_found[2] == 16 && Right_r == 0) begin
                        Right_w = 1;
                        move_combo_w[0] = CHANGE_VIEW;
                    end
                    else begin
                        move_combo_w[0] = CHANGE_VIEW;
                    end
                end 
                1: begin
                    color_1_w = 3;
                    color_2_w = 2;
                    state_count_w = state_count_r + 1;
                    if(corner_found[0] == 1 && corner_found[1] == 6 && corner_found[2] == 16 && Right_r == 0) begin
                        Right_w = 1;
                        color_1_w = color_1_r;
                        color_2_w = 1;
                        state_count_w = 5;
                    end
                    else if(corner_found[0] == 1 && corner_found[1] == 6 && corner_found[2] == 16 && Right_r == 1) begin
                        stage_complete_w = 1;
                    end 
                    else if( ~(corner_found[0]== 1 && corner_found[1] == 6 && corner_found[2] == 16) && Right_r == 1)begin
                        move_combo_w[0] = CHANGE_VIEW;
                        move_combo_w[1] = CHANGE_VIEW;
                        move_combo_w[2] = CHANGE_VIEW;
                        color_1_w = 1;
                        color_2_w = 2;
                        state_count_w = 5;
                    end
                    else begin
                        move_combo_w[0] = CHANGE_VIEW;
                    end
                end
                2: begin
                    color_1_w = 2;
                    color_2_w = 1;
                    state_count_w = state_count_r + 1;
                    if(corner_found[0] == 1 && corner_found[1] == 6 && corner_found[2] == 16) begin
                        state_count_w = 5;
                        color_1_w = color_1_r;
                        color_2_w = 4;
                    end 
                    else begin
                        move_combo_w[0] = CHANGE_VIEW;
                    end
                end
                3: begin
                    color_1_w = 1;
                    color_2_w = 2;
                    state_count_w = state_count_r + 1;
                    if(corner_found[0] == 1 && corner_found[1] == 6 && corner_found[2] == 16) begin
                        Right_w = 1;
                        state_count_w = 5;
                        color_1_w = color_1_r;
                        color_2_w = 3;
                    end
                    else begin
                        move_combo_w[0] = CHANGE_VIEW;
                    end
                end
                4: begin
                    if(corner_found[0] == 0 && corner_found[1] == 9 && corner_found[2] == 22)begin
                        state_count_w = 5;
                        color_1_w = 2;
                        color_2_w = 3;
                        move_combo_w[0] = CHANGE_VIEW;
                        move_combo_w[1] = CHANGE_VIEW;
                        move_combo_w[2] = CHANGE_VIEW;
                    end
                    else if(counter_for_top_corner_r <3) begin
                        move_combo_w[0] = T_C;
                        move_combo_w[1] = R_C;
                        move_combo_w[2] = T_CC;
                        move_combo_w[3] = L_CC;
                        move_combo_w[4] = T_C;
                        move_combo_w[5] = R_CC;
                        move_combo_w[6] = T_CC;
                        move_combo_w[7] = L_C;
                        counter_for_top_corner_w = counter_for_top_corner_r+1;
                    end else begin
                        move_combo_w[0] = CHANGE_VIEW;
                        move_combo_w[1] = T_C;
                        move_combo_w[2] = R_C;
                        move_combo_w[3] = T_CC;
                        move_combo_w[4] = L_CC;
                        move_combo_w[5] = T_C;
                        move_combo_w[6] = R_CC;
                        move_combo_w[7] = T_CC;
                        move_combo_w[8] = L_C;
                        move_combo_w[9] = T_C;
                        move_combo_w[10] = R_C;
                        move_combo_w[11] = T_CC;
                        move_combo_w[12] = L_CC;
                        move_combo_w[13] = T_C;
                        move_combo_w[14] = R_CC;
                        move_combo_w[15] = T_CC;
                        move_combo_w[16] = L_C;
                        move_combo_w[17] = CHANGE_VIEW;
                        move_combo_w[18] = CHANGE_VIEW;
                        color_1_w = 2;
                        color_2_w = 3;
                        state_count_w = 5;
                    end
                end
                5:begin                                                //one right
                    if(corner_found[0] == 0 && corner_found[1] == 9 && corner_found[2] == 22)begin
                        stage_complete_w = 1;
                        state_count_w = 0;
                    end
                    else begin
                        move_combo_w[0] = T_C;
                        move_combo_w[1] = R_C;
                        move_combo_w[2] = T_CC;
                        move_combo_w[3] = L_CC;
                        move_combo_w[4] = T_C;
                        move_combo_w[5] = R_CC;
                        move_combo_w[6] = T_CC;
                        move_combo_w[7] = L_C;
                    end
                end
                
            endcase
        end
        S_3_FINALIZE :begin
            prev_state_w = S_3_FINALIZE;
            face_w = face_r;
            state_w = S_WAIT;
            done_w = 1;
            if(i_c_state[16] != 5) begin
                
                move_combo_w[0] = R_CC;
                move_combo_w[1] = D_C;
                move_combo_w[2] = R_C;
                move_combo_w[3] = D_CC;
                move_combo_w[4] = R_CC;
                move_combo_w[5] = D_C;
                move_combo_w[6] = R_C;
                move_combo_w[7] = D_CC;
            end
            else begin
                face_count_w = face_count_r + 1;
                move_combo_w[0] = T_C;
                if (face_count_r == 3) begin
                    stage_complete_w = 1;
                    finish_w = 1;
                end
            end
        end
        default: begin
            
        end
    endcase
end

always_ff @( posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        state_r <= S_IDLE;
        prev_state_r <= S_IDLE;
        done_r <= 0;
        finish_r <= 0;
        for (k = 0; k < 32 ; k++) begin
            move_combo_r[k] <= NOP;
        end
        color_1_r <= 0;
        color_2_r <= 0;
        color_3_r <= 0;
        face_r <= 0;
        stage_complete_r <= 0;
        state_count_r <= 0;
        face_count_r <= 0;
        Right_r <= 0;
        counter_for_top_corner_r <=0;
        o_random1_r <= 0;
        o_random2_r <= 0;
        safe_r <= 0;
        stall_r <= 0;
    end 
    else begin
        state_r <= state_w;
        prev_state_r <= prev_state_w;
        done_r <= done_w;
        finish_r <= finish_w;
        for (k = 0; k < 32 ; k++) begin
            move_combo_r[k] <= move_combo_w[k];
        end
        color_1_r <= color_1_w;
        color_2_r <= color_2_w;
        color_3_r <= color_3_w;
        face_r <= face_w;
        stage_complete_r <= stage_complete_w;
        state_count_r <= state_count_w;
        face_count_r <= face_count_w;
        Right_r <= Right_w;
        counter_for_top_corner_r <=counter_for_top_corner_w;
        o_random1_r <= o_random1_w;
        o_random2_r <= o_random2_w;
        safe_r <= safe_w;
        stall_r <= stall_w;
    end
end
endmodule



module Find_Corner (
    input [2:0] i_c_state [0:47],
    input [2:0] i_color_1,
    input [2:0] i_color_2,
    input [2:0] i_color_3,
    output logic [5:0] o_corner[0:2]
);
    
    localparam int corner_index[0:7][0:2] ='{ '{1,6,16}, '{0,9,22},'{3,4,8}, '{2,7,10}, '{5,15,18},'{11,12,19},'{13,17,20},'{14,21,23}};
    //int i;
    
    always_comb begin 
    if((i_c_state[corner_index[0][0]] == i_color_1 && i_c_state[corner_index[0][1]] == i_color_2 && i_c_state[corner_index[0][2]] == i_color_3)|| (i_c_state[corner_index[0][0]] == i_color_1 && i_c_state[corner_index[0][1]] == i_color_3 && i_c_state[corner_index[0][2]] == i_color_2)|| (i_c_state[corner_index[0][0]] == i_color_2 && i_c_state[corner_index[0][1]] == i_color_1 && i_c_state[corner_index[0][2]] == i_color_3)|| (i_c_state[corner_index[0][0]] == i_color_2 && i_c_state[corner_index[0][1]] == i_color_3 && i_c_state[corner_index[0][2]] == i_color_1)|| (i_c_state[corner_index[0][0]] == i_color_3 && i_c_state[corner_index[0][1]] == i_color_1 && i_c_state[corner_index[0][2]] == i_color_2)|| (i_c_state[corner_index[0][0]] == i_color_3 && i_c_state[corner_index[0][1]] == i_color_2 && i_c_state[corner_index[0][2]] == i_color_1))begin
        o_corner[0] = corner_index[0][0];
        o_corner[1] = corner_index[0][1];
        o_corner[2] = corner_index[0][2];
    end
    else if((i_c_state[corner_index[1][0]] == i_color_1 && i_c_state[corner_index[1][1]] == i_color_2 && i_c_state[corner_index[1][2]] == i_color_3)|| (i_c_state[corner_index[1][0]] == i_color_1 && i_c_state[corner_index[1][1]] == i_color_3 && i_c_state[corner_index[1][2]] == i_color_2)|| (i_c_state[corner_index[1][0]] == i_color_2 && i_c_state[corner_index[1][1]] == i_color_1 && i_c_state[corner_index[1][2]] == i_color_3)|| (i_c_state[corner_index[1][0]] == i_color_2 && i_c_state[corner_index[1][1]] == i_color_3 && i_c_state[corner_index[1][2]] == i_color_1)|| (i_c_state[corner_index[1][0]] == i_color_3 && i_c_state[corner_index[1][1]] == i_color_1 && i_c_state[corner_index[1][2]] == i_color_2)|| (i_c_state[corner_index[1][0]] == i_color_3 && i_c_state[corner_index[1][1]] == i_color_2 && i_c_state[corner_index[1][2]] == i_color_1))begin
        o_corner[0] = corner_index[1][0];
        o_corner[1] = corner_index[1][1];
        o_corner[2] = corner_index[1][2];
    end
    else if((i_c_state[corner_index[2][0]] == i_color_1 && i_c_state[corner_index[2][1]] == i_color_2 && i_c_state[corner_index[2][2]] == i_color_3)|| (i_c_state[corner_index[2][0]] == i_color_1 && i_c_state[corner_index[2][1]] == i_color_3 && i_c_state[corner_index[2][2]] == i_color_2)|| (i_c_state[corner_index[2][0]] == i_color_2 && i_c_state[corner_index[2][1]] == i_color_1 && i_c_state[corner_index[2][2]] == i_color_3)|| (i_c_state[corner_index[2][0]] == i_color_2 && i_c_state[corner_index[2][1]] == i_color_3 && i_c_state[corner_index[2][2]] == i_color_1)|| (i_c_state[corner_index[2][0]] == i_color_3 && i_c_state[corner_index[2][1]] == i_color_1 && i_c_state[corner_index[2][2]] == i_color_2)|| (i_c_state[corner_index[2][0]] == i_color_3 && i_c_state[corner_index[2][1]] == i_color_2 && i_c_state[corner_index[2][2]] == i_color_1))begin
        o_corner[0] = corner_index[2][0];
        o_corner[1] = corner_index[2][1];
        o_corner[2] = corner_index[2][2];
    end
    else if((i_c_state[corner_index[3][0]] == i_color_1 && i_c_state[corner_index[3][1]] == i_color_2 && i_c_state[corner_index[3][2]] == i_color_3)|| (i_c_state[corner_index[3][0]] == i_color_1 && i_c_state[corner_index[3][1]] == i_color_3 && i_c_state[corner_index[3][2]] == i_color_2)|| (i_c_state[corner_index[3][0]] == i_color_2 && i_c_state[corner_index[3][1]] == i_color_1 && i_c_state[corner_index[3][2]] == i_color_3)|| (i_c_state[corner_index[3][0]] == i_color_2 && i_c_state[corner_index[3][1]] == i_color_3 && i_c_state[corner_index[3][2]] == i_color_1)|| (i_c_state[corner_index[3][0]] == i_color_3 && i_c_state[corner_index[3][1]] == i_color_1 && i_c_state[corner_index[3][2]] == i_color_2)|| (i_c_state[corner_index[3][0]] == i_color_3 && i_c_state[corner_index[3][1]] == i_color_2 && i_c_state[corner_index[3][2]] == i_color_1))begin
        o_corner[0] = corner_index[3][0];
        o_corner[1] = corner_index[3][1];
        o_corner[2] = corner_index[3][2];
    end
    else if((i_c_state[corner_index[4][0]] == i_color_1 && i_c_state[corner_index[4][1]] == i_color_2 && i_c_state[corner_index[4][2]] == i_color_3)|| (i_c_state[corner_index[4][0]] == i_color_1 && i_c_state[corner_index[4][1]] == i_color_3 && i_c_state[corner_index[4][2]] == i_color_2)|| (i_c_state[corner_index[4][0]] == i_color_2 && i_c_state[corner_index[4][1]] == i_color_1 && i_c_state[corner_index[4][2]] == i_color_3)|| (i_c_state[corner_index[4][0]] == i_color_2 && i_c_state[corner_index[4][1]] == i_color_3 && i_c_state[corner_index[4][2]] == i_color_1)|| (i_c_state[corner_index[4][0]] == i_color_3 && i_c_state[corner_index[4][1]] == i_color_1 && i_c_state[corner_index[4][2]] == i_color_2)|| (i_c_state[corner_index[4][0]] == i_color_3 && i_c_state[corner_index[4][1]] == i_color_2 && i_c_state[corner_index[4][2]] == i_color_1))begin
        o_corner[0] = corner_index[4][0];
        o_corner[1] = corner_index[4][1];
        o_corner[2] = corner_index[4][2];
    end
    else if((i_c_state[corner_index[5][0]] == i_color_1 && i_c_state[corner_index[5][1]] == i_color_2 && i_c_state[corner_index[5][2]] == i_color_3)|| (i_c_state[corner_index[5][0]] == i_color_1 && i_c_state[corner_index[5][1]] == i_color_3 && i_c_state[corner_index[5][2]] == i_color_2)|| (i_c_state[corner_index[5][0]] == i_color_2 && i_c_state[corner_index[5][1]] == i_color_1 && i_c_state[corner_index[5][2]] == i_color_3)|| (i_c_state[corner_index[5][0]] == i_color_2 && i_c_state[corner_index[5][1]] == i_color_3 && i_c_state[corner_index[5][2]] == i_color_1)|| (i_c_state[corner_index[5][0]] == i_color_3 && i_c_state[corner_index[5][1]] == i_color_1 && i_c_state[corner_index[5][2]] == i_color_2)|| (i_c_state[corner_index[5][0]] == i_color_3 && i_c_state[corner_index[5][1]] == i_color_2 && i_c_state[corner_index[5][2]] == i_color_1))begin
        o_corner[0] = corner_index[5][0];
        o_corner[1] = corner_index[5][1];
        o_corner[2] = corner_index[5][2];
    end
    else if((i_c_state[corner_index[6][0]] == i_color_1 && i_c_state[corner_index[6][1]] == i_color_2 && i_c_state[corner_index[6][2]] == i_color_3)|| (i_c_state[corner_index[6][0]] == i_color_1 && i_c_state[corner_index[6][1]] == i_color_3 && i_c_state[corner_index[6][2]] == i_color_2)|| (i_c_state[corner_index[6][0]] == i_color_2 && i_c_state[corner_index[6][1]] == i_color_1 && i_c_state[corner_index[6][2]] == i_color_3)|| (i_c_state[corner_index[6][0]] == i_color_2 && i_c_state[corner_index[6][1]] == i_color_3 && i_c_state[corner_index[6][2]] == i_color_1)|| (i_c_state[corner_index[6][0]] == i_color_3 && i_c_state[corner_index[6][1]] == i_color_1 && i_c_state[corner_index[6][2]] == i_color_2)|| (i_c_state[corner_index[6][0]] == i_color_3 && i_c_state[corner_index[6][1]] == i_color_2 && i_c_state[corner_index[6][2]] == i_color_1))begin
        o_corner[0] = corner_index[6][0];
        o_corner[1] = corner_index[6][1];
        o_corner[2] = corner_index[6][2];
    end
    else if((i_c_state[corner_index[7][0]] == i_color_1 && i_c_state[corner_index[7][1]] == i_color_2 && i_c_state[corner_index[7][2]] == i_color_3)|| (i_c_state[corner_index[7][0]] == i_color_1 && i_c_state[corner_index[7][1]] == i_color_3 && i_c_state[corner_index[7][2]] == i_color_2)|| (i_c_state[corner_index[7][0]] == i_color_2 && i_c_state[corner_index[7][1]] == i_color_1 && i_c_state[corner_index[7][2]] == i_color_3)|| (i_c_state[corner_index[7][0]] == i_color_2 && i_c_state[corner_index[7][1]] == i_color_3 && i_c_state[corner_index[7][2]] == i_color_1)|| (i_c_state[corner_index[7][0]] == i_color_3 && i_c_state[corner_index[7][1]] == i_color_1 && i_c_state[corner_index[7][2]] == i_color_2)|| (i_c_state[corner_index[7][0]] == i_color_3 && i_c_state[corner_index[7][1]] == i_color_2 && i_c_state[corner_index[7][2]] == i_color_1))begin
        o_corner[0] = corner_index[7][0];
        o_corner[1] = corner_index[7][1];
        o_corner[2] = corner_index[7][2];
    end
    else begin
        o_corner[0] = 0;
        o_corner[1] = 0;
        o_corner[2] = 0;
    end




    end
endmodule

module Find_edge(
    input [2:0] i_c_state[0:47],
    input [2:0] i_color_1,
    input [2:0] i_color_2,
    output logic [5:0] o_edge [0:1] 
);

    localparam int edge_index[0:11][0:1] = '{'{30,43},'{31,44},'{24,40},'{33,42},'{29,36},'{32,45},'{25,34},'{26,28},'{27,46},'{35,37},'{38,41},'{39,47}};
    //int i;

    always_comb begin
        if((i_c_state[edge_index[0][0]] == i_color_1 && i_c_state[edge_index[0][1]] == i_color_2) || (i_c_state[edge_index[0][0]] == i_color_2 && i_c_state[edge_index[0][1]] == i_color_1)) begin
            o_edge[0] = edge_index[0][0];
            o_edge[1] = edge_index[0][1];
            end
        else if((i_c_state[edge_index[1][0]] == i_color_1 && i_c_state[edge_index[1][1]] == i_color_2) || (i_c_state[edge_index[1][0]] == i_color_2 && i_c_state[edge_index[1][1]] == i_color_1) )begin
            o_edge[0] = edge_index[1][0];
            o_edge[1] = edge_index[1][1];
        end
        else if((i_c_state[edge_index[2][0]] == i_color_1 && i_c_state[edge_index[2][1]] == i_color_2) || (i_c_state[edge_index[2][0]] == i_color_2 && i_c_state[edge_index[2][1]] == i_color_1)) begin
            o_edge[0] = edge_index[2][0];
            o_edge[1] = edge_index[2][1];
        end
        else if((i_c_state[edge_index[3][0]] == i_color_1 && i_c_state[edge_index[3][1]] == i_color_2) || (i_c_state[edge_index[3][0]] == i_color_2 && i_c_state[edge_index[3][1]] == i_color_1) )begin
            o_edge[0] = edge_index[3][0];
            o_edge[1] = edge_index[3][1];
        end
        else if((i_c_state[edge_index[4][0]] == i_color_1 && i_c_state[edge_index[4][1]] == i_color_2) || (i_c_state[edge_index[4][0]] == i_color_2 && i_c_state[edge_index[4][1]] == i_color_1)) begin
            o_edge[0] = edge_index[4][0];
            o_edge[1] = edge_index[4][1];
        end
        else if((i_c_state[edge_index[5][0]] == i_color_1 && i_c_state[edge_index[5][1]] == i_color_2) || (i_c_state[edge_index[5][0]] == i_color_2 && i_c_state[edge_index[5][1]] == i_color_1) )begin
            o_edge[0] = edge_index[5][0];
            o_edge[1] = edge_index[5][1];
        end
        else if((i_c_state[edge_index[6][0]] == i_color_1 && i_c_state[edge_index[6][1]] == i_color_2) || (i_c_state[edge_index[6][0]] == i_color_2 && i_c_state[edge_index[6][1]] == i_color_1) )begin
            o_edge[0] = edge_index[6][0];
            o_edge[1] = edge_index[6][1];
        end
        else if((i_c_state[edge_index[7][0]] == i_color_1 && i_c_state[edge_index[7][1]] == i_color_2) || (i_c_state[edge_index[7][0]] == i_color_2 && i_c_state[edge_index[7][1]] == i_color_1) )begin
            o_edge[0] = edge_index[7][0];
            o_edge[1] = edge_index[7][1];
        end
        else if((i_c_state[edge_index[8][0]] == i_color_1 && i_c_state[edge_index[8][1]] == i_color_2) || (i_c_state[edge_index[8][0]] == i_color_2 && i_c_state[edge_index[8][1]] == i_color_1) )begin
            o_edge[0] = edge_index[8][0];
            o_edge[1] = edge_index[8][1];
        end
        else if((i_c_state[edge_index[9][0]] == i_color_1 && i_c_state[edge_index[9][1]] == i_color_2) || (i_c_state[edge_index[9][0]] == i_color_2 && i_c_state[edge_index[9][1]] == i_color_1)) begin
            o_edge[0] = edge_index[9][0];
            o_edge[1] = edge_index[9][1];
        end
        else if((i_c_state[edge_index[10][0]] == i_color_1 && i_c_state[edge_index[10][1]] == i_color_2) || (i_c_state[edge_index[10][0]] == i_color_2 && i_c_state[edge_index[10][1]] == i_color_1)) begin
            o_edge[0] = edge_index[10][0];
            o_edge[1] = edge_index[10][1];
        end
        else if((i_c_state[edge_index[11][0]] == i_color_1 && i_c_state[edge_index[11][1]] == i_color_2) || (i_c_state[edge_index[11][0]] == i_color_2 && i_c_state[edge_index[11][1]] == i_color_1)) begin
            o_edge[0] = edge_index[11][0];
            o_edge[1] = edge_index[11][1];
        end
        else begin
            o_edge[0] = 0;
            o_edge[1] = 0;
        end

    end
endmodule