module State_Determination (
    input i_clk,
    input i_rst_n,
    input i_start,
    input [3:0] i_move_combo [0:31],
    input [2:0] i_init_c_state [0:47],
    input i_alg_done,

    output o_done,
    output [2:0] o_next_c_state [0:47]
);
// state declaration
parameter S_IDLE = 0;
parameter S_PROC = 1;
parameter S_WAIT = 2;

//register declaration
logic [2:0] state_w, state_r;
logic [2:0] c_state_w[0:47],  c_state_r [0:47];
logic [3:0] move_combo_w[0:31], move_combo_r [0:31]; // 31 steps at most
logic [6:0] move_count_w,  move_count_r;
logic done_w, done_r;
int i;
int k;
int j;
//assignment
assign o_done = done_r;
assign o_next_c_state = c_state_r;

// task declaration
task change_view;
  input [2:0] i_c_state [0:47];
 output [2:0] o_c_state[0:47];
 begin
  o_c_state[0] = i_c_state[1];
  o_c_state[1] = i_c_state[2];
  o_c_state[2] = i_c_state[3];
  o_c_state[3] = i_c_state[0];
  o_c_state[4] = i_c_state[22];
  o_c_state[5] = i_c_state[11];
  o_c_state[6] = i_c_state[7];
  o_c_state[7] = i_c_state[8];
  o_c_state[8] = i_c_state[9];
  o_c_state[9] = i_c_state[6];
  o_c_state[10] = i_c_state[4];
  o_c_state[11] = i_c_state[17];
  o_c_state[12] = i_c_state[13];
  o_c_state[13] = i_c_state[14];
  o_c_state[14] = i_c_state[15];
  o_c_state[15] = i_c_state[12];
  o_c_state[16] = i_c_state[10];
  o_c_state[17] = i_c_state[23];
  o_c_state[18] = i_c_state[19];
  o_c_state[19] = i_c_state[20];
  o_c_state[20] = i_c_state[21];
  o_c_state[21] = i_c_state[18];
  o_c_state[22] = i_c_state[16];
  o_c_state[23] = i_c_state[5];
  o_c_state[24] = i_c_state[25];
  o_c_state[25] = i_c_state[26];
  o_c_state[26] = i_c_state[27];
  o_c_state[27] = i_c_state[24];
  o_c_state[28] = i_c_state[46];
  o_c_state[29] = i_c_state[35];
  o_c_state[30] = i_c_state[31];
  o_c_state[31] = i_c_state[32];
  o_c_state[32] = i_c_state[33];
  o_c_state[33] = i_c_state[30];
  o_c_state[34] = i_c_state[28];
  o_c_state[35] = i_c_state[41];
  o_c_state[36] = i_c_state[37];
  o_c_state[37] = i_c_state[38];
  o_c_state[38] = i_c_state[39];
  o_c_state[39] = i_c_state[36];
  o_c_state[40] = i_c_state[34];
  o_c_state[41] = i_c_state[47];
  o_c_state[42] = i_c_state[43];
  o_c_state[43] = i_c_state[44];
  o_c_state[44] = i_c_state[45];
  o_c_state[45] = i_c_state[42];
  o_c_state[46] = i_c_state[40];
  o_c_state[47] = i_c_state[29];
  end
  endtask
task Front_clockwise;
  input [2:0] i_c_state [0:47];
 output [2:0] o_c_state[0:47];
 begin
  o_c_state[6] = i_c_state[0];
  o_c_state[11] = i_c_state[1];
  o_c_state[2] = i_c_state[2];
  o_c_state[3] = i_c_state[3];
  o_c_state[4] = i_c_state[4];
  o_c_state[9] = i_c_state[5];
  o_c_state[12] = i_c_state[6];
  o_c_state[7] = i_c_state[7];
  o_c_state[8] = i_c_state[8];
  o_c_state[16] = i_c_state[9];
  o_c_state[10] = i_c_state[10];
  o_c_state[15] = i_c_state[11];
  o_c_state[18] = i_c_state[12];
  o_c_state[13] = i_c_state[13];
  o_c_state[14] = i_c_state[14];
  o_c_state[22] = i_c_state[15];
  o_c_state[19] = i_c_state[16];
  o_c_state[17] = i_c_state[17];
  o_c_state[0] = i_c_state[18];
  o_c_state[5] = i_c_state[19];
  o_c_state[20] = i_c_state[20];
  o_c_state[21] = i_c_state[21];
  o_c_state[1] = i_c_state[22];
  o_c_state[23] = i_c_state[23];
  o_c_state[30] = i_c_state[24];
  o_c_state[25] = i_c_state[25];
  o_c_state[26] = i_c_state[26];
  o_c_state[27] = i_c_state[27];
  o_c_state[28] = i_c_state[28];
  o_c_state[33] = i_c_state[29];
  o_c_state[36] = i_c_state[30];
  o_c_state[31] = i_c_state[31];
  o_c_state[32] = i_c_state[32];
  o_c_state[40] = i_c_state[33];
  o_c_state[34] = i_c_state[34];
  o_c_state[35] = i_c_state[35];
  o_c_state[42] = i_c_state[36];
  o_c_state[37] = i_c_state[37];
  o_c_state[38] = i_c_state[38];
  o_c_state[39] = i_c_state[39];
  o_c_state[43] = i_c_state[40];
  o_c_state[41] = i_c_state[41];
  o_c_state[24] = i_c_state[42];
  o_c_state[29] = i_c_state[43];
  o_c_state[44] = i_c_state[44];
  o_c_state[45] = i_c_state[45];
  o_c_state[46] = i_c_state[46];
  o_c_state[47] = i_c_state[47];
  end
  endtask
