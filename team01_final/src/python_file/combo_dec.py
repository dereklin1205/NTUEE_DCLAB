#encode all of the step into move for different face motor

#clockwise 0 counterclockwise 1

def dec(file):
    lines = [line.rstrip() for line in file]
    count = 0
    move_combo = []
    list_0 = [1,2,3,4,0,5]
    list_1 = [1,4,3,2,5,0]
    face = 0
    flip = 0
    counter = 0
    for line in lines:        
        counter +=1                                      #first is which face second is rotated direction
        if(line == "Front_clockwise"):
            if(flip == 0):
                move_combo.append([list_0[face], 0])
            else :
                move_combo.append([list_1[face], 0])
        elif(line == "Front_counterclockwise"):
            if(flip == 0):
                move_combo.append([list_0[face], 1])
            else :
                move_combo.append([list_1[face], 1])
        elif(line == "Right_clockwise"):
            if(flip == 0):
                move_combo.append([list_0[(face+1)%4], 0])
            else :
                move_combo.append([list_1[(face+1)%4], 0])
        elif(line == "Right_counterclockwise"):
            if(flip == 0):
                move_combo.append([list_0[(face+1)%4], 1])
            else :
                move_combo.append([list_1[(face+1)%4], 1])
        elif(line == "Back_clockwise"):
            if(flip == 0):
                move_combo.append([list_0[(face+2)%4], 0])
            else :
                move_combo.append([list_1[(face+2)%4], 0])
        elif(line == "Back_counterclockwise"):
            if(flip == 0):
                move_combo.append([list_0[(face+2)%4], 1])
            else :
                move_combo.append([list_1[(face+2)%4], 1])
        elif(line == "Left_clockwise"):
            if(flip == 0):
                move_combo.append([list_0[(face-1)%4], 0])
            else :
                move_combo.append([list_1[(face-1)%4], 0])
        elif(line == "Left_counterclockwise"):
            if(flip == 0):
                move_combo.append([list_0[(face-1)%4], 1])
            else :
                move_combo.append([list_1[(face-1)%4], 1])
        elif(line == "Down_clockwise"):
            if(flip == 0):
                move_combo.append([list_0[5], 0])
            else :
                move_combo.append([list_1[5], 0])
        elif(line == "Down_counterclockwise"):
            if(flip == 0):
                move_combo.append([list_0[5], 1])
            else :
                move_combo.append([list_1[5], 1])
        elif(line == "Top_clockwise"):
            if(flip == 0):
                move_combo.append([list_0[4], 0])
            else :
                move_combo.append([list_1[4], 0])
        elif(line == "Top_counterclockwise"):
            if(flip == 0):
                move_combo.append([list_0[4], 1])
            else :
                move_combo.append([list_1[4], 1])
        elif(line == "change_view"):
            face = (face+1)%4
        elif(line == "Front_to_top"):
            count = count +1
            if(count % 2 == 0):
                flip = not flip
                face = (face+2)%4
        else:
            print(counter,line)
    file = open("../golden/motor_dec.txt",'w')
    for i in move_combo:
        file.write(str(i[0])+" ")
        file.write(str(i[1]))
        file.write("\n")
    file.close()
    return move_combo


    

    
    
