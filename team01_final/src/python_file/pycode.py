# from gen_binary_input import *
# import random



def change_view(a,f):
  temp = [0 for i in range(48)]
  temp[0] = a[1]
  temp[1] = a[2]
  temp[2] = a[3]
  temp[3] = a[0]
  temp[4] = a[22]
  temp[5] = a[11]
  temp[6] = a[7]
  temp[7] = a[8]
  temp[8] = a[9]
  temp[9] = a[6]
  temp[10] = a[4]
  temp[11] = a[17]
  temp[12] = a[13]
  temp[13] = a[14]
  temp[14] = a[15]
  temp[15] = a[12]
  temp[16] = a[10]
  temp[17] = a[23]
  temp[18] = a[19]
  temp[19] = a[20]
  temp[20] = a[21]
  temp[21] = a[18]
  temp[22] = a[16]
  temp[23] = a[5]
  temp[24] = a[25]
  temp[25] = a[26]
  temp[26] = a[27]
  temp[27] = a[24]
  temp[28] = a[46]
  temp[29] = a[35]
  temp[30] = a[31]
  temp[31] = a[32]
  temp[32] = a[33]
  temp[33] = a[30]
  temp[34] = a[28]
  temp[35] = a[41]
  temp[36] = a[37]
  temp[37] = a[38]
  temp[38] = a[39]
  temp[39] = a[36]
  temp[40] = a[34]
  temp[41] = a[47]
  temp[42] = a[43]
  temp[43] = a[44]
  temp[44] = a[45]
  temp[45] = a[42]
  temp[46] = a[40]
  temp[47] = a[29]
  f.write("change_view\n")
  return temp
def Front_clockwise(a,f):
  temp = [0 for i in range(48)]
  temp[6] = a[0]
  temp[11] = a[1]
  temp[2] = a[2]
  temp[3] = a[3]
  temp[4] = a[4]
  temp[9] = a[5]
  temp[12] = a[6]
  temp[7] = a[7]
  temp[8] = a[8]
  temp[16] = a[9]
  temp[10] = a[10]
  temp[15] = a[11]
  temp[18] = a[12]
  temp[13] = a[13]
  temp[14] = a[14]
  temp[22] = a[15]
  temp[19] = a[16]
  temp[17] = a[17]
  temp[0] = a[18]
  temp[5] = a[19]
  temp[20] = a[20]
  temp[21] = a[21]
  temp[1] = a[22]
  temp[23] = a[23]
  temp[30] = a[24]
  temp[25] = a[25]
  temp[26] = a[26]
  temp[27] = a[27]
  temp[28] = a[28]
  temp[33] = a[29]
  temp[36] = a[30]
  temp[31] = a[31]
  temp[32] = a[32]
  temp[40] = a[33]
  temp[34] = a[34]
  temp[35] = a[35]
  temp[42] = a[36]
  temp[37] = a[37]
  temp[38] = a[38]
  temp[39] = a[39]
  temp[43] = a[40]
  temp[41] = a[41]
  temp[24] = a[42]
  temp[29] = a[43]
  temp[44] = a[44]
  temp[45] = a[45]
  temp[46] = a[46]
  temp[47] = a[47]
  f.write("Front_clockwise\n")
  return temp
def Front_counterclockwise(a,f):
  temp = [0 for i in range(48)]
  temp[18] = a[0]
  temp[22] = a[1]
  temp[2] = a[2]
  temp[3] = a[3]
  temp[4] = a[4]
  temp[19] = a[5]
  temp[0] = a[6]
  temp[7] = a[7]
  temp[8] = a[8]
  temp[5] = a[9]
  temp[10] = a[10]
  temp[1] = a[11]
  temp[6] = a[12]
  temp[13] = a[13]
  temp[14] = a[14]
  temp[11] = a[15]
  temp[9] = a[16]
  temp[17] = a[17]
  temp[12] = a[18]
  temp[16] = a[19]
  temp[20] = a[20]
  temp[21] = a[21]
  temp[15] = a[22]
  temp[23] = a[23]
  temp[42] = a[24]
  temp[25] = a[25]
  temp[26] = a[26]
  temp[27] = a[27]
  temp[28] = a[28]
  temp[43] = a[29]
  temp[24] = a[30]
  temp[31] = a[31]
  temp[32] = a[32]
  temp[29] = a[33]
  temp[34] = a[34]
  temp[35] = a[35]
  temp[30] = a[36]
  temp[37] = a[37]
  temp[38] = a[38]
  temp[39] = a[39]
  temp[33] = a[40]
  temp[41] = a[41]
  temp[36] = a[42]
  temp[40] = a[43]
  temp[44] = a[44]
  temp[45] = a[45]
  temp[46] = a[46]
  temp[47] = a[47]
  f.write("Front_counterclockwise\n")
  return temp
def Left_clockwise(a,f):
  temp = [0 for i in range(48)]
  temp[0] = a[4]
  temp[1] = a[1]
  temp[2] = a[2]
  temp[3] = a[21]
  temp[4] = a[14]
  temp[5] = a[0]
  temp[6] = a[6]
  temp[7] = a[7]
  temp[8] = a[23]
  temp[9] = a[3]
  temp[10] = a[10]
  temp[11] = a[11]
  temp[12] = a[12]
  temp[13] = a[13]
  temp[14] = a[5]
  temp[15] = a[9]
  temp[16] = a[16]
  temp[17] = a[17]
  temp[18] = a[22]
  temp[19] = a[19]
  temp[20] = a[20]
  temp[21] = a[15]
  temp[22] = a[8]
  temp[23] = a[18]
  temp[24] = a[24]
  temp[25] = a[25]
  temp[26] = a[26]
  temp[27] = a[45]
  temp[28] = a[28]
  temp[29] = a[29]
  temp[30] = a[30]
  temp[31] = a[31]
  temp[32] = a[47]
  temp[33] = a[27]
  temp[34] = a[34]
  temp[35] = a[35]
  temp[36] = a[36]
  temp[37] = a[37]
  temp[38] = a[38]
  temp[39] = a[33]
  temp[40] = a[40]
  temp[41] = a[41]
  temp[42] = a[46]
  temp[43] = a[43]
  temp[44] = a[44]
  temp[45] = a[39]
  temp[46] = a[32]
  temp[47] = a[42]
  f.write("Left_clockwise\n")
  return temp