task Front_counterclockwise;
  input [2:0] i_c_state [0:47];
 output [2:0] o_c_state[0:47];
 begin
  o_c_state[18] = i_c_state[0];
  o_c_state[22] = i_c_state[1];
  o_c_state[2] = i_c_state[2];
  o_c_state[3] = i_c_state[3];
  o_c_state[4] = i_c_state[4];
  o_c_state[19] = i_c_state[5];
  o_c_state[0] = i_c_state[6];
  o_c_state[7] = i_c_state[7];
  o_c_state[8] = i_c_state[8];
  o_c_state[5] = i_c_state[9];
  o_c_state[10] = i_c_state[10];
  o_c_state[1] = i_c_state[11];
  o_c_state[6] = i_c_state[12];
  o_c_state[13] = i_c_state[13];
  o_c_state[14] = i_c_state[14];
  o_c_state[11] = i_c_state[15];
  o_c_state[9] = i_c_state[16];
  o_c_state[17] = i_c_state[17];
  o_c_state[12] = i_c_state[18];
  o_c_state[16] = i_c_state[19];
  o_c_state[20] = i_c_state[20];
  o_c_state[21] = i_c_state[21];
  o_c_state[15] = i_c_state[22];
  o_c_state[23] = i_c_state[23];
  o_c_state[42] = i_c_state[24];
  o_c_state[25] = i_c_state[25];
  o_c_state[26] = i_c_state[26];
  o_c_state[27] = i_c_state[27];
  o_c_state[28] = i_c_state[28];
  o_c_state[43] = i_c_state[29];
  o_c_state[24] = i_c_state[30];
  o_c_state[31] = i_c_state[31];
  o_c_state[32] = i_c_state[32];
  o_c_state[29] = i_c_state[33];
  o_c_state[34] = i_c_state[34];
  o_c_state[35] = i_c_state[35];
  o_c_state[30] = i_c_state[36];
  o_c_state[37] = i_c_state[37];
  o_c_state[38] = i_c_state[38];
  o_c_state[39] = i_c_state[39];
  o_c_state[33] = i_c_state[40];
  o_c_state[41] = i_c_state[41];
  o_c_state[36] = i_c_state[42];
  o_c_state[40] = i_c_state[43];
  o_c_state[44] = i_c_state[44];
  o_c_state[45] = i_c_state[45];
  o_c_state[46] = i_c_state[46];
  o_c_state[47] = i_c_state[47];
  end
  endtask
task Left_clockwise;
  input [2:0] i_c_state [0:47];
 output [2:0] o_c_state[0:47];
 begin
  o_c_state[0] = i_c_state[4];
  o_c_state[1] = i_c_state[1];
  o_c_state[2] = i_c_state[2];
  o_c_state[3] = i_c_state[21];
  o_c_state[4] = i_c_state[14];
  o_c_state[5] = i_c_state[0];
  o_c_state[6] = i_c_state[6];
  o_c_state[7] = i_c_state[7];
  o_c_state[8] = i_c_state[23];
  o_c_state[9] = i_c_state[3];
  o_c_state[10] = i_c_state[10];
  o_c_state[11] = i_c_state[11];
  o_c_state[12] = i_c_state[12];
  o_c_state[13] = i_c_state[13];
  o_c_state[14] = i_c_state[5];
  o_c_state[15] = i_c_state[9];
  o_c_state[16] = i_c_state[16];
  o_c_state[17] = i_c_state[17];
  o_c_state[18] = i_c_state[22];
  o_c_state[19] = i_c_state[19];
  o_c_state[20] = i_c_state[20];
  o_c_state[21] = i_c_state[15];
  o_c_state[22] = i_c_state[8];
  o_c_state[23] = i_c_state[18];
  o_c_state[24] = i_c_state[24];
  o_c_state[25] = i_c_state[25];
  o_c_state[26] = i_c_state[26];
  o_c_state[27] = i_c_state[45];
  o_c_state[28] = i_c_state[28];
  o_c_state[29] = i_c_state[29];
  o_c_state[30] = i_c_state[30];
  o_c_state[31] = i_c_state[31];
  o_c_state[32] = i_c_state[47];
  o_c_state[33] = i_c_state[27];
  o_c_state[34] = i_c_state[34];
  o_c_state[35] = i_c_state[35];
  o_c_state[36] = i_c_state[36];
  o_c_state[37] = i_c_state[37];
  o_c_state[38] = i_c_state[38];
  o_c_state[39] = i_c_state[33];
  o_c_state[40] = i_c_state[40];
  o_c_state[41] = i_c_state[41];
  o_c_state[42] = i_c_state[46];
  o_c_state[43] = i_c_state[43];
  o_c_state[44] = i_c_state[44];
  o_c_state[45] = i_c_state[39];
  o_c_state[46] = i_c_state[32];
  o_c_state[47] = i_c_state[42];
  end
  endtask
