module motor(
    input clk,
    input rst_n,
    input motor_start,
    input i_dd_done,
    input [2:0] color,
    input [3:0] m_s [0:31],
    output motor_done,
    output [3:0] move_queue[0:255]
);


parameter CHANGE_VIEW = 4'b0001;
parameter F_C = 4'b0010;
parameter F_CC = 4'b0011;
parameter R_C = 4'b0100;
parameter R_CC = 4'b0101;
parameter L_C = 4'b0110;
parameter L_CC = 4'b0111;
parameter T_C = 4'b1000;
parameter T_CC = 4'b1001;
parameter B_C = 4'b1010;
parameter B_CC = 4'b1011;
parameter D_C = 4'b1100;
parameter D_CC = 4'b1101;
parameter F_T_T = 4'b1111;



parameter S_IDLE = 0;
parameter S_QUEUE = 1;
parameter S_OUTPUT= 2;


logic [2:0] state_w, state_r;

// counters
logic [4:0] load_count_w, load_count_r; // index for loaded moves => 0 to 31
logic [7:0] queue_count_w, queue_count_r; // index for move_queue => 0 to 255
logic front_to_top_counter_w, front_to_top_counter_r;

// move sequence
logic [3:0] sequence_w [0:31], sequence_r [0:31]; // load moves to sequence

// queue
logic [3:0] move_queue_w[0:255], move_queue_r[0:255];// bit 0-2 encode motor number, bit 3 encodes direction (0 is clockwise)

// control signal
logic queue_done_w, queue_done_r;
logic [2:0] color_w, color_r;
logic white_top_w, white_top_r;

//output assign
assign move_queue = move_queue_r;
assign motor_done = queue_done_r;


integer i, j;

//FSM
always_comb begin
    state_w = state_r;
    case (state_r)
        S_IDLE: begin
            if(motor_start) begin
                state_w = S_QUEUE;
            end
        end
        S_QUEUE: begin
            if(queue_done_r) begin 
                state_w = S_IDLE;
            end
        end
    endcase
end