def Left_counterclockwise(a,f):
  temp = [0 for i in range(48)]
  temp[0] = a[5]
  temp[1] = a[1]
  temp[2] = a[2]
  temp[3] = a[9]
  temp[4] = a[0]
  temp[5] = a[14]
  temp[6] = a[6]
  temp[7] = a[7]
  temp[8] = a[22]
  temp[9] = a[15]
  temp[10] = a[10]
  temp[11] = a[11]
  temp[12] = a[12]
  temp[13] = a[13]
  temp[14] = a[4]
  temp[15] = a[21]
  temp[16] = a[16]
  temp[17] = a[17]
  temp[18] = a[23]
  temp[19] = a[19]
  temp[20] = a[20]
  temp[21] = a[3]
  temp[22] = a[18]
  temp[23] = a[8]
  temp[24] = a[24]
  temp[25] = a[25]
  temp[26] = a[26]
  temp[27] = a[33]
  temp[28] = a[28]
  temp[29] = a[29]
  temp[30] = a[30]
  temp[31] = a[31]
  temp[32] = a[46]
  temp[33] = a[39]
  temp[34] = a[34]
  temp[35] = a[35]
  temp[36] = a[36]
  temp[37] = a[37]
  temp[38] = a[38]
  temp[39] = a[45]
  temp[40] = a[40]
  temp[41] = a[41]
  temp[42] = a[47]
  temp[43] = a[43]
  temp[44] = a[44]
  temp[45] = a[27]
  temp[46] = a[42]
  temp[47] = a[32]
  f.write("Left_counterclockwise\n")
  return temp
def Right_clockwise(a,f):
  temp = [0 for i in range(48)]
  temp[0] = a[0]
  temp[7] = a[1]
  temp[17] = a[2]
  temp[3] = a[3]
  temp[4] = a[4]
  temp[5] = a[5]
  temp[10] = a[6]
  temp[13] = a[7]
  temp[8] = a[8]
  temp[9] = a[9]
  temp[20] = a[10]
  temp[6] = a[11]
  temp[16] = a[12]
  temp[19] = a[13]
  temp[14] = a[14]
  temp[15] = a[15]
  temp[2] = a[16]
  temp[12] = a[17]
  temp[18] = a[18]
  temp[1] = a[19]
  temp[11] = a[20]
  temp[21] = a[21]
  temp[22] = a[22]
  temp[23] = a[23]
  temp[24] = a[24]
  temp[31] = a[25]
  temp[26] = a[26]
  temp[27] = a[27]
  temp[28] = a[28]
  temp[29] = a[29]
  temp[34] = a[30]
  temp[37] = a[31]
  temp[32] = a[32]
  temp[33] = a[33]
  temp[44] = a[34]
  temp[30] = a[35]
  temp[36] = a[36]
  temp[43] = a[37]
  temp[38] = a[38]
  temp[39] = a[39]
  temp[40] = a[40]
  temp[41] = a[41]
  temp[42] = a[42]
  temp[25] = a[43]
  temp[35] = a[44]
  temp[45] = a[45]
  temp[46] = a[46]
  temp[47] = a[47]
  f.write("Right_clockwise\n")
  return temp
def Right_counterclockwise(a,f):
  temp = [0 for i in range(48)]
  temp[0] = a[0]
  temp[19] = a[1]
  temp[16] = a[2]
  temp[3] = a[3]
  temp[4] = a[4]
  temp[5] = a[5]
  temp[11] = a[6]
  temp[1] = a[7]
  temp[8] = a[8]
  temp[9] = a[9]
  temp[6] = a[10]
  temp[20] = a[11]
  temp[17] = a[12]
  temp[7] = a[13]
  temp[14] = a[14]
  temp[15] = a[15]
  temp[12] = a[16]
  temp[2] = a[17]
  temp[18] = a[18]
  temp[13] = a[19]
  temp[10] = a[20]
  temp[21] = a[21]
  temp[22] = a[22]
  temp[23] = a[23]
  temp[24] = a[24]
  temp[43] = a[25]
  temp[26] = a[26]
  temp[27] = a[27]
  temp[28] = a[28]
  temp[29] = a[29]
  temp[35] = a[30]
  temp[25] = a[31]
  temp[32] = a[32]
  temp[33] = a[33]
  temp[30] = a[34]
  temp[44] = a[35]
  temp[36] = a[36]
  temp[31] = a[37]
  temp[38] = a[38]
  temp[39] = a[39]
  temp[40] = a[40]
  temp[41] = a[41]
  temp[42] = a[42]
  temp[37] = a[43]
  temp[34] = a[44]
  temp[45] = a[45]
  temp[46] = a[46]
  temp[47] = a[47]
  f.write("Right_counterclockwise\n")
  return temp
def Top_clockwise(a,f):
  temp = [0 for i in range(48)]
  temp[3] = a[0]
  temp[0] = a[1]
  temp[1] = a[2]
  temp[2] = a[3]
  temp[10] = a[4]
  temp[5] = a[5]
  temp[9] = a[6]
  temp[6] = a[7]
  temp[7] = a[8]
  temp[8] = a[9]
  temp[16] = a[10]
  temp[11] = a[11]
  temp[12] = a[12]
  temp[13] = a[13]
  temp[14] = a[14]
  temp[15] = a[15]
  temp[22] = a[16]
  temp[17] = a[17]
  temp[18] = a[18]
  temp[19] = a[19]
  temp[20] = a[20]
  temp[21] = a[21]
  temp[4] = a[22]
  temp[23] = a[23]
  temp[27] = a[24]
  temp[24] = a[25]
  temp[25] = a[26]
  temp[26] = a[27]
  temp[34] = a[28]
  temp[29] = a[29]
  temp[30] = a[30]
  temp[31] = a[31]
  temp[32] = a[32]
  temp[33] = a[33]
  temp[40] = a[34]
  temp[35] = a[35]
  temp[36] = a[36]
  temp[37] = a[37]
  temp[38] = a[38]
  temp[39] = a[39]
  temp[46] = a[40]
  temp[41] = a[41]
  temp[42] = a[42]
  temp[43] = a[43]
  temp[44] = a[44]
  temp[45] = a[45]
  temp[28] = a[46]
  temp[47] = a[47]
  f.write("Top_clockwise\n")
  return temp
def Top_counterclockwise(a,f):
  temp = [0 for i in range(48)]
  temp[1] = a[0]
  temp[2] = a[1]
  temp[3] = a[2]
  temp[0] = a[3]
  temp[22] = a[4]
  temp[5] = a[5]
  temp[7] = a[6]
  temp[8] = a[7]
  temp[9] = a[8]
  temp[6] = a[9]
  temp[4] = a[10]
  temp[11] = a[11]
  temp[12] = a[12]
  temp[13] = a[13]
  temp[14] = a[14]
  temp[15] = a[15]
  temp[10] = a[16]
  temp[17] = a[17]
  temp[18] = a[18]
  temp[19] = a[19]
  temp[20] = a[20]
  temp[21] = a[21]
  temp[16] = a[22]
  temp[23] = a[23]
  temp[25] = a[24]
  temp[26] = a[25]
  temp[27] = a[26]
  temp[24] = a[27]
  temp[46] = a[28]
  temp[29] = a[29]
  temp[30] = a[30]
  temp[31] = a[31]
  temp[32] = a[32]
  temp[33] = a[33]
  temp[28] = a[34]
  temp[35] = a[35]
  temp[36] = a[36]
  temp[37] = a[37]
  temp[38] = a[38]
  temp[39] = a[39]
  temp[34] = a[40]
  temp[41] = a[41]
  temp[42] = a[42]
  temp[43] = a[43]
  temp[44] = a[44]
  temp[45] = a[45]
  temp[40] = a[46]
  temp[47] = a[47]
  f.write("Top_counterclockwise\n")
  return temp