task Left_counterclockwise;
  input [2:0] i_c_state [0:47];
 output [2:0] o_c_state[0:47];
 begin
  o_c_state[0] = i_c_state[5];
  o_c_state[1] = i_c_state[1];
  o_c_state[2] = i_c_state[2];
  o_c_state[3] = i_c_state[9];
  o_c_state[4] = i_c_state[0];
  o_c_state[5] = i_c_state[14];
  o_c_state[6] = i_c_state[6];
  o_c_state[7] = i_c_state[7];
  o_c_state[8] = i_c_state[22];
  o_c_state[9] = i_c_state[15];
  o_c_state[10] = i_c_state[10];
  o_c_state[11] = i_c_state[11];
  o_c_state[12] = i_c_state[12];
  o_c_state[13] = i_c_state[13];
  o_c_state[14] = i_c_state[4];
  o_c_state[15] = i_c_state[21];
  o_c_state[16] = i_c_state[16];
  o_c_state[17] = i_c_state[17];
  o_c_state[18] = i_c_state[23];
  o_c_state[19] = i_c_state[19];
  o_c_state[20] = i_c_state[20];
  o_c_state[21] = i_c_state[3];
  o_c_state[22] = i_c_state[18];
  o_c_state[23] = i_c_state[8];
  o_c_state[24] = i_c_state[24];
  o_c_state[25] = i_c_state[25];
  o_c_state[26] = i_c_state[26];
  o_c_state[27] = i_c_state[33];
  o_c_state[28] = i_c_state[28];
  o_c_state[29] = i_c_state[29];
  o_c_state[30] = i_c_state[30];
  o_c_state[31] = i_c_state[31];
  o_c_state[32] = i_c_state[46];
  o_c_state[33] = i_c_state[39];
  o_c_state[34] = i_c_state[34];
  o_c_state[35] = i_c_state[35];
  o_c_state[36] = i_c_state[36];
  o_c_state[37] = i_c_state[37];
  o_c_state[38] = i_c_state[38];
  o_c_state[39] = i_c_state[45];
  o_c_state[40] = i_c_state[40];
  o_c_state[41] = i_c_state[41];
  o_c_state[42] = i_c_state[47];
  o_c_state[43] = i_c_state[43];
  o_c_state[44] = i_c_state[44];
  o_c_state[45] = i_c_state[27];
  o_c_state[46] = i_c_state[42];
  o_c_state[47] = i_c_state[32];
  end
  endtask
task Right_clockwise;
  input [2:0] i_c_state [0:47];
 output [2:0] o_c_state[0:47];
 begin
  o_c_state[0] = i_c_state[0];
  o_c_state[7] = i_c_state[1];
  o_c_state[17] = i_c_state[2];
  o_c_state[3] = i_c_state[3];
  o_c_state[4] = i_c_state[4];
  o_c_state[5] = i_c_state[5];
  o_c_state[10] = i_c_state[6];
  o_c_state[13] = i_c_state[7];
  o_c_state[8] = i_c_state[8];
  o_c_state[9] = i_c_state[9];
  o_c_state[20] = i_c_state[10];
  o_c_state[6] = i_c_state[11];
  o_c_state[16] = i_c_state[12];
  o_c_state[19] = i_c_state[13];
  o_c_state[14] = i_c_state[14];
  o_c_state[15] = i_c_state[15];
  o_c_state[2] = i_c_state[16];
  o_c_state[12] = i_c_state[17];
  o_c_state[18] = i_c_state[18];
  o_c_state[1] = i_c_state[19];
  o_c_state[11] = i_c_state[20];
  o_c_state[21] = i_c_state[21];
  o_c_state[22] = i_c_state[22];
  o_c_state[23] = i_c_state[23];
  o_c_state[24] = i_c_state[24];
  o_c_state[31] = i_c_state[25];
  o_c_state[26] = i_c_state[26];
  o_c_state[27] = i_c_state[27];
  o_c_state[28] = i_c_state[28];
  o_c_state[29] = i_c_state[29];
  o_c_state[34] = i_c_state[30];
  o_c_state[37] = i_c_state[31];
  o_c_state[32] = i_c_state[32];
  o_c_state[33] = i_c_state[33];
  o_c_state[44] = i_c_state[34];
  o_c_state[30] = i_c_state[35];
  o_c_state[36] = i_c_state[36];
  o_c_state[43] = i_c_state[37];
  o_c_state[38] = i_c_state[38];
  o_c_state[39] = i_c_state[39];
  o_c_state[40] = i_c_state[40];
  o_c_state[41] = i_c_state[41];
  o_c_state[42] = i_c_state[42];
  o_c_state[25] = i_c_state[43];
  o_c_state[35] = i_c_state[44];
  o_c_state[45] = i_c_state[45];
  o_c_state[46] = i_c_state[46];
  o_c_state[47] = i_c_state[47];
  end
  endtask
