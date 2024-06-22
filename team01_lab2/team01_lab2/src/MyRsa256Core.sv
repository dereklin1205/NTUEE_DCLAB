module Rsa256Core (
input i_clk,
input i_rst,
input i_start,
input [255:0] i_a, // cipher text y
input [255:0] i_d, // private key
input [255:0] i_n,
output [255:0] o_a_pow_d, // plain text x
output o_finished
);

// operations for RSA256 decryption
// namely, the Montgomery algorithm

// ---------------------------------- parameter -------------------------------//

parameter S_IDLE = 2'b00;
parameter S_PREP = 2'b01;
parameter S_MONT = 2'b10;
parameter S_CALC = 2'b11;

//----------------------------------- registers -------------------------------//

//state
reg[1:0] state_r, state_w;

//counter 0 - 256
reg[8:0] counter_r, counter_w;

// m and t
reg[255:0] m_r, m_w, t_r, t_w, a_store_r, a_store_w, dec_w, dec_r;

reg enable_m_r, enable_m_w, p_start_w, p_start_r;
// reg reset_w, reset_r;

//output assignment
reg[255:0] out_r, out_w;
reg o_finished_r, o_finished_w;
assign o_a_pow_d = out_r;
assign o_finished = o_finished_r;

//wires
wire[255:0] mont_m, mont_t, mp_t;
wire done_m, done_t, done_mp_t;

ModuloProduct product(
.i_start(p_start_r),
.i_clk(i_clk),
.i_rst(i_rst),
// .rst(reset_r),
.i_N(i_n),
.i_b(a_store_r),
.o_result(mp_t),
.o_done(done_mp_t)
);

Montgomery calc_m (
.m_start(enable_m_r),
.i_clk(i_clk),
.i_rst(i_rst),
// .rst(reset_r),
.i_N(i_n),
.i_a(m_r), // m
.i_b(t_r), // t
.o_result(mont_m),
.o_done(done_m)
);

Montgomery calc_t(
.m_start(enable_m_r),
.i_clk(i_clk),
.i_rst(i_rst),
// .rst(reset_r),
.i_N(i_n),
.i_a(t_r), // t
.i_b(t_r), // t
.o_result(mont_t),
.o_done(done_t)
);

//------------------------------------ fsm ------------------------------------//

always_comb begin
    a_store_w = a_store_r;
counter_w = counter_r;
p_start_w = 0;
dec_w = dec_r;
// reset_w = 0;
case(state_r)
S_IDLE:begin
if(i_start)begin
// $display("i_start");
state_w = S_PREP;
a_store_w = i_a;
p_start_w = 1;
dec_w = i_d;
end else begin
// $display("??????");
state_w = S_IDLE;
a_store_w = a_store_r;

end

end

S_PREP:begin
if(done_mp_t)begin
state_w = S_MONT;
end else begin
state_w = S_PREP;
end
end

S_MONT:begin
if(done_m & done_t)begin
state_w = S_CALC;
counter_w = counter_r + 1;
dec_w = dec_r >> 1;
end else begin
state_w = S_MONT;
end
end

S_CALC:begin
if(counter_r[8]) begin
state_w = S_IDLE;
counter_w = 0;
// reset_w = 1;
end else begin
state_w = S_MONT;
end
end

default: begin
state_w = S_IDLE;
end
endcase
end


//--------------------------- COMBINATIONAL CIRCUIT ---------------------------//



always_comb begin
enable_m_w = 0;
case(state_r)
S_IDLE:begin
//$display("S_Idle");
m_w = m_r;
t_w = t_r;
o_finished_w = 0;
out_w = out_r;
end

S_PREP:begin
//$display("S_Prep");
o_finished_w = o_finished_r;
out_w = out_r;
if(done_mp_t)begin
t_w = mp_t;
//$display("%h ", mp_t);
m_w = 1;
enable_m_w = 1;
end else begin
t_w = t_r;
m_w = m_r;
end
end

S_MONT:begin
//$display("S_Mont");
o_finished_w = o_finished_r;
out_w = out_r;
// $display("%d",m_w);
if(done_m & done_t)begin
if(dec_r[0]) begin
m_w = mont_m;
end else begin
m_w = m_r;
end
t_w = mont_t;

end else begin
t_w = t_r;
m_w = m_r;
end
end

S_CALC:begin
//$display("S_Calc");
t_w = t_r;
m_w = m_r;
if(counter_r[8]) begin
o_finished_w = 1;
out_w = m_r;
end else begin
o_finished_w = o_finished_r;
out_w = out_r;
enable_m_w = 1;
end

end

default: begin
m_w = m_r;
t_w = t_r;
o_finished_w = o_finished_r;
out_w = out_r;
end
endcase
end






//---------------------------- SEQUENTIAL CIRCUIT ----------------------------//

