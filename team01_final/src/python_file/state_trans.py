f = open("transition.py", 'w')
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
f.write("def change_view(a):\n ")
f.write(" temp = [0 for i in range(48)]\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  temp[{}] = a[{}]\n".format(int(a)-1,int(b)-1))
f.write("  print(\"change_value\")\n")
f.write("  return temp\n")
lines = f2.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("def Front_clockwise(a):\n ")
f.write(" temp = [0 for i in range(48)]\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  temp[{}] = a[{}]\n".format(int(b)-1,int(a)-1))
f.write("  print(\"Front_clockwise\")\n")    
f.write("  return temp\n")
lines = f3.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("def Front_counterclockwise(a):\n ")
f.write(" temp = [0 for i in range(48)]\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  temp[{}] = a[{}]\n".format(int(b)-1,int(a)-1))
f.write("  print(\"Front_counterclockwise\")\n")   
f.write("  return temp\n")
lines = f4.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("def Left_clockwise(a):\n ")
f.write(" temp = [0 for i in range(48)]\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  temp[{}] = a[{}]\n".format(int(a)-1,int(b)-1))
f.write("  print(\"Left_clockwise\")\n")   
f.write("  return temp\n")
lines = f5.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("def Left_counterclockwise(a):\n ")
f.write(" temp = [0 for i in range(48)]\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  temp[{}] = a[{}]\n".format(int(a)-1,int(b)-1))
f.write("  print(\"Left_counterclockwise\")\n")   
f.write("  return temp\n")
lines = f6.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("def Right_clockwise(a):\n ")
f.write(" temp = [0 for i in range(48)]\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  temp[{}] = a[{}]\n".format(int(b)-1,int(a)-1))
f.write("  print(\"Right_clockwise\")\n")   
f.write("  return temp\n")
lines = f7.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("def Right_counterclockwise(a):\n ")
f.write(" temp = [0 for i in range(48)]\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  temp[{}] = a[{}]\n".format(int(b)-1,int(a)-1))
f.write("  print(\"Right_counterclockwise\")\n")   
f.write("  return temp\n")
lines = f8.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("def Top_clockwise(a):\n ")
f.write(" temp = [0 for i in range(48)]\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  temp[{}] = a[{}]\n".format(int(b)-1,int(a)-1))
f.write("  print(\"Top_clockwise\")\n")   
f.write("  return temp\n")
lines = f9.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("def Top_counterclockwise(a):\n ")
f.write(" temp = [0 for i in range(48)]\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  temp[{}] = a[{}]\n".format(int(b)-1,int(a)-1))
f.write("  print(\"Top_counterclockwise\")\n")   
f.write("  return temp\n")
lines = f10.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("def Down_clockwise(a):\n ")
f.write(" temp = [0 for i in range(48)]\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  temp[{}] = a[{}]\n".format(int(a)-1,int(b)-1))
f.write("  print(\"Down_clockwise\")\n")   
f.write("  return temp\n")
lines = f11.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("def Down_counterclockwise(a):\n ")
f.write(" temp = [0 for i in range(48)]\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  temp[{}] = a[{}]\n".format(int(a)-1,int(b)-1))
f.write("  print(\"Down_counterclockwise\")\n")   
f.write("  return temp\n")

lines = f12.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("def Back_clockwise(a):\n ")
f.write(" temp = [0 for i in range(48)]\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  temp[{}] = a[{}]\n".format(int(a)-1,int(b)-1))
f.write("  print(\"Back_clockwise\")\n")   
f.write("  return temp\n")

lines = f13.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("def Back_counterclockwise(a):\n ")
f.write(" temp = [0 for i in range(48)]\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  temp[{}] = a[{}]\n".format(int(a)-1,int(b)-1))
f.write("  print(\"Back_counterclockwise\")\n")   
f.write("  return temp\n")
lines = f14.readlines()
lines = [line.strip().split('\t') for line in lines]
f.write("def Front_to_top(a):\n ")
f.write(" temp = [0 for i in range(48)]\n")
for i in range(len(lines)):
    a = lines[i][0]
    b = lines[i][1]
    f.write("  temp[{}] = a[{}]\n".format(int(a)-1,int(b)-1))
f.write("  print(\"Front_to_top\")\n")   
f.write("  return temp\n")


f.close()