task Right_counterclockwise;
  input [2:0] i_c_state [0:47];
 output [2:0] o_c_state[0:47];
 begin
  o_c_state[0] = i_c_state[0];
  o_c_state[19] = i_c_state[1];
  o_c_state[16] = i_c_state[2];
  o_c_state[3] = i_c_state[3];
  o_c_state[4] = i_c_state[4];
  o_c_state[5] = i_c_state[5];
  o_c_state[11] = i_c_state[6];
  o_c_state[1] = i_c_state[7];
  o_c_state[8] = i_c_state[8];
  o_c_state[9] = i_c_state[9];
  o_c_state[6] = i_c_state[10];
  o_c_state[20] = i_c_state[11];
  o_c_state[17] = i_c_state[12];
  o_c_state[7] = i_c_state[13];
  o_c_state[14] = i_c_state[14];
  o_c_state[15] = i_c_state[15];
  o_c_state[12] = i_c_state[16];
  o_c_state[2] = i_c_state[17];
  o_c_state[18] = i_c_state[18];
  o_c_state[13] = i_c_state[19];
  o_c_state[10] = i_c_state[20];
  o_c_state[21] = i_c_state[21];
  o_c_state[22] = i_c_state[22];
  o_c_state[23] = i_c_state[23];
  o_c_state[24] = i_c_state[24];
  o_c_state[43] = i_c_state[25];
  o_c_state[26] = i_c_state[26];
  o_c_state[27] = i_c_state[27];
  o_c_state[28] = i_c_state[28];
  o_c_state[29] = i_c_state[29];
  o_c_state[35] = i_c_state[30];
  o_c_state[25] = i_c_state[31];
  o_c_state[32] = i_c_state[32];
  o_c_state[33] = i_c_state[33];
  o_c_state[30] = i_c_state[34];
  o_c_state[44] = i_c_state[35];
  o_c_state[36] = i_c_state[36];
  o_c_state[31] = i_c_state[37];
  o_c_state[38] = i_c_state[38];
  o_c_state[39] = i_c_state[39];
  o_c_state[40] = i_c_state[40];
  o_c_state[41] = i_c_state[41];
  o_c_state[42] = i_c_state[42];
  o_c_state[37] = i_c_state[43];
  o_c_state[34] = i_c_state[44];
  o_c_state[45] = i_c_state[45];
  o_c_state[46] = i_c_state[46];
  o_c_state[47] = i_c_state[47];
  end
  endtask
task Top_clockwise;
  input [2:0] i_c_state [0:47];
 output [2:0] o_c_state[0:47];
 begin
  o_c_state[3] = i_c_state[0];
  o_c_state[0] = i_c_state[1];
  o_c_state[1] = i_c_state[2];
  o_c_state[2] = i_c_state[3];
  o_c_state[10] = i_c_state[4];
  o_c_state[5] = i_c_state[5];
  o_c_state[9] = i_c_state[6];
  o_c_state[6] = i_c_state[7];
  o_c_state[7] = i_c_state[8];
  o_c_state[8] = i_c_state[9];
  o_c_state[16] = i_c_state[10];
  o_c_state[11] = i_c_state[11];
  o_c_state[12] = i_c_state[12];
  o_c_state[13] = i_c_state[13];
  o_c_state[14] = i_c_state[14];
  o_c_state[15] = i_c_state[15];
  o_c_state[22] = i_c_state[16];
  o_c_state[17] = i_c_state[17];
  o_c_state[18] = i_c_state[18];
  o_c_state[19] = i_c_state[19];
  o_c_state[20] = i_c_state[20];
  o_c_state[21] = i_c_state[21];
  o_c_state[4] = i_c_state[22];
  o_c_state[23] = i_c_state[23];
  o_c_state[27] = i_c_state[24];
  o_c_state[24] = i_c_state[25];
  o_c_state[25] = i_c_state[26];
  o_c_state[26] = i_c_state[27];
  o_c_state[34] = i_c_state[28];
  o_c_state[29] = i_c_state[29];
  o_c_state[30] = i_c_state[30];
  o_c_state[31] = i_c_state[31];
  o_c_state[32] = i_c_state[32];
  o_c_state[33] = i_c_state[33];
  o_c_state[40] = i_c_state[34];
  o_c_state[35] = i_c_state[35];
  o_c_state[36] = i_c_state[36];
  o_c_state[37] = i_c_state[37];
  o_c_state[38] = i_c_state[38];
  o_c_state[39] = i_c_state[39];
  o_c_state[46] = i_c_state[40];
  o_c_state[41] = i_c_state[41];
  o_c_state[42] = i_c_state[42];
  o_c_state[43] = i_c_state[43];
  o_c_state[44] = i_c_state[44];
  o_c_state[45] = i_c_state[45];
  o_c_state[28] = i_c_state[46];
  o_c_state[47] = i_c_state[47];
  end
  endtask
