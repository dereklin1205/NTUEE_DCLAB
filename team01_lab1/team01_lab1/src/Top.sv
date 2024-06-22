module Top (
        input        i_clk,
        input        i_rst_n,
        input        i_start,
        output [3:0] o_random_out,
        output [3:0] o_random_out2,
        output o_LEDG,
        output [3:0]o_LEDR
);
// ===== States =====
parameter S_IDLE = 1'b0;
parameter S_PROC = 1'b1;

// speed stages

parameter STAGE = 32'd33554432;


// ===== Output Buffers =====
reg [3:0] o_random_out_r, o_random_out_w;
reg [3:0] o_random_out2_r, o_random_out2_w;
// ===== Registers & Wires =====
reg state_r, state_w;
reg LEDG_r, LEDG_w;
reg [2:0] LEDR_r, LEDR_w;
assign o_LEDG = LEDG_r;
assign o_LEDR = LEDR_r;
// ===== Output Assignments =====
assign o_random_out = o_random_out_r;
assign o_random_out2 = o_random_out2_r;
// registers

reg  [31:0] counter_large_r, counter_large_w;
reg [2:0] stage_r, stage_w;


// ===== Combinational Circuits =====
always @(*) begin

        // FSM
        case(state_r)
        S_IDLE: begin
        
        if (i_start) begin
            o_random_out2_w = o_random_out_r;
            state_w = S_PROC;
            LEDR_w = 4'b0001;
            LEDG_w = 0;
            o_random_out_w = counter_large_r[3:0];// function of counter;
            stage_w =stage_r;
            counter_large_w = 0;
        end else begin
            o_random_out2_w = o_random_out2_r;
            state_w = S_IDLE;
            LEDR_w = 4'b0000;
            LEDG_w = 1;
            stage_w =stage_r;
            o_random_out_w = o_random_out_r;
            if(counter_large_r == 15) begin
                counter_large_w = 0;
            end else begin
                counter_large_w = counter_large_r + 1;
            end

        end
        end

        S_PROC: begin
            
            case(stage_r)
            4'd0:begin
                case({counter_large_r>STAGE,i_start})
                2'b00:begin
                    LEDG_w = LEDG_r;
                    LEDR_w = LEDR_r;
                    // global counter assignment
                    counter_large_w = counter_large_r + 1;
                    o_random_out2_w = o_random_out2_r;
                    // stage assignment
                    stage_w = stage_r;

                    //number generator => change every 1024 clock cycles
                    if(counter_large_r[21:0] == 0) begin
                        o_random_out_w = {o_random_out_r[2:0],(o_random_out_r[3]^o_random_out_r[2])};
                        // reset counter every new number
                    end else begin
                        o_random_out_w = o_random_out_r;
                    end
                    state_w = state_r;
                end

                2'b10:begin
                    o_random_out2_w = o_random_out2_r;
                    counter_large_w = 1;
                    stage_w = 4'd1;
                    LEDG_w = LEDG_r;
                    LEDR_w = 4'b0011;
                    o_random_out_w = o_random_out_r;
                    state_w = state_r;
                end
                2'b11:begin
                    LEDG_w = 1;
                    LEDR_w = 4'b0000;
                    counter_large_w = counter_large_r;
                    stage_w = 0;
                   o_random_out2_w = o_random_out2_r;
                    state_w = S_IDLE; 
                    o_random_out_w = o_random_out_r;
                end
                2'b01:begin
                    LEDG_w = 1;
                    LEDR_w = 4'b0000;
                   o_random_out2_w = o_random_out2_r;
                    counter_large_w = counter_large_r;
                    stage_w = 0;
                    state_w = S_IDLE; 
                    o_random_out_w = o_random_out_r;
                end
                default:begin
                    LEDG_w = 1;
                    LEDR_w = 4'b0000;
                   o_random_out2_w = o_random_out2_r;
                    counter_large_w = counter_large_r;
                    stage_w = 0;
                    state_w = S_IDLE; 
                    o_random_out_w = o_random_out_r;
                end
            endcase
            
            

                // state assignment 
                


            end
             4'd1:begin
                case({counter_large_r>STAGE,i_start})
                2'b00:begin
                    o_random_out2_w = o_random_out2_r;
                    // global counter assignment
                    counter_large_w = counter_large_r + 1;
                    LEDG_w = LEDG_w;
                    LEDR_w = LEDR_r;
                    // stage assignment
                    stage_w = stage_r;

                    //number generator => change every 1024 clock cycles
                    if(counter_large_r[22:0] == 0) begin
                        o_random_out_w = {o_random_out_r[2:0],(o_random_out_r[3]^o_random_out_r[2])};
                        // reset counter every new number
                    end else begin
                        o_random_out_w = o_random_out_r;
                    end
                    state_w = state_r;
                end

                2'b10:begin
                    o_random_out2_w = o_random_out2_r;
                    counter_large_w = 1;
                    stage_w = 4'd2;
                    LEDG_w = LEDG_r;
                    LEDR_w = 4'b0111;
                    o_random_out_w = o_random_out_r;
                    state_w = state_r;
                end
                2'b11:begin
                    LEDG_w = 1;
                    LEDR_w = 4'b0000;
                    counter_large_w = counter_large_r;
                    stage_w = 0;
                   o_random_out2_w = o_random_out2_r;
                    state_w = S_IDLE; 
                    o_random_out_w = o_random_out_r;
                end
                2'b01:begin
                    LEDG_w = 1;
                    LEDR_w = 4'b0000;
                    counter_large_w = counter_large_r;
                    stage_w = 0;
                   o_random_out2_w = o_random_out2_r;
                    state_w = S_IDLE; 
                    o_random_out_w = o_random_out_r;
                end
                default:begin
                    LEDG_w = 1;
                    LEDR_w = 4'b0000;
                    counter_large_w = counter_large_r;
                    stage_w = 0;
                   o_random_out2_w = o_random_out2_r;
                    state_w = S_IDLE; 
                    o_random_out_w = o_random_out_r;
                end
            endcase
            
            

                // state assignment 
                


            end
             4'd2:begin
                case({counter_large_r>STAGE,i_start})
                2'b00:begin
                    o_random_out2_w = o_random_out2_r;
                    // global counter assignment
                    counter_large_w = counter_large_r + 1;
                     LEDG_w = LEDG_r;
                    LEDR_w = LEDR_r;
                    // stage assignment
                    stage_w = stage_r;

                    //number generator => change every 1024 clock cycles
                    if(counter_large_r[23:0] == 0) begin
                        o_random_out_w = {o_random_out_r[2:0],(o_random_out_r[3]^o_random_out_r[2])};
                        // reset counter every new number
                    end else begin
                        o_random_out_w = o_random_out_r;
                    end
                    state_w = state_r;
                end

                2'b10:begin
                    LEDG_w = LEDG_r;
                    LEDR_w = 4'b1111;
                    o_random_out2_w = o_random_out2_r;
                    counter_large_w = 1;
                    stage_w = 4'd3;
                    o_random_out_w = o_random_out_r;
                    state_w = state_r;
                end
                2'b11:begin
                    LEDG_w = 1;
                    LEDR_w = 4'b0000;
                    counter_large_w = counter_large_r;
                    stage_w = 0;
                   o_random_out2_w = o_random_out2_r;
                    state_w = S_IDLE; 
                    o_random_out_w = o_random_out_r;
                end
                2'b01:begin
                    LEDG_w = 1;
                    LEDR_w = 4'b0000;
                    counter_large_w = counter_large_r;
                    stage_w = 0;
                   o_random_out2_w = o_random_out2_r;
                    state_w = S_IDLE; 
                    o_random_out_w = o_random_out_r;
                end
                default:begin
                    LEDG_w = 1;
                    LEDR_w = 4'b0000;
                    counter_large_w = counter_large_r;
                    stage_w = 0;
                   o_random_out2_w = o_random_out2_r;
                    state_w = S_IDLE; 
                    o_random_out_w = o_random_out_r;
                end
            endcase
            
            

                // state assignment 
                


            end
            4'd3:begin
                case({counter_large_r>STAGE,i_start})
                2'b00:begin
                    LEDG_w = LEDG_r;
                    LEDR_w = LEDR_r;
                    o_random_out2_w = o_random_out2_r;
                    // global counter assignment
                    counter_large_w = counter_large_r + 1;

                    // stage assignment
                    stage_w = stage_r;

                    //number generator => change every 1024 clock cycles
                    if(counter_large_r[24:0] == 0) begin
                        o_random_out_w = {o_random_out_r[2:0],(o_random_out_r[3]^o_random_out_r[2])};
                        // reset counter every new number
                    end else begin
                        o_random_out_w = o_random_out_r;
                    end
                    state_w = state_r;
                end

                2'b10:begin
                    counter_large_w = 1;
                    stage_w = 0;
                    o_random_out2_w = o_random_out2_r;
                    o_random_out_w = o_random_out_r;
                    state_w = S_IDLE;
                    LEDG_w = 1;
                    LEDR_w = 4'b0000;
                end
                2'b11:begin
                    LEDG_w = 1;
                    LEDR_w = 4'b0000;
                    counter_large_w = counter_large_r;
                    stage_w = 0;
                    o_random_out2_w = o_random_out2_r;
                    state_w = S_IDLE; 
                    o_random_out_w = o_random_out_r;
                end
                2'b01:begin
                    LEDG_w = 1;
                    LEDR_w = 4'b0000;
                    counter_large_w = counter_large_r;
                    stage_w = 0;
                    o_random_out2_w = o_random_out2_r;
                    state_w = S_IDLE; 
                    o_random_out_w = o_random_out_r;
                end
                default:begin
                    LEDG_w = 1;
                    LEDR_w = 4'b0000;
                    counter_large_w = counter_large_r;
                    stage_w = 0;
                    o_random_out2_w = o_random_out2_r;
                    state_w = S_IDLE; 
                    o_random_out_w = o_random_out_r;
                end
            endcase
            
            

                // state assignment 
                


            end

            default:begin
                counter_large_w = 0;
                stage_w = 4'd0;
                state_w = S_IDLE;
                LEDG_w = 1;
                LEDR_w = 4'b0000;
                o_random_out2_w = o_random_out2_r;
                o_random_out_w = o_random_out_r;
            end

            endcase
        end
        default:begin
            counter_large_w = 0;
            stage_w = 4'd0;
            LEDG_w = 1;
            LEDR_w = 4'b0000;
            o_random_out2_w = o_random_out2_r;
            state_w = S_IDLE;
            o_random_out_w = o_random_out_r;
        
        end
        endcase
end


// ===== Sequential Circuits =====
always @(posedge i_clk or negedge i_rst_n) begin
        // reset
        if (!i_rst_n) begin
        o_random_out_r <= 4'd0;
        state_r        <= S_IDLE;
        counter_large_r <= 4'd0;
        stage_r <= 0;
        o_random_out2_r<=4'd0;
        LEDG_r = 1;
        LEDR_r = 4'b0000;
        end
        else begin
        o_random_out_r <= o_random_out_w;
        state_r        <= state_w;
        counter_large_r <= counter_large_w;
        stage_r <= stage_w;
        LEDG_r <=LEDG_w;
        LEDR_r <= LEDR_w;
        o_random_out2_r<=o_random_out2_w;
        end
end


endmodule