def Down_clockwise(a,f):
  temp = [0 for i in range(48)]
  temp[0] = a[0]
  temp[1] = a[1]
  temp[2] = a[2]
  temp[3] = a[3]
  temp[4] = a[4]
  temp[5] = a[23]
  temp[6] = a[6]
  temp[7] = a[7]
  temp[8] = a[8]
  temp[9] = a[9]
  temp[10] = a[10]
  temp[11] = a[5]
  temp[12] = a[15]
  temp[13] = a[12]
  temp[14] = a[13]
  temp[15] = a[14]
  temp[16] = a[16]
  temp[17] = a[11]
  temp[18] = a[21]
  temp[19] = a[18]
  temp[20] = a[19]
  temp[21] = a[20]
  temp[22] = a[22]
  temp[23] = a[17]
  temp[24] = a[24]
  temp[25] = a[25]
  temp[26] = a[26]
  temp[27] = a[27]
  temp[28] = a[28]
  temp[29] = a[47]
  temp[30] = a[30]
  temp[31] = a[31]
  temp[32] = a[32]
  temp[33] = a[33]
  temp[34] = a[34]
  temp[35] = a[29]
  temp[36] = a[39]
  temp[37] = a[36]
  temp[38] = a[37]
  temp[39] = a[38]
  temp[40] = a[40]
  temp[41] = a[35]
  temp[42] = a[42]
  temp[43] = a[43]
  temp[44] = a[44]
  temp[45] = a[45]
  temp[46] = a[46]
  temp[47] = a[41]
  f.write("Down_clockwise\n")
  return temp
def Down_counterclockwise(a,f):
  temp = [0 for i in range(48)]
  temp[0] = a[0]
  temp[1] = a[1]
  temp[2] = a[2]
  temp[3] = a[3]
  temp[4] = a[4]
  temp[5] = a[11]
  temp[6] = a[6]
  temp[7] = a[7]
  temp[8] = a[8]
  temp[9] = a[9]
  temp[10] = a[10]
  temp[11] = a[17]
  temp[12] = a[13]
  temp[13] = a[14]
  temp[14] = a[15]
  temp[15] = a[12]
  temp[16] = a[16]
  temp[17] = a[23]
  temp[18] = a[19]
  temp[19] = a[20]
  temp[20] = a[21]
  temp[21] = a[18]
  temp[22] = a[22]
  temp[23] = a[5]
  temp[24] = a[24]
  temp[25] = a[25]
  temp[26] = a[26]
  temp[27] = a[27]
  temp[28] = a[28]
  temp[29] = a[35]
  temp[30] = a[30]
  temp[31] = a[31]
  temp[32] = a[32]
  temp[33] = a[33]
  temp[34] = a[34]
  temp[35] = a[41]
  temp[36] = a[37]
  temp[37] = a[38]
  temp[38] = a[39]
  temp[39] = a[36]
  temp[40] = a[40]
  temp[41] = a[47]
  temp[42] = a[42]
  temp[43] = a[43]
  temp[44] = a[44]
  temp[45] = a[45]
  temp[46] = a[46]
  temp[47] = a[29]
  f.write("Down_counterclockwise\n")
  return temp
def Back_clockwise(a,f):
  temp = [0 for i in range(48)]
  temp[0] = a[0]
  temp[1] = a[1]
  temp[2] = a[20]
  temp[3] = a[10]
  temp[4] = a[7]
  temp[5] = a[5]
  temp[6] = a[6]
  temp[7] = a[17]
  temp[8] = a[2]
  temp[9] = a[9]
  temp[10] = a[13]
  temp[11] = a[11]
  temp[12] = a[12]
  temp[13] = a[23]
  temp[14] = a[8]
  temp[15] = a[15]
  temp[16] = a[16]
  temp[17] = a[21]
  temp[18] = a[18]
  temp[19] = a[19]
  temp[20] = a[14]
  temp[21] = a[4]
  temp[22] = a[22]
  temp[23] = a[3]
  temp[24] = a[24]
  temp[25] = a[25]
  temp[26] = a[44]
  temp[27] = a[27]
  temp[28] = a[31]
  temp[29] = a[29]
  temp[30] = a[30]
  temp[31] = a[41]
  temp[32] = a[26]
  temp[33] = a[33]
  temp[34] = a[34]
  temp[35] = a[35]
  temp[36] = a[36]
  temp[37] = a[37]
  temp[38] = a[32]
  temp[39] = a[39]
  temp[40] = a[40]
  temp[41] = a[45]
  temp[42] = a[42]
  temp[43] = a[43]
  temp[44] = a[38]
  temp[45] = a[28]
  temp[46] = a[46]
  temp[47] = a[47]
  f.write("Back_clockwise\n")
  return temp
def Back_counterclockwise(a,f):
  temp = [0 for i in range(48)]
  temp[0] = a[0]
  temp[1] = a[1]
  temp[2] = a[8]
  temp[3] = a[23]
  temp[4] = a[21]
  temp[5] = a[5]
  temp[6] = a[6]
  temp[7] = a[4]
  temp[8] = a[14]
  temp[9] = a[9]
  temp[10] = a[3]
  temp[11] = a[11]
  temp[12] = a[12]
  temp[13] = a[10]
  temp[14] = a[20]
  temp[15] = a[15]
  temp[16] = a[16]
  temp[17] = a[7]
  temp[18] = a[18]
  temp[19] = a[19]
  temp[20] = a[2]
  temp[21] = a[17]
  temp[22] = a[22]
  temp[23] = a[13]
  temp[24] = a[24]
  temp[25] = a[25]
  temp[26] = a[32]
  temp[27] = a[27]
  temp[28] = a[45]
  temp[29] = a[29]
  temp[30] = a[30]
  temp[31] = a[28]
  temp[32] = a[38]
  temp[33] = a[33]
  temp[34] = a[34]
  temp[35] = a[35]
  temp[36] = a[36]
  temp[37] = a[37]
  temp[38] = a[44]
  temp[39] = a[39]
  temp[40] = a[40]
  temp[41] = a[31]
  temp[42] = a[42]
  temp[43] = a[43]
  temp[44] = a[26]
  temp[45] = a[41]
  temp[46] = a[46]
  temp[47] = a[47]
  f.write("Back_counterclockwise\n")
  return temp
