module Driver_Decoder (
    input i_clk,//2k
    input i_rst_n,
    input i_start,
    input [3:0] i_move_queue[0:255],
    input i_ls_done,

    //output acknowledge for light sensor
    output o_ack,

    output o_en_1, //white
    output o_en_2, //green
    output o_en_3, //red
    output o_en_4, //blue
    output o_en_5, //orange
    output o_en_6, //yellow
    output o_dir,
    output o_step,
    output o_done,
    output o_finished,
    output [3:0] en_move
);

    localparam S_IDLE = 2'd0;
    localparam S_STUPID = 2'd1;
    localparam S_SOLVE = 2'd2;
    localparam S_DONE = 2'd3;

    parameter F_C = 4'b0010;
    parameter F_CC = 4'b1010;
    parameter R_C = 4'b0011;
    parameter R_CC = 4'b1011;
    parameter L_C = 4'b0101;
    parameter L_CC = 4'b1101;
    parameter T_C = 4'b0001;
    parameter T_CC = 4'b1001;
    parameter B_C = 4'b0100;
    parameter B_CC = 4'b1100;
    parameter D_C = 4'b0110;
    parameter D_CC = 4'b1110;

    logic [6:0] count_w;
    logic [6:0] count_r; // for 200Hz clock
    logic clk_w, clk_r;
    logic start_r, start_w;
    logic finished_w, finished_r;

    logic [1:0] state_w, state_r;

    logic [3:0] EC_move_queue [0:255];
    logic [3:0] stupid_move_queue_r [0:255];
    logic [3:0] stupid_move_queue_w [0:255];
    logic [4:0] stupid_count_w, stupid_count_r;
    logic ack_w, ack_r;

    integer i, j;
    
    assign o_ack = ack_r;
    assign o_finished = finished_r;


    En_Ctrl EC(
        .i_clk(clk_r),
        .i_rst_n(i_rst_n),
        .i_start(start_r),
        .i_move_queue(i_move_queue),
        
        .en_1(o_en_1),
        .en_2(o_en_2),
        .en_3(o_en_3),
        .en_4(o_en_4),
        .en_5(o_en_5),
        .en_6(o_en_6),
        .dir(o_dir),
        .step(o_step),
        .done(o_done),
        .move(en_move)
    );



    always_comb begin
        // clock generate
        count_w = count_r + 1;
        clk_w = clk_r;
        if (count_r == 9) begin
            clk_w = !clk_r;
            count_w = 0;
        end

        // default assignment
        state_w = state_r;
        ack_w = ack_r;
        start_w = start_r;
        for(j = 0; j < 256; j = j+ 1) begin
            stupid_move_queue_w[j] = stupid_move_queue_r[j];
        end
        stupid_count_w = stupid_count_r;
        finished_w = finished_r;

        case(state_r)
            S_IDLE: begin
                finished_w = 0;
                if(i_ls_done && !start_r) begin
                    if(!o_done) begin
                        start_w = 1;
                        state_w = S_STUPID;
                        ack_w = 1;
                    end
                end else if (i_start) begin
                    start_w = 1;
                    state_w = S_STUPID;
                    stupid_count_w = 0;
                    ack_w = 0;
                end
                case(stupid_count_r)
                    0: begin //get 13 37
                        stupid_move_queue_w[0] = T_C;
                        stupid_move_queue_w[1] = D_CC;
                        stupid_move_queue_w[2] = L_CC;
                        stupid_move_queue_w[3] = R_C;
                        stupid_move_queue_w[4] = F_C;
                        stupid_move_queue_w[5] = B_CC;
                        stupid_move_queue_w[6] = 4'b0000;
                    end
                    1: begin // get 7 31
                        stupid_move_queue_w[0] = T_C;
                        stupid_move_queue_w[1] = 4'b0000;
                        stupid_move_queue_w[2] = 4'b0000;
                        stupid_move_queue_w[3] = 4'b0000;
                        stupid_move_queue_w[4] = 4'b0000;
                        stupid_move_queue_w[5] = 4'b0000;
                        stupid_move_queue_w[6] = 4'b0000;
                    end
                    2: begin // get 1 25
                        stupid_move_queue_w[0] = T_C;
                    end
                    3: begin // get 19 43
                        stupid_move_queue_w[0] = T_C;
                    end
                    4: begin // revert to original + get 14 38
                        stupid_move_queue_w[0] = T_C;
                        stupid_move_queue_w[1] = B_C;
                        stupid_move_queue_w[2] = F_CC;
                        stupid_move_queue_w[3] = R_CC;
                        stupid_move_queue_w[4] = L_C;
                        stupid_move_queue_w[5] = F_CC;
                        stupid_move_queue_w[6] = B_C;
                        stupid_move_queue_w[7] = R_C;
                        stupid_move_queue_w[8] = L_CC;
                        stupid_move_queue_w[9] = T_C;
                    end
                    5: begin // get 8 32
                        stupid_move_queue_w[0] = T_C;
                        stupid_move_queue_w[1] = 4'b0000;
                        stupid_move_queue_w[2] = 4'b0000;
                        stupid_move_queue_w[3] = 4'b0000;
                        stupid_move_queue_w[4] = 4'b0000;
                        stupid_move_queue_w[5] = 4'b0000;
                        stupid_move_queue_w[6] = 4'b0000;
                        stupid_move_queue_w[7] = 4'b0000;
                        stupid_move_queue_w[8] = 4'b0000;
                        stupid_move_queue_w[9] = 4'b0000;
                    end
                    6: begin // get 2 26
                        stupid_move_queue_w[0] = T_C;
                    end
                    7: begin // get 20 44
                        stupid_move_queue_w[0] = T_C;
                    end
                    8: begin // revert to original + get 15 39
                        stupid_move_queue_w[0] = L_C;
                        stupid_move_queue_w[1] = R_CC;
                        stupid_move_queue_w[2] = B_CC;
                        stupid_move_queue_w[3] = F_C;
                        stupid_move_queue_w[4] = R_CC;
                        stupid_move_queue_w[5] = L_C;
                        stupid_move_queue_w[6] = B_C;
                        stupid_move_queue_w[7] = F_CC;
                        stupid_move_queue_w[8] = T_C;
                        stupid_move_queue_w[9] = T_C;
                    end
                    9: begin  // get 9 33
                        stupid_move_queue_w[0] = T_C;
                        stupid_move_queue_w[1] = 4'b0000;
                        stupid_move_queue_w[2] = 4'b0000;
                        stupid_move_queue_w[3] = 4'b0000;
                        stupid_move_queue_w[4] = 4'b0000;
                        stupid_move_queue_w[5] = 4'b0000;
                        stupid_move_queue_w[6] = 4'b0000;
                        stupid_move_queue_w[7] = 4'b0000;
                        stupid_move_queue_w[8] = 4'b0000;
                        stupid_move_queue_w[9] = 4'b0000;
                    end
                    10: begin  // get 3 27
                        stupid_move_queue_w[0] = T_C;
                    end
                    11: begin // get 21 45
                        stupid_move_queue_w[0] = T_C;
                    end
                    12: begin // revert to orignal + get 16 40
                        stupid_move_queue_w[0] = T_CC;
                        stupid_move_queue_w[1] = F_C;
                        stupid_move_queue_w[2] = B_CC;
                        stupid_move_queue_w[3] = L_CC;
                        stupid_move_queue_w[4] = R_C;
                        stupid_move_queue_w[5] = F_C;
                        stupid_move_queue_w[6] = B_CC;
                        stupid_move_queue_w[7] = L_C;
                        stupid_move_queue_w[8] = R_CC;
                        stupid_move_queue_w[9] = T_CC;
                    end
                    13: begin // get 10 34
                        stupid_move_queue_w[0] = T_C;
                        stupid_move_queue_w[1] = 4'b0000;
                        stupid_move_queue_w[2] = 4'b0000;
                        stupid_move_queue_w[3] = 4'b0000;
                        stupid_move_queue_w[4] = 4'b0000;
                        stupid_move_queue_w[5] = 4'b0000;
                        stupid_move_queue_w[6] = 4'b0000;
                        stupid_move_queue_w[7] = 4'b0000;
                        stupid_move_queue_w[8] = 4'b0000;
                        stupid_move_queue_w[9] = 4'b0000;
                    end
                    14: begin // get 4 28
                        stupid_move_queue_w[0] = T_C;
                    end
                    15: begin // get 22 46
                        stupid_move_queue_w[0] = T_C;
                    end
                    16: begin // revert to original + get 17 41
                        stupid_move_queue_w[0] = T_C;
                        stupid_move_queue_w[1] = T_C;
                        stupid_move_queue_w[2] = R_C;
                        stupid_move_queue_w[3] = L_CC;
                        stupid_move_queue_w[4] = B_C;
                        stupid_move_queue_w[5] = F_CC;
                        stupid_move_queue_w[6] = D_C;
                        stupid_move_queue_w[7] = T_CC;
                    end
                    17: begin // get 11 35
                        stupid_move_queue_w[0] = T_C;
                        stupid_move_queue_w[1] = 4'b0000;
                        stupid_move_queue_w[2] = 4'b0000;
                        stupid_move_queue_w[3] = 4'b0000;
                        stupid_move_queue_w[4] = 4'b0000;
                        stupid_move_queue_w[5] = 4'b0000;
                        stupid_move_queue_w[6] = 4'b0000;
                        stupid_move_queue_w[7] = 4'b0000;
                    end
                    18: begin // get 5 29
                        stupid_move_queue_w[0] = T_C;
                    end
                    19: begin // get 23 47
                        stupid_move_queue_w[0] = T_C;
                    end
                    20: begin //revert to original + get bottom 18 42
                        stupid_move_queue_w[0] = T_C;
                        stupid_move_queue_w[1] = F_CC;
                        stupid_move_queue_w[2] = B_C;
                        stupid_move_queue_w[3] = R_CC;
                        stupid_move_queue_w[4] = R_CC;
                        stupid_move_queue_w[5] = L_C;
                        stupid_move_queue_w[6] = L_C;
                        stupid_move_queue_w[7] = F_CC;
                        stupid_move_queue_w[8] = B_C;
                    end
                    21: begin // get bottom 12 36
                        stupid_move_queue_w[0] = T_C;
                        stupid_move_queue_w[1] = 4'b0000;
                        stupid_move_queue_w[2] = 4'b0000;
                        stupid_move_queue_w[3] = 4'b0000;
                        stupid_move_queue_w[4] = 4'b0000;
                        stupid_move_queue_w[5] = 4'b0000;
                        stupid_move_queue_w[6] = 4'b0000;
                        stupid_move_queue_w[7] = 4'b0000;
                        stupid_move_queue_w[8] = 4'b0000;
                    end
                    22: begin // get 6 30
                        stupid_move_queue_w[0] = T_C;
                    end
                    23: begin // get 24 48
                        stupid_move_queue_w[0] = T_C;
                    end
                    24: begin // revert
                        stupid_move_queue_w[0] = T_C;
                        stupid_move_queue_w[1] = B_CC;
                        stupid_move_queue_w[2] = F_C;
                        stupid_move_queue_w[3] = L_CC;
                        stupid_move_queue_w[4] = L_CC;
                        stupid_move_queue_w[5] = R_C;
                        stupid_move_queue_w[6] = R_C;
                        stupid_move_queue_w[7] = B_CC;
                        stupid_move_queue_w[8] = F_C;
                    end
                endcase
            end
            S_STUPID:begin
                ack_w = 0;
                finished_w = 0;
                begin
                    if((!o_en_1 || !o_en_2 || !o_en_3 || !o_en_4 || !o_en_5 || !o_en_6) && start_r) begin
                        start_w = 0;
                        ack_w = 0; // 5/12 YI
                    end else begin
                        start_w = start_r;
                    end
                end
                if(o_done) begin
                    stupid_count_w = stupid_count_r + 1;
                    
                    if (stupid_count_r == 23) begin // initializatation complete                       
                        state_w = S_SOLVE; // wait for algortithm solving
                        finished_w = 1;
                        stupid_move_queue_w[0] = 4'b0000; // clear queue
                        stupid_move_queue_w[1] = 4'b0000;
                        stupid_move_queue_w[2] = 4'b0000;
                        stupid_move_queue_w[3] = 4'b0000;
                        stupid_move_queue_w[4] = 4'b0000;
                        stupid_move_queue_w[5] = 4'b0000;
                        stupid_move_queue_w[6] = 4'b0000;
                        stupid_move_queue_w[7] = 4'b0000;
                        stupid_move_queue_w[8] = 4'b0000;
                        stupid_move_queue_w[9] = 4'b0000;
                    end else begin
                        state_w = S_IDLE;
                    end
                end
                else begin
                    stupid_count_w = stupid_count_r;
                end
                
            end
            S_SOLVE:begin           
                if(i_start) begin
                    start_w = 1;
                    finished_w = 0;
                end 
                else begin
                    if((!o_en_1 || !o_en_2 || !o_en_3 || !o_en_4 || !o_en_5 || !o_en_6) && start_r) begin // directly come here if pre-detection happen
                        start_w = 0;
                    end 
                    else begin
                        start_w = start_r;
                    end
                end
            end
        endcase
        
    end
    
    always_ff @( posedge i_clk or negedge i_rst_n) begin
        if (!i_rst_n) begin
            for(i = 0; i < 256; i++) begin
                stupid_move_queue_r[i] <= 4'b0000;
            end
            state_r <= S_SOLVE;
            count_r <= 0;
            clk_r <= 0;
            start_r <= 0;
            ack_r <= 0;
            stupid_count_r <= 0;
            finished_r <= 0;
        end
        else begin
            for(i = 0; i < 256; i++) begin
                stupid_move_queue_r[i] <= stupid_move_queue_w[i];
            end
            count_r <= count_w;
            clk_r <= clk_w;
            start_r <= start_w;
            state_r <= state_w;
            ack_r <= ack_w;
            stupid_count_r <=  stupid_count_w;
            finished_r <= finished_w;
        end
    end