always_ff @(posedge i_clk or posedge i_rst) begin
if(i_rst) begin
m_r <= 0;
t_r <= 0;
counter_r <= 0;
state_r <= S_IDLE;
out_r <= 0;
o_finished_r <= 0;
enable_m_r <= 0;
p_start_r <= 0;
a_store_r <= 0;
dec_r <= 0;
// reset_r <= 0;
end else begin
m_r <= m_w;
t_r <= t_w;
counter_r <= counter_w;
state_r <= state_w;
out_r <= out_w;
o_finished_r <= o_finished_w;
enable_m_r <= enable_m_w;
p_start_r <= p_start_w;
a_store_r <= a_store_w;
dec_r <= dec_w;
// reset_r <= reset_w;
end
end
endmodule



module Montgomery(
input m_start,
input i_clk,
input i_rst,
// input rst,
input [255:0] i_N,
input [255:0] i_a,
input [255:0] i_b,
output [255:0] o_result,
output o_done
);

logic [257:0] m_r, m_w, a_r, a_w;
logic [8:0] counter_r, counter_w;
logic done_w, done_r;

// assign output
assign o_done = done_r;
assign o_result = m_r[255:0];

always_comb begin
//initialize
case (counter_r)
    0: begin
        m_w = 0;
        a_w = i_a;
        done_w = 0;
        if(m_start) begin
            counter_w = counter_r + 1;
        end else begin
            counter_w = counter_r;
        end    
    end
    257: begin
        a_w = a_r;
        done_w = 0;
        if(m_r >= i_N)begin
            m_w = m_r - i_N ;
        end else begin
            m_w = m_r ;
        end
        counter_w = counter_r + 1;
    end
    258: begin
        a_w = a_r;
        done_w = 1;
        m_w = m_r ;
        //$display("result: %h ", o_result);
        counter_w = 0;
    end
    default: begin

    done_w = 0;
    case ({a_r[0], m_r[0], i_b[0]})

    // m = (m + b )/2 even
    3'b100:begin
        m_w = (m_r + i_b) >> 1;
    end
    3'b111: begin
        m_w = (m_r + i_b) >> 1;
    end

    // m = (m + b + N)
    // maybe overflow ---------------------------------------------------------- check !!!!!!!!!!!!!!!
    3'b101:begin
        m_w = (m_r + i_b + i_N) >> 1;
    end
    3'b110:begin
        m_w = (m_r + i_b + i_N) >> 1;
    end


    // m = (m + n )/2
    3'b011:begin
        m_w = (m_r + i_N) >> 1;
    end
    3'b010:begin
        m_w = (m_r + i_N) >> 1;
    end


    default: begin
        m_w = m_r >> 1;
    end
endcase
// if(counter_r <= 3) begin
// $display("m_w:%d m_r:%d i_N:%h i_a:%h i_b:%h",m_w,m_r,i_N, i_b, i_a);
// end


    a_w = a_r >> 1;
    counter_w = counter_r + 1;
end
endcase
end

always_ff @(posedge i_clk or posedge i_rst) begin
    if(i_rst)begin
        counter_r <= 0;
        m_r <= 0;
        done_r <= 0;
        a_r <= 0;
    end else begin
        a_r <= a_w;
        counter_r <= counter_w;
        m_r <= m_w;
        done_r <= done_w;
    end
end

endmodule

module ModuloProduct(
input i_start,
input i_clk,
input i_rst,
// input rst,
input [255:0] i_N,
input [255:0] i_b,
output [255:0] o_result,
output o_done
);

// counter from 0 ~ k

logic[256:0] t_r, t_w;
logic [8:0] counter_r, counter_w;
logic done_w, done_r;


// assign output
assign o_done = done_r;
assign o_result = t_r[255:0];

always_comb begin
//initialize
    case (counter_r)
        0: begin
        if(i_start) begin
            counter_w = counter_r + 1;
            t_w = i_b;
            done_w = 0;
        end else begin
            counter_w = 0;
            t_w = t_r;
            done_w = 0;
        end

        end
        257: begin
        // $display("t_r %d", t_r);
            done_w = 1;
            t_w = t_r;
            counter_w = 0;
        end
        default: begin
            done_w = 0;
        if ((t_r + t_r) >= i_N)begin
            t_w = (t_r << 1) - i_N;
        end else begin
            t_w = t_r << 1 ;
        end
        counter_w = counter_r + 1;
        //$display("now t_r%d", t_r);
        end
    endcase
end



//sequential

always_ff @(posedge i_clk or posedge i_rst) begin
    if(i_rst)begin
        counter_r <= 0;
        t_r <= 0;
        done_r <= 0;
    end else begin
        counter_r <= counter_w;
        t_r <= t_w;
        done_r <= done_w;
    end

end

endmodule