def Front_to_top(a,f):
  temp = [0 for i in range(48)]
  temp[0] = a[5]
  temp[1] = a[19]
  temp[2] = a[16]
  temp[3] = a[9]
  temp[4] = a[0]
  temp[5] = a[14]
  temp[6] = a[11]
  temp[7] = a[1]
  temp[8] = a[22]
  temp[9] = a[15]
  temp[10] = a[6]
  temp[11] = a[20]
  temp[12] = a[17]
  temp[13] = a[7]
  temp[14] = a[4]
  temp[15] = a[21]
  temp[16] = a[12]
  temp[17] = a[2]
  temp[18] = a[23]
  temp[19] = a[13]
  temp[20] = a[10]
  temp[21] = a[3]
  temp[22] = a[18]
  temp[23] = a[8]
  temp[24] = a[29]
  temp[25] = a[43]
  temp[26] = a[40]
  temp[27] = a[33]
  temp[28] = a[24]
  temp[29] = a[38]
  temp[30] = a[35]
  temp[31] = a[25]
  temp[32] = a[46]
  temp[33] = a[39]
  temp[34] = a[30]
  temp[35] = a[44]
  temp[36] = a[41]
  temp[37] = a[31]
  temp[38] = a[28]
  temp[39] = a[45]
  temp[40] = a[36]
  temp[41] = a[26]
  temp[42] = a[47]
  temp[43] = a[37]
  temp[44] = a[34]
  temp[45] = a[27]
  temp[46] = a[42]
  temp[47] = a[32]
  f.write("Front_to_top\n")
  return temp


edge_index = [[31,44],[32,45],[25,41],[34,43],[30,37],[33,46],[26,35],[27,29],[28,47],[36,38],[39,42],[40,48]]

corner =[ [2,7,17], [1,10,23],[4,5,9], [3,8,11], [6,16,19],[12,13,20],[14,18,21],[15,22,24]]

def find_edge(a,b,c):
  for i in edge_index:
    if((c[i[0]-1] == a and c[i[1]-1] == b )or (c[i[0]-1] == b and c[i[1]-1]==a)):
      return [i[0],i[1]]
  return "wrong"

def find_corner(a,b,c,d):
  for i in corner:
    if((d[i[0]-1] == a and d[i[1]-1] == b and d[i[2]-1] == c)or(d[i[0]-1] == a and d[i[1]-1] == c and d[i[2]-1] == b) or(d[i[0]-1] == b and d[i[1]-1] == a and d[i[2]-1] == c) or(d[i[0]-1] == b and d[i[1]-1] == c and d[i[2]-1] == a) or(d[i[0]-1] == c and d[i[1]-1] == a and d[i[2]-1] == b) or(d[i[0]-1] == c and d[i[1]-1] == b and d[i[2]-1] == a)):
      return [i[0],i[1],i[2]]
  return "wrong"

def print_layer(a,b):
  for i in range(4):
    if(b==1):
      print('('+str(a[0])+","+str(a[24])+','+str(a[6])+')')
    elif(b==2):
      print('('+str(a[42])+','+' '+','+str(a[30])+')')
    elif(b==3):
      print('({},{},{})'.format(a[18],a[36],a[12]))
    a=change_view(a)
  print()
  
def buildcross(test,f):
  i=0
  color2 = 1
  color1 = 0
  while(i<4):

    list = find_edge(color1, color2, test)
    # print(list)
    #print(test[39],test[47])
    #print(test[38],test[41])
    if(list[0] ==25 and list[1] == 41):
      test = Front_clockwise(test,f)
    elif(list[0] == 31 and list[1] == 44):
      test = test
    elif(list[0] == 32 and list[1] == 45):
      test = Right_clockwise(test,f)
      test = Down_counterclockwise(test,f)
      test = Right_counterclockwise(test,f)
    elif(list[0] ==34 and list[1] == 43):
      test = Front_clockwise(test,f)
      test = Front_clockwise(test,f)
    elif(list[0] == 30 and list[1] == 37):
      test = Front_counterclockwise(test,f)
    elif(list[0] == 33 and list[1] == 46):
      test = Left_counterclockwise(test,f)
      test = Down_clockwise(test,f)
      test = Left_clockwise(test,f)
    elif(list[0] == 26 and list[1] == 35):
      test = Right_counterclockwise(test,f)
    elif(list[0] == 27 and list[1] == 29):
      test = Back_clockwise(test,f)
      test = Back_clockwise(test,f)
      test = Down_clockwise(test,f)
      test = Down_clockwise(test,f)
    elif(list[0] == 28 and list[1] == 47):
      test = Left_clockwise(test,f)
      test = Front_clockwise(test,f)
      test = Front_clockwise(test,f)
    elif(list[0] == 36 and list[1] == 38):
      test = Down_counterclockwise(test,f)
      # print([test[36], test[38]])
    elif(list[0] == 39 and list[1] == 42):
      test = Down_clockwise(test,f)
      test = Down_clockwise(test,f)
    elif(list[0] == 40 and list[1] == 48):
      test = Down_clockwise(test,f)
    # f.write("{}\n".format(list))
    # f.write("{} face, get into second find edge\n".format(i))
    # f.write(str(test)+"\n")
    edge = find_edge(color1,color2,test)
    if(edge[0]==31 and edge[1] == 44):
      if(test[edge[0]-1] == color2 and test[edge[1]-1] == color1):
        test = Front_counterclockwise(test,f)
      else:
        test = Top_counterclockwise(test,f)
        test = Right_clockwise(test,f)
        test = Top_clockwise(test,f)
    elif(edge[0] == 30 and edge[1] == 37):
      if(test[edge[0]-1] == color1 and test[edge[1]-1] == color2):
        test = Front_counterclockwise(test,f)
        test = Front_counterclockwise(test,f)
      else:
        test = Front_counterclockwise(test,f)
        test = Top_counterclockwise(test,f)
        test = Right_clockwise(test,f)
        test = Top_clockwise(test,f)
    elif(edge[0] == 25 and edge[1] == 41):
      if(test[edge[0]-1] == color1 and test[edge[1]-1] == color2):
        test = Front_clockwise(test,f)
        test = Top_counterclockwise(test,f)
        test = Right_clockwise(test,f)
        test = Top_clockwise(test,f)
      else:
        test = test
    else:
      print("Something go wrong")
    test = change_view(test,f)
    # f.write(str(test)+"\n")
    # f.write("{} face second edge finish\n".format(i))
    i+=1

    color2 = 1 +color2%4
    
    # print(test[4],test[28],test[10])
    # #print("\n")
    # print(test[46], color1, test[34])
    # #rint("\n")
    # print(test[22],test[40],test[16])

    # print("\n")

    # print(test[0], test[24], test[6])
    # print(test[42], color2, test[30])
    # print(test[18], test[36], test[12])
  return test