//combinational
always_comb begin
    load_count_w = load_count_r;
    queue_done_w = queue_done_r;
    white_top_w = white_top_r;
    front_to_top_counter_w = front_to_top_counter_r;
    color_w = color_r;
    queue_count_w = queue_count_r;
    for(i = 0; i < 32; i = i+1) begin
        sequence_w[i] = sequence_r[i];
    end
    for(i = 0; i < 256; i = i+1) begin
        move_queue_w[i] = move_queue_r[i];
    end
    case(state_r) 
        S_IDLE : begin
            load_count_w = 0;  
            if(motor_start) begin
                for(i = 0; i < 32; i = i+1) begin
                    sequence_w[i] = m_s[i];
                end
                
            end
            queue_done_w = 0;
            queue_count_w = queue_count_r;
            if(i_dd_done) begin
                for(i = 0; i < 256; i = i+1) begin
                    move_queue_w[i] = 0;
                end
                queue_count_w = 0;
            end
        end
        S_QUEUE: begin
            load_count_w = load_count_r + 1;
            
             // load until 0000
            if(!queue_done_r)begin
                case (sequence_r[load_count_r]) // decode moves based on current color
                    CHANGE_VIEW: begin
                        if(white_top_r) begin // change center view based on whether white is on top or not
                            if(color_r == 4) begin
                                color_w = 1;
                            end else begin
                                color_w = color_r + 1;
                            end
                        end else begin
                            if(color_r == 1) begin
                                color_w = 4;
                            end else begin
                                color_w = color_r - 1;
                            end
                        end
                        queue_count_w = queue_count_r; // don't queue change move
                    end 
                    F_C: begin // motor number is the same as the face number
                        // front clockwise is independent of whether the top is yellor or white
                        move_queue_w[queue_count_r][2:0] = color_r+1;
                        move_queue_w[queue_count_r][3] = 0;
                        queue_count_w = queue_count_r+1;
                    end
                    F_CC:begin
                        move_queue_w[queue_count_r][2:0] = color_r+1;
                        move_queue_w[queue_count_r][3] = 1;
                        queue_count_w = queue_count_r+1;
                    end
                    R_C: begin
                        if(white_top_r) begin   // if white is on top
                            if(color_r < 4) begin // motor number is the next side
                                move_queue_w[queue_count_r][2:0] = color_r + 1+1;
                            end else begin
                                move_queue_w[queue_count_r][2:0] = 1+1;
                            end                
                            move_queue_w[queue_count_r][3] = 0;
                        end else begin
                            if(color_r > 1) begin // motor number is the previous side
                                move_queue_w[queue_count_r][2:0] = color_r - 1+1;
                            end else  begin
                                move_queue_w[queue_count_r][2:0] = 4+1;
                            end                
                            move_queue_w[queue_count_r][3] = 0;
                        end
                        queue_count_w = queue_count_r+1;
                    end
                    R_CC: begin
                        if(white_top_r) begin   // if white is on top
                            if(color_r < 4) begin // motor number is the next side
                                move_queue_w[queue_count_r][2:0] = color_r + 1+1;
                            end else begin
                                move_queue_w[queue_count_r][2:0] = 1+1;
                            end                
                            move_queue_w[queue_count_r][3] = 1;
                        end else begin
                            if(color_r > 1) begin // motor number is the previous side
                                move_queue_w[queue_count_r][2:0] = color_r - 1+1;
                            end else begin
                                move_queue_w[queue_count_r][2:0] = 4+1;
                            end                
                            move_queue_w[queue_count_r][3] = 1;
                        end
                        queue_count_w = queue_count_r+1;
                    end
                    L_C: begin
                        if(white_top_r) begin   // if white is on top              
                            if(color_r > 1) begin // motor number is the previous side
                                move_queue_w[queue_count_r][2:0] = color_r - 1+1;
                            end else begin
                                move_queue_w[queue_count_r][2:0] = 4+1;
                            end                
                            move_queue_w[queue_count_r][3] = 0;
                            
                        end else begin
                            if(color_r < 4) begin // motor number is the next side
                                move_queue_w[queue_count_r][2:0] = color_r + 1+1;
                            end else begin
                                move_queue_w[queue_count_r][2:0] = 1+1;
                            end                
                            move_queue_w[queue_count_r][3] = 0;
                        end
                        queue_count_w = queue_count_r+1;
                    end
                    L_CC: begin
                        if(white_top_r) begin   // if white is on top              
                            if(color_r > 1) begin // motor number is the previous side
                                move_queue_w[queue_count_r][2:0] = color_r - 1+1;
                            end else begin
                                move_queue_w[queue_count_r][2:0] = 4+1;
                            end                
                            move_queue_w[queue_count_r][3] = 1;
                            
                        end else begin
                            if(color_r < 4) begin // motor number is the next side
                                move_queue_w[queue_count_r][2:0] = color_r + 1+1;
                            end else begin
                                move_queue_w[queue_count_r][2:0] = 1+1;
                            end                
                            move_queue_w[queue_count_r][3] = 1;
                        end
                        queue_count_w = queue_count_r+1;
                    end
                    T_C: begin
                        if(white_top_r) begin // motor number is white => 0
                            move_queue_w[queue_count_r][2:0] = 0+1;
                            move_queue_w[queue_count_r][3] = 0;
                        end else begin // motor number is yellor => 5
                            move_queue_w[queue_count_r][2:0] = 5+1;
                            move_queue_w[queue_count_r][3] = 0;
                        end
                        queue_count_w = queue_count_r+1;
                    end
                    T_CC: begin
                        if(white_top_r) begin // motor number is white => 0
                            move_queue_w[queue_count_r][2:0] = 0+1;
                            move_queue_w[queue_count_r][3] = 1;
                        end else begin // motor number is yellor => 5
                            move_queue_w[queue_count_r][2:0] = 5+1;
                            move_queue_w[queue_count_r][3] = 1;
                        end
                        queue_count_w = queue_count_r+1;
                    end
                    B_C: begin
                        if(color_r < 3) begin
                            move_queue_w[queue_count_r][2:0] = color_r + 2+1;
                            move_queue_w[queue_count_r][3] = 0;
                        end else begin
                            move_queue_w[queue_count_r][2:0] = color_r - 2+1;
                            move_queue_w[queue_count_r][3] = 0;
                        end
                        queue_count_w = queue_count_r+1;
                    end
                    B_CC: begin
                        if(color_r < 3) begin
                            move_queue_w[queue_count_r][2:0] = color_r + 2+1;
                            move_queue_w[queue_count_r][3] = 1;
                        end else begin
                            move_queue_w[queue_count_r][2:0] = color_r - 2+1;
                            move_queue_w[queue_count_r][3] = 1;
                        end
                        queue_count_w = queue_count_r+1;
                    end
                    D_C: begin
                        if(white_top_r) begin // motor number is yellow => 5
                            move_queue_w[queue_count_r][2:0] = 5+1;
                            move_queue_w[queue_count_r][3] = 0;
                        end else begin // motor number is white => 0
                            move_queue_w[queue_count_r][2:0] = 0+1;
                            move_queue_w[queue_count_r][3] = 0;
                        end
                        queue_count_w = queue_count_r+1;
                    end
                    D_CC: begin
                        if(white_top_r) begin // motor number is yellow => 5
                            move_queue_w[queue_count_r][2:0] = 5+1;
                            move_queue_w[queue_count_r][3] = 1;
                        end else begin // motor number is white => 0
                            move_queue_w[queue_count_r][2:0] = 0+1;
                            move_queue_w[queue_count_r][3] = 1;
                        end
                        queue_count_w = queue_count_r+1;
                    end
                    F_T_T: begin // every two ftt change the top
                        if(front_to_top_counter_r) begin
                            white_top_w = !white_top_r;
                            if(color_r > 3) begin
                                color_w = color_r - 2;
                            end else begin
                                color_w = color_r + 2;
                            end
                        end 
                        front_to_top_counter_w = !front_to_top_counter_w;
                        queue_count_w = queue_count_r; // dont queue ftt
                        
                    end
                    4'b0000: begin //NOP
                        queue_count_w = queue_count_r; // don't increase queue count
                        load_count_w = 0; // reset load count
                        queue_done_w = 1; // open done signal
                    end
                    default: begin
                        //$display("decoding error");
                        load_count_w = 0;
                        queue_count_w = queue_count_r;
                        queue_done_w = 1;
                    end
                endcase
            end       
        end
    endcase
end

//sequential circuit
always_ff @(posedge clk or negedge rst_n ) begin
    if(!rst_n) begin
        state_r <= S_IDLE;
        load_count_r <= 0;
        queue_count_r <= 0;
        queue_done_r <= 0;
        white_top_r <= 1;
        color_r <= 1;
        for(j = 0; j < 32; j = j+1) begin
            sequence_r[j] <= 0;
        end
        for(j = 0; j < 256; j = j+1) begin
            move_queue_r[j] <=0;
        end
        front_to_top_counter_r <= 0;
    end else begin
        state_r <= state_w;
        load_count_r <= load_count_w;
        queue_count_r <= queue_count_w;
        queue_done_r <= queue_done_w;
        white_top_r <= white_top_w;
        color_r <= color_w;
        move_queue_r <= move_queue_w;
        sequence_r <= sequence_w;
        front_to_top_counter_r <= front_to_top_counter_w;
    end
end

endmodule