task Top_counterclockwise;
  input [2:0] i_c_state [0:47];
 output [2:0] o_c_state[0:47];
 begin
  o_c_state[1] = i_c_state[0];
  o_c_state[2] = i_c_state[1];
  o_c_state[3] = i_c_state[2];
  o_c_state[0] = i_c_state[3];
  o_c_state[22] = i_c_state[4];
  o_c_state[5] = i_c_state[5];
  o_c_state[7] = i_c_state[6];
  o_c_state[8] = i_c_state[7];
  o_c_state[9] = i_c_state[8];
  o_c_state[6] = i_c_state[9];
  o_c_state[4] = i_c_state[10];
  o_c_state[11] = i_c_state[11];
  o_c_state[12] = i_c_state[12];
  o_c_state[13] = i_c_state[13];
  o_c_state[14] = i_c_state[14];
  o_c_state[15] = i_c_state[15];
  o_c_state[10] = i_c_state[16];
  o_c_state[17] = i_c_state[17];
  o_c_state[18] = i_c_state[18];
  o_c_state[19] = i_c_state[19];
  o_c_state[20] = i_c_state[20];
  o_c_state[21] = i_c_state[21];
  o_c_state[16] = i_c_state[22];
  o_c_state[23] = i_c_state[23];
  o_c_state[25] = i_c_state[24];
  o_c_state[26] = i_c_state[25];
  o_c_state[27] = i_c_state[26];
  o_c_state[24] = i_c_state[27];
  o_c_state[46] = i_c_state[28];
  o_c_state[29] = i_c_state[29];
  o_c_state[30] = i_c_state[30];
  o_c_state[31] = i_c_state[31];
  o_c_state[32] = i_c_state[32];
  o_c_state[33] = i_c_state[33];
  o_c_state[28] = i_c_state[34];
  o_c_state[35] = i_c_state[35];
  o_c_state[36] = i_c_state[36];
  o_c_state[37] = i_c_state[37];
  o_c_state[38] = i_c_state[38];
  o_c_state[39] = i_c_state[39];
  o_c_state[34] = i_c_state[40];
  o_c_state[41] = i_c_state[41];
  o_c_state[42] = i_c_state[42];
  o_c_state[43] = i_c_state[43];
  o_c_state[44] = i_c_state[44];
  o_c_state[45] = i_c_state[45];
  o_c_state[40] = i_c_state[46];
  o_c_state[47] = i_c_state[47];
  end
  endtask
task Down_clockwise;
  input [2:0] i_c_state [0:47];
 output [2:0] o_c_state[0:47];
 begin
  o_c_state[0] = i_c_state[0];
  o_c_state[1] = i_c_state[1];
  o_c_state[2] = i_c_state[2];
  o_c_state[3] = i_c_state[3];
  o_c_state[4] = i_c_state[4];
  o_c_state[5] = i_c_state[23];
  o_c_state[6] = i_c_state[6];
  o_c_state[7] = i_c_state[7];
  o_c_state[8] = i_c_state[8];
  o_c_state[9] = i_c_state[9];
  o_c_state[10] = i_c_state[10];
  o_c_state[11] = i_c_state[5];
  o_c_state[12] = i_c_state[15];
  o_c_state[13] = i_c_state[12];
  o_c_state[14] = i_c_state[13];
  o_c_state[15] = i_c_state[14];
  o_c_state[16] = i_c_state[16];
  o_c_state[17] = i_c_state[11];
  o_c_state[18] = i_c_state[21];
  o_c_state[19] = i_c_state[18];
  o_c_state[20] = i_c_state[19];
  o_c_state[21] = i_c_state[20];
  o_c_state[22] = i_c_state[22];
  o_c_state[23] = i_c_state[17];
  o_c_state[24] = i_c_state[24];
  o_c_state[25] = i_c_state[25];
  o_c_state[26] = i_c_state[26];
  o_c_state[27] = i_c_state[27];
  o_c_state[28] = i_c_state[28];
  o_c_state[29] = i_c_state[47];
  o_c_state[30] = i_c_state[30];
  o_c_state[31] = i_c_state[31];
  o_c_state[32] = i_c_state[32];
  o_c_state[33] = i_c_state[33];
  o_c_state[34] = i_c_state[34];
  o_c_state[35] = i_c_state[29];
  o_c_state[36] = i_c_state[39];
  o_c_state[37] = i_c_state[36];
  o_c_state[38] = i_c_state[37];
  o_c_state[39] = i_c_state[38];
  o_c_state[40] = i_c_state[40];
  o_c_state[41] = i_c_state[35];
  o_c_state[42] = i_c_state[42];
  o_c_state[43] = i_c_state[43];
  o_c_state[44] = i_c_state[44];
  o_c_state[45] = i_c_state[45];
  o_c_state[46] = i_c_state[46];
  o_c_state[47] = i_c_state[41];
  end
  endtask