endmodule


module En_Ctrl (
    input i_clk,
    input i_rst_n,
    input i_start,
    input [3:0] i_move_queue[0:255],
    
    output en_1, //whit
    output en_2, //green
    output en_3, //red
    output en_4, //blue
    output en_5, //orange
    output en_6, //yellow
    output dir,
    output step,
    output done,
    output [3:0] move
);

//declaration

parameter S_IDLE = 2'd0;  
parameter S_PROC = 2'd1;
parameter S_WAIT = 2'd2;

logic [3:0] current_move;
logic [9:0] step_count_w, step_count_r;
logic [7:0] move_count_w, move_count_r;
logic done_w, done_r;
logic [1:0] state_w, state_r;

assign move =  i_move_queue[move_count_r];
assign current_move =  i_move_queue[move_count_r];
assign dir = !current_move[3];
assign step = i_clk;
assign en_1 = (state_r == S_PROC && current_move[2:0] == 3'd1) ? 0 : 1;
assign en_2 = (state_r == S_PROC && current_move[2:0] == 3'd2) ? 0 : 1;
assign en_3 = (state_r == S_PROC && current_move[2:0] == 3'd3) ? 0 : 1;
assign en_4 = (state_r == S_PROC && current_move[2:0] == 3'd4) ? 0 : 1;
assign en_5 = (state_r == S_PROC && current_move[2:0] == 3'd5) ? 0 : 1;
assign en_6 = (state_r == S_PROC && current_move[2:0] == 3'd6) ? 0 : 1;
assign done = done_r;


always_comb begin
    state_w = state_r;
    step_count_w = step_count_r;
    done_w = done_r;
    move_count_w = move_count_r;
    case (state_r)
        S_IDLE: begin
            done_w = 0;
            if (i_start) begin
                state_w = S_PROC;
                step_count_w = 0;
            end
        end 
        S_PROC: begin
            if (step_count_r == 50) begin
                state_w = S_WAIT;
                step_count_w = 0;
                move_count_w = move_count_r + 1;
                if (i_move_queue[move_count_r + 1][3:0] == 4'b0000) begin
                    state_w = S_IDLE;
                    done_w = 1;
                    move_count_w = 0;
                end
            end
            else begin
                step_count_w = step_count_r + 1;
                
            end
        end
        S_WAIT:begin
            if(step_count_r == 100)begin
                state_w = S_PROC;
                step_count_w = 0;
            end
            else  begin
                step_count_w = step_count_r+1;
            end
        end
    endcase
end

always_ff @( posedge i_clk or negedge i_rst_n ) begin
    if (!i_rst_n) begin
        state_r <= S_IDLE;
        move_count_r <= 0;
        step_count_r <= 0;
        done_r <= 0;
    end
    else begin
        state_r <= state_w;
        move_count_r <= move_count_w;
        step_count_r <= step_count_w;
        done_r <= done_w;
    end
end
endmodule