f = open("find_edge.txt", 'w')
edge_index = [[30,43],[31,44],[24,40],[33,42],[29,36],[32,45],[25,34],[26,28],[27,46],[35,37],[38,41],[39,47]]
f.write("if(i_c_state[edge_index[0][0]] == i_color_1 && i_c_state[edge_index[0][1]] == i_color_2) || (i_c_state[edge_index[0][0]] == i_color_2 && i_c_state[edge_index[0][1]] == i_color_1) begin\n")
f.write("o_edge[0] = edge_index[i][0];\n")
f.write("o_edge[1] = edge_index[i][1];\n")
f.write("end\n")
for i in range(1, len(edge_index)):
    f.write("else if(i_c_state[edge_index[{}][0]] == i_color_1 && i_c_state[edge_index[{}][1]] == i_color_2) || (i_c_state[edge_index[{}][0]] == i_color_2 && i_c_state[edge_index[{}][1]] == i_color_1) begin\n".format(i,i,i,i))
    f.write("o_edge[0] = edge_index[{}][0];\n".format(i))
    f.write("o_edge[1] = edge_index[{}][1];\n".format(i))
    f.write("end\n")
f.write("else begin\n")
f.write("o_edge[0] = 6'dzzzzzz;\n")
f.write("o_edge[1] = 6'dzzzzzz;\n")
f.write("end\n")
corner_index =[[1,6,16], [0,9,22],[3,4,8], [2,7,10], [5,15,18],[11,12,19],[13,17,20],[14,21,23]]
#  if ((i_c_state[corner_index[i][0]] == i_color_1 && i_c_state[corner_index[i][1]] == i_color_2 && i_c_state[corner_index[i][2]] == i_color_3)||
#             (i_c_state[corner_index[i][0]] == i_color_1 && i_c_state[corner_index[i][1]] == i_color_3 && i_c_state[corner_index[i][2]] == i_color_2)||
#             (i_c_state[corner_index[i][0]] == i_color_2 && i_c_state[corner_index[i][1]] == i_color_1 && i_c_state[corner_index[i][2]] == i_color_3)||
#             (i_c_state[corner_index[i][0]] == i_color_2 && i_c_state[corner_index[i][1]] == i_color_3 && i_c_state[corner_index[i][2]] == i_color_1)||
#             (i_c_state[corner_index[i][0]] == i_color_3 && i_c_state[corner_index[i][1]] == i_color_1 && i_c_state[corner_index[i][2]] == i_color_2)||
#             (i_c_state[corner_index[i][0]] == i_color_3 && i_c_state[corner_index[i][1]] == i_color_2 && i_c_state[corner_index[i][2]] == i_color_1))begin
#                 o_corner[0] = corner_index[i][0];
#                 o_corner[1] = corner_index[i][1];
#                 o_corner[2] = corner_index[i][2];
#             end
f1 = open("find_corner.txt", 'w')
f1.write("if((i_c_state[corner_index[0][0]] == i_color_1 && i_c_state[corner_index[0][1]] == i_color_2 && i_c_state[corner_index[0][2]] == i_color_3)|| (i_c_state[corner_index[0][0]] == i_color_1 && i_c_state[corner_index[0][1]] == i_color_3 && i_c_state[corner_index[0][2]] == i_color_2)|| (i_c_state[corner_index[0][0]] == i_color_2 && i_c_state[corner_index[0][1]] == i_color_1 && i_c_state[corner_index[0][2]] == i_color_3)|| (i_c_state[corner_index[0][0]] == i_color_2 && i_c_state[corner_index[0][1]] == i_color_3 && i_c_state[corner_index[0][2]] == i_color_1)|| (i_c_state[corner_index[0][0]] == i_color_3 && i_c_state[corner_index[0][1]] == i_color_1 && i_c_state[corner_index[0][2]] == i_color_2)|| (i_c_state[corner_index[0][0]] == i_color_3 && i_c_state[corner_index[0][1]] == i_color_2 && i_c_state[corner_index[0][2]] == i_color_1))begin\n")
f1.write("o_corner[0] = corner_index[0][0];\n")
f1.write("o_corner[1] = corner_index[0][1];\n")
f1.write("o_corner[2] = corner_index[0][2];\n")
f1.write("end\n")
for i in range(1, len(corner_index)):
    f1.write("else if((i_c_state[corner_index[{}][0]] == i_color_1 && i_c_state[corner_index[{}][1]] == i_color_2 && i_c_state[corner_index[{}][2]] == i_color_3)|| (i_c_state[corner_index[{}][0]] == i_color_1 && i_c_state[corner_index[{}][1]] == i_color_3 && i_c_state[corner_index[{}][2]] == i_color_2)|| (i_c_state[corner_index[{}][0]] == i_color_2 && i_c_state[corner_index[{}][1]] == i_color_1 && i_c_state[corner_index[{}][2]] == i_color_3)|| (i_c_state[corner_index[{}][0]] == i_color_2 && i_c_state[corner_index[{}][1]] == i_color_3 && i_c_state[corner_index[{}][2]] == i_color_1)|| (i_c_state[corner_index[{}][0]] == i_color_3 && i_c_state[corner_index[{}][1]] == i_color_1 && i_c_state[corner_index[{}][2]] == i_color_2)|| (i_c_state[corner_index[{}][0]] == i_color_3 && i_c_state[corner_index[{}][1]] == i_color_2 && i_c_state[corner_index[{}][2]] == i_color_1))begin\n".format(i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i))
    f1.write("o_corner[0] = corner_index[{}][0];\n".format(i))
    f1.write("o_corner[1] = corner_index[{}][1];\n".format(i))
    f1.write("o_corner[2] = corner_index[{}][2];\n".format(i))
    f1.write("end\n")
f1.write("else begin\n")
f1.write("o_corner[0] = 6'dzzzzzz;\n")
f1.write("o_corner[1] = 6'dzzzzzz;\n")
f1.write("o_corner[2] = 6'dzzzzzz;\n")
f1.write("end\n")