task Down_counterclockwise;
  input [2:0] i_c_state [0:47];
 output [2:0] o_c_state[0:47];
 begin
  o_c_state[0] = i_c_state[0];
  o_c_state[1] = i_c_state[1];
  o_c_state[2] = i_c_state[2];
  o_c_state[3] = i_c_state[3];
  o_c_state[4] = i_c_state[4];
  o_c_state[5] = i_c_state[11];
  o_c_state[6] = i_c_state[6];
  o_c_state[7] = i_c_state[7];
  o_c_state[8] = i_c_state[8];
  o_c_state[9] = i_c_state[9];
  o_c_state[10] = i_c_state[10];
  o_c_state[11] = i_c_state[17];
  o_c_state[12] = i_c_state[13];
  o_c_state[13] = i_c_state[14];
  o_c_state[14] = i_c_state[15];
  o_c_state[15] = i_c_state[12];
  o_c_state[16] = i_c_state[16];
  o_c_state[17] = i_c_state[23];
  o_c_state[18] = i_c_state[19];
  o_c_state[19] = i_c_state[20];
  o_c_state[20] = i_c_state[21];
  o_c_state[21] = i_c_state[18];
  o_c_state[22] = i_c_state[22];
  o_c_state[23] = i_c_state[5];
  o_c_state[24] = i_c_state[24];
  o_c_state[25] = i_c_state[25];
  o_c_state[26] = i_c_state[26];
  o_c_state[27] = i_c_state[27];
  o_c_state[28] = i_c_state[28];
  o_c_state[29] = i_c_state[35];
  o_c_state[30] = i_c_state[30];
  o_c_state[31] = i_c_state[31];
  o_c_state[32] = i_c_state[32];
  o_c_state[33] = i_c_state[33];
  o_c_state[34] = i_c_state[34];
  o_c_state[35] = i_c_state[41];
  o_c_state[36] = i_c_state[37];
  o_c_state[37] = i_c_state[38];
  o_c_state[38] = i_c_state[39];
  o_c_state[39] = i_c_state[36];
  o_c_state[40] = i_c_state[40];
  o_c_state[41] = i_c_state[47];
  o_c_state[42] = i_c_state[42];
  o_c_state[43] = i_c_state[43];
  o_c_state[44] = i_c_state[44];
  o_c_state[45] = i_c_state[45];
  o_c_state[46] = i_c_state[46];
  o_c_state[47] = i_c_state[29];
  end
  endtask
task Back_clockwise;
  input [2:0] i_c_state [0:47];
 output [2:0] o_c_state[0:47];
 begin
  o_c_state[0] = i_c_state[0];
  o_c_state[1] = i_c_state[1];
  o_c_state[2] = i_c_state[20];
  o_c_state[3] = i_c_state[10];
  o_c_state[4] = i_c_state[7];
  o_c_state[5] = i_c_state[5];
  o_c_state[6] = i_c_state[6];
  o_c_state[7] = i_c_state[17];
  o_c_state[8] = i_c_state[2];
  o_c_state[9] = i_c_state[9];
  o_c_state[10] = i_c_state[13];
  o_c_state[11] = i_c_state[11];
  o_c_state[12] = i_c_state[12];
  o_c_state[13] = i_c_state[23];
  o_c_state[14] = i_c_state[8];
  o_c_state[15] = i_c_state[15];
  o_c_state[16] = i_c_state[16];
  o_c_state[17] = i_c_state[21];
  o_c_state[18] = i_c_state[18];
  o_c_state[19] = i_c_state[19];
  o_c_state[20] = i_c_state[14];
  o_c_state[21] = i_c_state[4];
  o_c_state[22] = i_c_state[22];
  o_c_state[23] = i_c_state[3];
  o_c_state[24] = i_c_state[24];
  o_c_state[25] = i_c_state[25];
  o_c_state[26] = i_c_state[44];
  o_c_state[27] = i_c_state[27];
  o_c_state[28] = i_c_state[31];
  o_c_state[29] = i_c_state[29];
  o_c_state[30] = i_c_state[30];
  o_c_state[31] = i_c_state[41];
  o_c_state[32] = i_c_state[26];
  o_c_state[33] = i_c_state[33];
  o_c_state[34] = i_c_state[34];
  o_c_state[35] = i_c_state[35];
  o_c_state[36] = i_c_state[36];
  o_c_state[37] = i_c_state[37];
  o_c_state[38] = i_c_state[32];
  o_c_state[39] = i_c_state[39];
  o_c_state[40] = i_c_state[40];
  o_c_state[41] = i_c_state[45];
  o_c_state[42] = i_c_state[42];
  o_c_state[43] = i_c_state[43];
  o_c_state[44] = i_c_state[38];
  o_c_state[45] = i_c_state[28];
  o_c_state[46] = i_c_state[46];
  o_c_state[47] = i_c_state[47];
  end
  endtask
