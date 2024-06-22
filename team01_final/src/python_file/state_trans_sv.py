f = open("transition.sv", 'w')
f1 = open("change_view.txt", 'r')
f2 = open("Front_clockwise.txt",'r')
f3 = open("Front_counterclockwise.txt",'r')
f4 = open("Left_clockwise.txt",'r')
f5 = open("Left_counterclockwise.txt",'r')
f6 = open("Right_clockwise.txt",'r')
f7 = open("Right_counterclockwise.txt",'r')
f8 = open("Top_clockwise.txt",'r')
f9 = open("Top_counterclockwise.txt",'r')
f10 = open("Down_clockwise.txt",'r')
f11 = open("Down_counterclockwise.txt",'r')
f12 = open("Back_clockwise.txt",'r')
f13 = open("Back_counterclockwise.txt",'r')
f14 = open("Front_to_top.txt",'r')
lines = f1.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("task change_view;\n ")
f.write(" input [2:0] i_c_state [0:47];\n")
f.write(" output [2:0] o_c_state[0:47];\n")
f.write(" begin\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  o_c_state[{}] = i_c_state[{}];\n".format(int(a)-1,int(b)-1))
f.write("  end\n")
f.write("  endtask\n")
lines = f2.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("task Front_clockwise;\n ")
f.write(" input [2:0] i_c_state [0:47];\n")
f.write(" output [2:0] o_c_state[0:47];\n")
f.write(" begin\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  o_c_state[{}] = i_c_state[{}];\n".format(int(b)-1,int(a)-1))
f.write("  end\n")
f.write("  endtask\n")
lines = f3.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("task Front_counterclockwise;\n ")
f.write(" input [2:0] i_c_state [0:47];\n")
f.write(" output [2:0] o_c_state[0:47];\n")
f.write(" begin\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  o_c_state[{}] = i_c_state[{}];\n".format(int(b)-1,int(a)-1))
f.write("  end\n")
f.write("  endtask\n")
lines = f4.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("task Left_clockwise;\n ")
f.write(" input [2:0] i_c_state [0:47];\n")
f.write(" output [2:0] o_c_state[0:47];\n")
f.write(" begin\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  o_c_state[{}] = i_c_state[{}];\n".format(int(a)-1,int(b)-1))
f.write("  end\n")
f.write("  endtask\n")
lines = f5.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("task Left_counterclockwise;\n ")
f.write(" input [2:0] i_c_state [0:47];\n")
f.write(" output [2:0] o_c_state[0:47];\n")
f.write(" begin\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  o_c_state[{}] = i_c_state[{}];\n".format(int(a)-1,int(b)-1))
f.write("  end\n")
f.write("  endtask\n")
lines = f6.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("task Right_clockwise;\n ")
f.write(" input [2:0] i_c_state [0:47];\n")
f.write(" output [2:0] o_c_state[0:47];\n")
f.write(" begin\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  o_c_state[{}] = i_c_state[{}];\n".format(int(b)-1,int(a)-1))
f.write("  end\n")
f.write("  endtask\n")
lines = f7.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("task Right_counterclockwise;\n ")
f.write(" input [2:0] i_c_state [0:47];\n")
f.write(" output [2:0] o_c_state[0:47];\n")
f.write(" begin\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  o_c_state[{}] = i_c_state[{}];\n".format(int(b)-1,int(a)-1))
f.write("  end\n")
f.write("  endtask\n")
lines = f8.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("task Top_clockwise;\n ")
f.write(" input [2:0] i_c_state [0:47];\n")
f.write(" output [2:0] o_c_state[0:47];\n")
f.write(" begin\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  o_c_state[{}] = i_c_state[{}];\n".format(int(b)-1,int(a)-1))
f.write("  end\n")
f.write("  endtask\n")
lines = f9.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("task Top_counterclockwise;\n ")
f.write(" input [2:0] i_c_state [0:47];\n")
f.write(" output [2:0] o_c_state[0:47];\n")
f.write(" begin\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  o_c_state[{}] = i_c_state[{}];\n".format(int(b)-1,int(a)-1))
f.write("  end\n")
f.write("  endtask\n")
lines = f10.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("task Down_clockwise;\n ")
f.write(" input [2:0] i_c_state [0:47];\n")
f.write(" output [2:0] o_c_state[0:47];\n")
f.write(" begin\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  o_c_state[{}] = i_c_state[{}];\n".format(int(a)-1,int(b)-1))
f.write("  end\n")
f.write("  endtask\n")
lines = f11.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("task Down_counterclockwise;\n ")
f.write(" input [2:0] i_c_state [0:47];\n")
f.write(" output [2:0] o_c_state[0:47];\n")
f.write(" begin\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  o_c_state[{}] = i_c_state[{}];\n".format(int(a)-1,int(b)-1))
f.write("  end\n")
f.write("  endtask\n")

lines = f12.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("task Back_clockwise;\n ")
f.write(" input [2:0] i_c_state [0:47];\n")
f.write(" output [2:0] o_c_state[0:47];\n")
f.write(" begin\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  o_c_state[{}] = i_c_state[{}];\n".format(int(a)-1,int(b)-1))
f.write("  end\n")
f.write("  endtask\n")

lines = f13.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("task Back_counterclockwise;\n ")
f.write(" input [2:0] i_c_state [0:47];\n")
f.write(" output [2:0] o_c_state[0:47];\n")
f.write(" begin\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  o_c_state[{}] = i_c_state[{}];\n".format(int(a)-1,int(b)-1))
f.write("  end\n")
f.write("  endtask\n")
lines = f14.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("task Front_to_top;\n ")
f.write(" input [2:0] i_c_state [0:47];\n")
f.write(" output [2:0] o_c_state[0:47];\n")
f.write(" begin\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  o_c_state[{}] = i_c_state[{}];\n".format(int(a)-1,int(b)-1))
f.write("  end\n")
f.write("  endtask\n")


f.close()