# white = 0
# green = 1
# red = 2
# blue = 3
# orange = 4
# yellow = 5
# test = [1,5,2,2,1,4,0,0,5,4,5,5,3,1,4,3,3,4,0,1,3,0,2,2,0,5,2,1,4,0,1,4,4,0,3,5,2,2,4,3,3,0,5,2,3,0,5,1]
# print(find_edge(2,1,test))
# print(Back_clockwise(test))
# print(Back_counterclockwise(test))
# print(Top_counterclockwise(Top_clockwise(test)) == test)
# print(Right_clockwise(test) == test)
k = [0 for j in range(6)]
# test = [2, 5, 1, 2, 3, 1,4,0,0,5,2,2,3,4,3,4,1,3,0,5,5,0,1,4,3,4,0,4,3,1,4,3,2,4,0,1,0,5,2,2,5,1,3,5,2,5,1,0]
# for m in range(48):
#   k[test[m]] += 1
# print(k)
# k = [0 for j in range(6)]
#corner =[ [2,7,17], [1,10,23],[4,5,9], [3,8,11], [6,16,19],[12,13,20],[14,18,21],[15,22,24]]
def Build_top(test,f):                          # white = 0
                                                # green = 1
                                                # red = 2
                                                # blue = 3
                                                # orange = 4
                                                # yellow = 5  
  i=0
  color1 = 0
  color2 = 1
  color3 = 2
  while(i<4):
    
    list = find_corner(color1,color2,color3,test)
    # print(list)
    # print([test[list[0]-1], test[list[1]-1], test[list[2]-1]])
    if(list[0] == 2 and list[1] == 7 and list[2] == 17):
      test = Right_counterclockwise(test,f)
      test = Down_counterclockwise(test,f)
      test = Right_clockwise(test,f)
      test = Down_clockwise(test,f)
    elif(list[0] == 3 and list[1] == 8 and list[2] == 11):
      test = Right_clockwise(test,f)
      test = Down_clockwise(test,f)
      test = Right_counterclockwise(test,f)
      test = Down_clockwise(test,f)
      test = Down_clockwise(test,f)
    elif(list[0] ==4 and list[1] == 5 and list[2] == 9):
      test = Left_counterclockwise(test,f)
      test = Down_clockwise(test,f)
      test = Down_clockwise(test,f)
      test = Left_clockwise(test,f)
    elif(list[0] == 1 and list[1] == 10 and list[2] ==23):
      test = Left_clockwise(test,f)
      test = Down_clockwise(test,f)
      test = Left_counterclockwise(test,f)
    elif(list[0] == 6 and list[1] == 16 and list[2] == 19):
      test = Down_clockwise(test,f)
    elif(list[0] == 15 and list[1] == 22 and list[2] == 24):
      test = Down_clockwise(test,f)
      test = Down_clockwise(test,f)
    elif(list[0] == 14 and list[1] == 18 and list[2] == 21):
      test = Down_counterclockwise(test,f)
    elif(list[0] == 12 and list[1] == 13 and list[2] == 20):
      test = test
    else:
      print("Find corner error")
    # print("corner value :")
    # print(test[11], test[12], test[19])
    # f.write(str(test)+"\n")
    # f.write("{} face get into second stage of build_corner \n".format(i))
    # print(color1, color2, color3)
    if(test[11] == color1 and test[12] == color3 and test[19] == color2):
      test = Right_counterclockwise(test,f)
      test = Down_counterclockwise(test,f)
      test = Down_counterclockwise(test,f)
      test = Right_clockwise(test,f)
      test = Down_clockwise(test,f)
      test = Right_counterclockwise(test,f)
      test = Down_counterclockwise(test,f)
      test = Right_clockwise(test,f)
    elif(test[11] == color3 and test[12] == color2 and test[19] == color1):
      test = Right_counterclockwise(test,f)
      test = Down_counterclockwise(test,f)
      test = Right_clockwise(test,f)
    elif(test[11] == color2 and test[12] == color1 and test[19] == color3):
      test = Front_clockwise(test,f)
      test = Down_clockwise(test,f)
      test = Front_counterclockwise(test,f)
    else:
      print("Something wrong!!!!!!!!!!!!!!!")
    
    # print(test[4],test[28],test[10])
    # print("\n")
    # print(test[46], color1, test[34])
    #rint("\n")
    # print(test[22],test[40],test[16])

    # print("\n")

    # print(test[0], test[24], test[6])
    # print(test[42], color2, test[30])
    # print(test[18], test[36], test[12])
    test = change_view(test,f)
    # f.write(str(test)+"\n")
    # f.write("{} face corner finish\n".format(i))
    i+=1
    color2 = color2%4+1
    color3 = color3%4+1
  return test