task Back_counterclockwise;
  input [2:0] i_c_state [0:47];
 output [2:0] o_c_state[0:47];
 begin
  o_c_state[0] = i_c_state[0];
  o_c_state[1] = i_c_state[1];
  o_c_state[2] = i_c_state[8];
  o_c_state[3] = i_c_state[23];
  o_c_state[4] = i_c_state[21];
  o_c_state[5] = i_c_state[5];
  o_c_state[6] = i_c_state[6];
  o_c_state[7] = i_c_state[4];
  o_c_state[8] = i_c_state[14];
  o_c_state[9] = i_c_state[9];
  o_c_state[10] = i_c_state[3];
  o_c_state[11] = i_c_state[11];
  o_c_state[12] = i_c_state[12];
  o_c_state[13] = i_c_state[10];
  o_c_state[14] = i_c_state[20];
  o_c_state[15] = i_c_state[15];
  o_c_state[16] = i_c_state[16];
  o_c_state[17] = i_c_state[7];
  o_c_state[18] = i_c_state[18];
  o_c_state[19] = i_c_state[19];
  o_c_state[20] = i_c_state[2];
  o_c_state[21] = i_c_state[17];
  o_c_state[22] = i_c_state[22];
  o_c_state[23] = i_c_state[13];
  o_c_state[24] = i_c_state[24];
  o_c_state[25] = i_c_state[25];
  o_c_state[26] = i_c_state[32];
  o_c_state[27] = i_c_state[27];
  o_c_state[28] = i_c_state[45];
  o_c_state[29] = i_c_state[29];
  o_c_state[30] = i_c_state[30];
  o_c_state[31] = i_c_state[28];
  o_c_state[32] = i_c_state[38];
  o_c_state[33] = i_c_state[33];
  o_c_state[34] = i_c_state[34];
  o_c_state[35] = i_c_state[35];
  o_c_state[36] = i_c_state[36];
  o_c_state[37] = i_c_state[37];
  o_c_state[38] = i_c_state[44];
  o_c_state[39] = i_c_state[39];
  o_c_state[40] = i_c_state[40];
  o_c_state[41] = i_c_state[31];
  o_c_state[42] = i_c_state[42];
  o_c_state[43] = i_c_state[43];
  o_c_state[44] = i_c_state[26];
  o_c_state[45] = i_c_state[41];
  o_c_state[46] = i_c_state[46];
  o_c_state[47] = i_c_state[47];
  end
  endtask
task Front_to_top;
  input [2:0] i_c_state [0:47];
 output [2:0] o_c_state[0:47];
 begin
  o_c_state[0] = i_c_state[5];
  o_c_state[1] = i_c_state[19];
  o_c_state[2] = i_c_state[16];
  o_c_state[3] = i_c_state[9];
  o_c_state[4] = i_c_state[0];
  o_c_state[5] = i_c_state[14];
  o_c_state[6] = i_c_state[11];
  o_c_state[7] = i_c_state[1];
  o_c_state[8] = i_c_state[22];
  o_c_state[9] = i_c_state[15];
  o_c_state[10] = i_c_state[6];
  o_c_state[11] = i_c_state[20];
  o_c_state[12] = i_c_state[17];
  o_c_state[13] = i_c_state[7];
  o_c_state[14] = i_c_state[4];
  o_c_state[15] = i_c_state[21];
  o_c_state[16] = i_c_state[12];
  o_c_state[17] = i_c_state[2];
  o_c_state[18] = i_c_state[23];
  o_c_state[19] = i_c_state[13];
  o_c_state[20] = i_c_state[10];
  o_c_state[21] = i_c_state[3];
  o_c_state[22] = i_c_state[18];
  o_c_state[23] = i_c_state[8];
  o_c_state[24] = i_c_state[29];
  o_c_state[25] = i_c_state[43];
  o_c_state[26] = i_c_state[40];
  o_c_state[27] = i_c_state[33];
  o_c_state[28] = i_c_state[24];
  o_c_state[29] = i_c_state[38];
  o_c_state[30] = i_c_state[35];
  o_c_state[31] = i_c_state[25];
  o_c_state[32] = i_c_state[46];
  o_c_state[33] = i_c_state[39];
  o_c_state[34] = i_c_state[30];
  o_c_state[35] = i_c_state[44];
  o_c_state[36] = i_c_state[41];
  o_c_state[37] = i_c_state[31];
  o_c_state[38] = i_c_state[28];
  o_c_state[39] = i_c_state[45];
  o_c_state[40] = i_c_state[36];
  o_c_state[41] = i_c_state[26];
  o_c_state[42] = i_c_state[47];
  o_c_state[43] = i_c_state[37];
  o_c_state[44] = i_c_state[34];
  o_c_state[45] = i_c_state[27];
  o_c_state[46] = i_c_state[42];
  o_c_state[47] = i_c_state[32];
  end
  endtask