def Build_2nd_layer(test,f):
  i=0
  color1 = 1
  color2 = 2
  while(i<4):# white = 0
                                                # green = 1
                                                # red = 2
                                                # blue = 3
                                                # orange = 4
                                                # yellow = 5
    list = find_edge(color1, color2, test)
    # print(list)
    #edge_index = [[31,44],[32,45],[25,41],[34,43],[30,37],[33,46],[26,35],[27,29],[28,47],[36,38],[39,42],[40,48]]
    if(list[0] == 31 and list[1] == 44):
      test = Down_counterclockwise(test,f)
      test = Right_counterclockwise(test,f)
      test = Down_clockwise(test,f)
      test = Right_clockwise(test,f)
      test = Down_clockwise(test,f)
      test = Front_clockwise(test,f)
      test = Down_counterclockwise(test,f)
      test = Front_counterclockwise(test,f)
    elif(list[0] == 32 and list[1] == 45):
      test = change_view(test,f)
      test = Down_counterclockwise(test,f)
      test = Right_counterclockwise(test,f)
      test = Down_clockwise(test,f)
      test = Right_clockwise(test,f)
      test = Down_clockwise(test,f)
      test = Front_clockwise(test,f)
      test = Down_counterclockwise(test,f)
      test = Front_counterclockwise(test,f)
      test = change_view(test,f)
      test = change_view(test,f)
      test = change_view(test,f)
    elif(list[0] == 33 and list[1] == 46):
      test = change_view(test,f)
      test = change_view(test,f)
      test = Down_counterclockwise(test,f)
      test = Right_counterclockwise(test,f)
      test = Down_clockwise(test,f)
      test = Right_clockwise(test,f)
      test = Down_clockwise(test,f)
      test = Front_clockwise(test,f)
      test = Down_counterclockwise(test,f)
      test = Front_counterclockwise(test,f)
      test = change_view(test,f)
      test = change_view(test,f)
    elif(list[0] == 34 and list[1] == 43):
      test = change_view(test,f)
      test = change_view(test,f)
      test = change_view(test,f)
      test = Down_counterclockwise(test,f)
      test = Right_counterclockwise(test,f)
      test = Down_clockwise(test,f)
      test = Right_clockwise(test,f)
      test = Down_clockwise(test,f)
      test = Front_clockwise(test,f)
      test = Down_counterclockwise(test,f)
      test = Front_counterclockwise(test,f)
      test = change_view(test,f)
    # f.write(str(test)+"\n")
    # f.write("{} face get into second stage of build second edge \n".format(i))
    list = find_edge(color1, color2, test)
    # print(list)
    if(list[0] == 30 and list[1] == 37):
      test = test
    elif(list[0] == 36 and list[1] == 38):
      test = Down_counterclockwise(test,f)
    elif(list[0] == 39 and list[1] == 42):
      test = Down_counterclockwise(test,f)
      test = Down_counterclockwise(test,f)
    elif(list[0] == 40 and list[1] == 48):
      test = Down_clockwise(test,f)
    else:
      print("something goes wrong!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    # f.write(str(test)+"\n")
    # f.write("{} face get into 3rd stage of build second edge \n".format(i))
    # print(find_edge(color1, color2, test)==[30,37])
    if(test[36]==color1):
      test = Down_counterclockwise(test,f)
      test = Right_counterclockwise(test,f)
      test = Down_clockwise(test,f)
      test = Right_clockwise(test,f)
      test = Down_clockwise(test,f)
      test = Front_clockwise(test,f)
      test = Down_counterclockwise(test,f)
      test = Front_counterclockwise(test,f)
    else:
      test = Down_clockwise(test,f)
      test = change_view(test,f)
      test = Down_clockwise(test,f)
      test = Left_clockwise(test,f)
      test = Down_counterclockwise(test,f)
      test = Left_counterclockwise(test,f)
      test = Down_counterclockwise(test,f)
      test = Front_counterclockwise(test,f)
      test = Down_clockwise(test,f)
      test = Front_clockwise(test,f)
      test = change_view(test,f)
      test = change_view(test,f)
      test = change_view(test,f)
    test = change_view(test,f)
    # f.write(str(test)+"\n")
    # f.write("{} face build_edge finish\n".format(i))
    i+=1
    color1 = color1%4+1
    color2 = color2%4+1
    
  return test
def Move_of_Top_cross(test,f):
  test = Front_clockwise(test,f)
  test = Right_clockwise(test,f)
  test = Top_clockwise(test,f)
  test = Right_counterclockwise(test,f)
  test = Top_counterclockwise(test,f)
  test = Front_counterclockwise(test,f)
  return test
def Move_of_Top_cross_L(test,f):
  test = Front_clockwise(test,f)
  test = Top_clockwise(test,f)
  test = Right_clockwise(test,f)
  test = Top_counterclockwise(test,f)
  test = Right_counterclockwise(test,f)
  test = Front_counterclockwise(test,f)
  return test
def Top_Cross(test,f):
  test = Front_to_top(test,f)
  test = Front_to_top(test,f)
  # print("!!!!!!!!!!!!@$#@!#!@#!!!!!!!!!!!!!!!!!!!!!!!!\n")
  # print(test)
  # print(test[28], test[34])
  list = [test[28],test[34],test[40],test[46]]      #old 
  all_yellow = True
  for x in list:
    if(x != 5):
      all_yellow = False
  if(all_yellow):
    test = change_view(test,f)
    test = change_view(test,f)
    return test
  else:
    # f.write("one yellow in the middle cross\n")
    if(test[46] == test[34] == 5):
      test = Move_of_Top_cross(test,f)
    elif(test[28] == test[40] == 5):
      test = Top_clockwise(test,f)
      test = Move_of_Top_cross(test,f)
    elif(test[46] == test[28] == 5):
      test = Move_of_Top_cross_L(test,f)
    elif(test[28] == test[34] == 5):
      test = Top_counterclockwise(test,f)
      test = Move_of_Top_cross_L(test,f)
    elif(test[40] == test[34] == 5):
      test = Top_counterclockwise(test,f)
      test = Top_counterclockwise(test,f)
      test = Move_of_Top_cross_L(test,f)
    
    elif(test[46] == test[40] == 5):
      test = Top_clockwise(test,f)
      test = Move_of_Top_cross_L(test,f)
    else:
      test = Move_of_Top_cross(test,f)
      if(test[46] == test[34] == 5):
        test = Move_of_Top_cross(test,f)
      elif(test[28] == test[40] == 5):
        test = Top_clockwise(test,f)
        test = Move_of_Top_cross(test,f)
      elif(test[46] == test[28] == 5):
        test = Move_of_Top_cross_L(test,f)
      elif(test[28] == test[34] == 5):
        test = Top_counterclockwise(test,f)
        test = Move_of_Top_cross_L(test,f)
      elif(test[40] == test[34] == 5):
        test = Top_counterclockwise(test,f)
        test = Top_counterclockwise(test,f)
        test = Move_of_Top_cross_L(test,f)
      elif(test[46] == test[40] == 5):
        test = Top_clockwise(test,f)
        test = Move_of_Top_cross_L(test,f)
  test = change_view(test,f)
  test = change_view(test,f)
  # f.write(str(test)+"\n")
  # f.write(" 3rd cross  \n")
  return test
def Move_of_Top_edge(test,f):
  test = Right_clockwise(test,f)
  test = Top_clockwise(test,f)
  test = Right_counterclockwise(test,f)
  test = Top_clockwise(test,f)
  test = Right_clockwise(test,f)
  test = Top_clockwise(test,f)
  test = Top_clockwise(test,f)
  test = Right_counterclockwise(test,f)
  test = Top_clockwise(test,f)
  return test

def build_top_edge(test,f):
  color2 = 1
  color1 = 5
  i = 0
  list = find_edge(color1,color2,test)
  if(list[0] == 25 and list[1] == 41):
      test = test
  elif(list[0] == 26 and list[1] == 35):
      test = Top_clockwise(test,f)
  elif(list[0] == 27 and list[1] == 29):
      test = Top_clockwise(test,f)
      test = Top_clockwise(test,f)
  elif(list[0] == 28 and list[1] == 47):
      test = Top_counterclockwise(test,f)
  # print_layer(test, 1)
  test = change_view(test,f)
  # f.write(str(test)+"\n")
  # f.write(" 1st edge  \n")
  color2 = 4
  if(test[26] == color2):
    test = change_view(test,f)
    test = change_view(test,f)
    test = Move_of_Top_edge(test,f)
    test = change_view(change_view(change_view(test,f),f),f)
    test = Move_of_Top_edge(test,f)
  elif(test[25] == color2):
    test = change_view(test,f)
    test = Move_of_Top_edge(test,f)
  elif(test[24] == color2):
    test = change_view(test,f)
  else:
    print("something's wrong")
  color2 = 3
  # f.write(str(test)+"\n")
  # f.write(" 2nd edge  \n")
  if(test[24] == color2):
    test =test
    test = change_view(change_view(test,f),f)
  elif(test[25] == color2):
    test = change_view(test,f)
    test = Move_of_Top_edge(test,f)
    test = change_view(test,f)
    # print("ran")
  # f.write(str(test)+"\n")
  # f.write(" 3rd edge  \n")
  return test
  
def Move_top_corner(test,f):
  test = Top_clockwise(test,f)
  test = Right_clockwise(test,f)
  test = Top_counterclockwise(test,f)
  test = Left_counterclockwise(test,f)
  test = Top_clockwise(test,f)
  test = Right_counterclockwise(test,f)
  test = Top_counterclockwise(test,f)
  test = Left_clockwise(test,f)
  return test
    
    # if(test[40] == (test[43] - 1)):
    #   test = change_view(test)
    # elif(test[33] == (test[40] - 1)):
def Build_top_corner(test,f):
  color_list = [2,3,4,1]
  # f.write(str(test)+"\n")
  counter = 0
  #case = 1   # 1 = all wrong 2 = one right 3 = all right
  Right = False
  for i in range(len(color_list)-1,-1,-1):
    corner = find_corner(color_list[i],color_list[i-1], 5,test)
    # print(corner)
    # f.write(str(corner[0] == 2 and corner[1] == 7 and corner[2] == 17)+"\n")
    if(i == 0 and corner[0] == 2 and corner[1] == 7 and corner[2] == 17 and Right == False):
      test = Move_top_corner(test,f)
      while(find_corner(color_list[0],color_list[1], 5 , test) != [1,10,23]):
        test = Move_top_corner(test,f)
      return test
    elif(corner[0]== 2 and corner[1] == 7 and corner[2] == 17 and Right ==False):
      Right = True
    elif(corner[0]== 2 and corner[1] == 7 and corner[2] == 17 and Right == True):
      return test
    elif( not(corner[0]== 2 and corner[1] == 7 and corner[2] == 17) and Right == True):
      test = change_view(change_view(change_view(test,f),f),f)
      test = Move_top_corner(test,f)
      while(find_corner(color_list[i-2],color_list[i-3],5 , test) != [1,10,23]):
        # print(str(find_corner(color_list[i],color_list[i+1],5 , test)))
        test = Move_top_corner(test,f)
      # f.write(str(test)+"\n")
      # f.write(" jump out of 1st loop of build top corner  \n")
      return test
    
    test = change_view(test,f)
  if(Right == False):
      while(find_corner(color_list[3],color_list[0],5 , test) != [1,10,23]):
        test = Move_top_corner(test,f)
        counter +=1
        if(counter == 3):
          test = change_view(test,f)
          test = Move_top_corner(test,f)
          test = Move_top_corner(test,f)
          test = change_view(change_view(change_view(test,f),f),f)
          break
      test = change_view(change_view(change_view(test,f),f),f)
      while(find_corner(color_list[0],color_list[1],5 , test) != [1,10,23]):
        test = Move_top_corner(test,f)
      return test
 
def Move_top_corner_sepe(test,f):
  test = Right_counterclockwise(test,f)
  test = Down_clockwise(test,f)
  test = Right_clockwise(test,f)
  test = Down_counterclockwise(test,f)
  test = Right_counterclockwise(test,f)
  test = Down_clockwise(test,f)
  test = Right_clockwise(test,f)
  test = Down_counterclockwise(test,f)     
  return test

def Build_top_cor_sep(test,f):
  j = 0
  
  for i in range(4):
    while(test[16]!=5):
      test = Move_top_corner_sepe(test,f)
      j+=1
      # f.write(str(test)+"\n")
      # f.write(" {}st top_cor, {}th Move_top  \n".format(i,j))
    test = Top_clockwise(test,f)
    # f.write(str(test)+"\n")
    # f.write(" Rotate one corner successfully  \n".format(i))
    j=0
  return test   

def print_all_faces(test):
  print(test[4],test[28],test[10])
    #print("\n")
  print(test[46], " ", test[34])
  #rint("\n")
  print(test[22],test[40],test[16])

  print("\n")

  print(test[0], test[24], test[6])
  print(test[42], " ", test[30])
  print(test[18], test[36], test[12])
  test = change_view(test)

  print(test[0], test[24], test[6])
  print(test[42], " ", test[30])
  print(test[18], test[36], test[12])
  test = change_view(test)

  print(test[0], test[24], test[6])
  print(test[42], " ", test[30])
  print(test[18], test[36], test[12])
  test = change_view(test)

  print(test[0], test[24], test[6])
  print(test[42], " ", test[30])
  print(test[18], test[36], test[12])
  test = change_view(test)

  print(test[5], test[29], test[11])
  print(test[47], " ", test[35])
  print(test[23], test[41], test[17])

def solver(test,f):
  test = buildcross(test,f)
  # f.write("buildcross finish!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n\n\n")
  test = Build_top(test,f)
  # f.write("build top edge finish!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n\n\n")
  test = Build_2nd_layer(test,f)
  # f.write("build 2nd layer finish!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n\n\n")
  test = Top_Cross(test,f) 
  # f.write("build 3rd layer cross finish!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n\n\n")
  test = build_top_edge(test,f)
  # f.write("build 3rd layer edge finish!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n\n\n")
  test = Build_top_corner(test,f)
  # f.write("build 3rd layer corner finish !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n\n\n")
  # print_all_faces(test)
  test = Build_top_cor_sep(test,f)
  # f.write("build all finish !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n\n\n")
  return test
def checker(test,f):
  check_list = test[0:6]
  for i in range(1,8):
      if(test[i*6:i*6+6] != check_list):
          f.write("output is wrong\n")
          return False
  f.write("output is correct\n")
  return True
  




if __name__ == "__main__":
  file = open("../golden/output_check.txt",'w')
  check = True
  # test = [1,2,0,4,0,5,5,2,3,4,1,3,5,2,3,4,1,3,1,2,0,4,0,5,1,2,3,4,0,5,5,2,3,4,1,3,1,2,3,4,0,5,1,2,0,4,0,5]
  test = [1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5]

  test = solver(test,file)
  print(test)
#   function_list = [Front_clockwise, Front_counterclockwise, Left_clockwise,Left_counterclockwise,Right_clockwise,Right_counterclockwise,Top_clockwise,Top_counterclockwise,Back_clockwise,Back_counterclockwise,Down_clockwise,Down_counterclockwise]
#   for i in range(1,1000000):
#     test = [1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5]
#     for j in range(100):
#       random_int = random.randint(0,11)
#       test = function_list[random_int](test)
#     # gen_binary(test,i)
#     file.write("original test: {}\n".format(test))
#     test = solver(test)
#     file.write("python run result: "+str(test)+"\n")
#     check = (check and checker(test,file))
#   print(check)
  # test = [2, 5, 1, 2, 3, 1,4,0,0,5,2,2,3,4,3,4,1,3,0,5,5,0,1,4,3,4,0,4,3,1,4,3,2,4,0,1,0,5,2,2,5,1,3,5,2,5,1,0]
  # test = [1,5,2,2,1,4,0,0,5,4,5,5,3,1,4,3,3,4,0,1,3,0,2,2,0,5,2,1,4,0,1,4,4,0,3,5,2,2,4,3,3,0,5,2,3,0,5,1]
  # test = [0,5,4,0,2,2,
  #         1,3,3,1,0,1,
  #         0,4,5,3,2,3,
  #         5,2,5,4,4,1,
  #         5,3,4,1,0,5,
  #         4,2,3,2,4,0,
  #         3,1,3,0,4,2,
  #         1,1,5,0,5,2]
  
  # test = [0, 3, 3, 3, 4, 0, 
  #         5, 4, 0, 1, 5, 4, 
  #         1, 5, 0, 2, 2, 2, 
  #         1, 5, 1, 3, 4, 2, 
  #         5, 0, 1, 5, 0, 3, 
  #         2, 1, 1, 4, 3, 3, 
  #         5, 4, 2, 1, 2, 3, 
  #         0, 0, 2, 5, 4, 4]

  # test = [4, 3, 3, 1, 2, 0, 
  #         4, 5, 0, 1, 2, 1, 
  #         2, 4, 1, 3, 5, 0, 
  #         2, 5, 3, 4, 5, 0, 
  #         4, 1, 1, 3, 5, 2, 
  #         3, 4, 4, 2, 0, 4, 
  #         0, 5, 5, 3, 0, 2, 
  #         1, 2, 1, 3, 0, 5, ]

  # test = [4, 2, 1, 1, 0, 2, 
  #         1, 2, 4, 5, 5, 1, 
  #         5, 3, 2, 3, 0, 4, 
  #         5, 4, 0, 0, 3, 3, 
  #         2, 0, 4, 5, 5, 1, 
  #         3, 2, 3, 4, 4, 3, 
  #         0, 5, 4, 5, 0, 1, 
  #         3, 2, 1, 0, 2, 1, ]

  # test = [5, 5, 4, 2, 3, 2, 
  #         2, 3, 0, 3, 0, 1, 
  #         2, 5, 1, 1, 3, 1, 
  #         0, 5, 4, 4, 4, 0, 
  #         1, 4, 2, 2, 1, 1, 
  #         4, 2, 3, 0, 3, 5, 
  #         5, 2, 0, 3, 4, 4, 
  #         1, 5, 0, 0, 3, 5, ]

  # test = [5, 4, 1, 0, 3, 3, 
  #         0, 0, 4, 3, 2, 2, 
  #         3, 1, 1, 2, 1, 4, 
  #         0, 5, 5, 2, 4, 5, 
  #         1, 2, 5, 3, 3, 1, 
  #         4, 2, 4, 0, 0, 1, 
  #         2, 5, 1, 2, 4, 0, 
  #         4, 3, 3, 5, 0, 5, ]
  # test = [0, 1, 4, 2, 1, 4, 
  #       0, 3, 5, 3, 0, 5, 
  #       3, 5, 3, 0, 2, 1, 
  #       1, 4, 4, 5, 2, 2, 
  #       0, 1, 3, 1, 5, 3, 
  #       4, 1, 3, 2, 4, 1, 
  #       4, 5, 2, 4, 2, 5, 
  #       3, 0, 0, 0, 2, 5 ]
  # test = [0, 4, 2, 5, 3, 3, 
  #       3, 0, 2, 2, 3, 4, 
  #       1, 5, 1, 4, 0, 2, 
  #       5, 5, 1, 4, 1, 0, 
  #       2, 2, 4, 4, 5, 3, 
  #       1, 1, 5, 1, 3, 3, 
  #       0, 5, 2, 3, 5, 0, 
  #       4, 0, 2, 1, 0, 4, ]
  # test = [1, 5, 4, 3, 2, 3, 
  #       3, 1, 5, 2, 5, 1, 
  #       0, 0, 3, 0, 4, 4, 
  #       4, 2, 1, 2, 5, 0, 
  #       1, 0, 5, 1, 4, 5, 
  #       3, 0, 5, 2, 3, 0, 
  #       3, 1, 2, 5, 4, 3, 
  #       0, 4, 4, 2, 2, 1]
  # test = [0, 0, 3, 1, 2, 2, 
  #       4, 2, 0, 1, 0, 5, 
  #       1, 3, 4, 3, 3, 5, 
  #       5, 2, 4, 1, 4, 5, 
  #       4, 4, 2, 3, 5, 2, 
  #       5, 0, 1, 0, 3, 2, 
  #       0, 1, 5, 1, 5, 3, 
  #       4, 1, 3, 4, 2, 0]
  # test = [4, 1, 1, 2, 3, 3, 
  #       5, 2, 0, 5, 5, 5, 
  #       2, 2, 4, 0, 4, 0, 
  #       4, 3, 1, 0, 3, 1, 
  #       0, 3, 4, 3, 1, 3, 
  #       0, 4, 1, 1, 2, 2, 
  #       5, 5, 0, 4, 1, 2, 
  #       2, 3, 5, 5, 4, 0]
  # test = [1, 3, 3, 0, 4, 1, 
  #       5, 0, 1, 0, 4, 4, 
  #       5, 1, 3, 5, 2, 5, 
  #       4, 3, 2, 2, 2, 0, 
  #       5, 3, 3, 4, 4, 3, 
  #       2, 5, 0, 2, 0, 3, 
  #       2, 5, 0, 4, 2, 1, 
  #       1, 0, 1, 4, 1, 5]
  # test = [1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5]








# if(test[36]==color1):
#         test = Down_counterclockwise(test)
#         test = Right_counterclockwise(test)
#         test = Down_clockwise(test)
#         test = Right_clockwise(test)
#         test = Down_clockwise(test)
#         test = Front_clockwise(test)
#         test = Down_counterclockwise(test)
#         test = Front_counterclockwise(test)
#       else:
#         test = change_view(test)
#         test = Down_clockwise(test)
#         test = Left_clockwise(test)
#         test = Down_counterclockwise(test)
#         test = Left_counterclockwise(test)
#         test = Down_counterclockwise(test)
#         test = Front_counterclockwise(test)
#         test = Down_clockwise(test)
#         test = Front_clockwise(test)