//combinational ckt
always_comb begin
    state_w = state_r;
    done_w = done_r;
    move_count_w = move_count_r;
    for(i=0;i<32;i++)begin
      move_combo_w[i] = move_combo_r[i];
    end
    for(i=0;i<48;i++)begin
      c_state_w[i] = c_state_r[i];
     end
    case(state_r)
    S_IDLE: begin
    if(i_start) begin
            state_w = S_PROC;
            done_w = 0;
            for(i=0;i<32;i++)begin
              move_combo_w[i] = i_move_combo[i];
            end
            for(i=0;i<48;i++)begin
              c_state_w[i] = i_init_c_state[i];
            end
            move_count_w = 0;
        end
        else begin
            state_w = state_r;
            done_w = done_r;
            for(i=0;i<32;i++)begin
              move_combo_w[i] = move_combo_r[i];
            end
            c_state_w = c_state_r;
            move_count_w = 0;
        end
        end
        S_PROC: begin
            state_w = state_r;
            move_count_w = move_count_r + 1;
            done_w = 0;
            case (move_combo_r[move_count_r])
                4'b0000: begin
                    for(i=0;i<48;i++)begin
                      c_state_w[i] = c_state_r[i];
                    end
                    done_w = 1;
                    state_w = S_WAIT;
                end //NOP
                4'b0001: begin
                    change_view(c_state_r, c_state_w);
                end //chenge view
                4'b0010: begin
                    Front_clockwise(c_state_r, c_state_w);
                end //f c
                4'b0011: begin
                    Front_counterclockwise(c_state_r, c_state_w);
                end //f cc
                4'b0100: begin
                    Right_clockwise(c_state_r, c_state_w);
                end //r c
                4'b0101: begin
                    Right_counterclockwise(c_state_r, c_state_w);
                end //r cc
                4'b0110: begin
                    Left_clockwise(c_state_r, c_state_w);
                end //l c
                4'b0111: begin
                    Left_counterclockwise(c_state_r, c_state_w);
                end //l cc
                4'b1000: begin
                    Top_clockwise(c_state_r, c_state_w);
                end //t c
                4'b1001: begin
                    Top_counterclockwise(c_state_r, c_state_w);
                end //t cc
                4'b1010: begin
                    Back_clockwise(c_state_r, c_state_w);
                end //d c
                4'b1011: begin
                    Back_counterclockwise(c_state_r, c_state_w);
                end //d cc
                4'b1100: begin
                    Down_clockwise(c_state_r, c_state_w);
                end //b c
                4'b1101: begin
                    Down_counterclockwise(c_state_r, c_state_w);
                end //b cc
                4'b1111: begin
                    Front_to_top(c_state_r, c_state_w);
                end// front to top
                default: begin
                    c_state_w = c_state_r;
                end
            endcase
        end
        S_WAIT: begin
          if(i_alg_done) begin
            state_w = S_PROC;
            done_w = 0;
            for(i=0;i<32;i++)begin
              move_combo_w[i] = i_move_combo[i];
            end
            for(i=0;i<48;i++)begin
              c_state_w[i] = c_state_r[i];
            end
            move_count_w = 0;
        end
        else
        begin
            state_w = state_r;
            done_w = done_r;
            for(i=0;i<32;i++)begin
              move_combo_w[i] = move_combo_r[i];
            end
            c_state_w = c_state_r;
            move_count_w = 0;
        end
        end
    endcase
end
// sequential ckt
always_ff @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        state_r <= S_IDLE;
        for(j=0;j<48;j++)begin
          c_state_r[j] <= 0;
        end
        for(j=0;j<32;j++)begin
          move_combo_r[j] <=0;
        end
         // 31 steps at most
        move_count_r <= 0;
        done_r <= 0;
    end
    else begin
        state_r <= state_w;
        for(j=0;j<48;j++)begin
          c_state_r[j] <= c_state_w[j];
        end
        for(j=0;j<32;j++)begin
          move_combo_r[j] <=move_combo_w[j];
        end // 31 steps at most
        move_count_r <= move_count_w;
        done_r <=done_w;
    end
end
endmodule