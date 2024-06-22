from pycode import *
from combo_dec import *
from simc_combo_answer import *


def binary_to_decimal(string):
    sum = 0
    sum = 4*int(string[0]) + 2*int(string[1]) + int(string[2])
    return sum


def gen_test(file):
    test = [line.rstrip() for line in file]
    test = [binary_to_decimal(test[i]) for i in range(len(test))]
    return test
    
def compare(file_in, file):
    test = gen_test(file_in)
    f = open("combo_expected.txt",'w')
    test_fin = solver(test,f)
    f.close()
    f = open("combo_expected.txt", 'r')
    move_combo = dec(f)
    out_move_combo = [line.rstrip() for line in file] ##file is output file
    for i in range(len(move_combo)):
        if((move_combo[i][0]+1) == binary_to_decimal(out_move_combo[i][1:4]) and move_combo[i][1] == int(out_move_combo[i][0])):
             if(i == len(move_combo)-1 and out_move_combo[i+1] == "0000"):
                 return True
        else:
            print(i) 
            return False
    f.close()
def dec_to_formal_language(test):

    f = open("combo_expected.txt", 'w')
    test_fin = solver(test,f)
    f.close()
    f = open("combo_expected.txt", 'r')
    move_combo = dec(f)
     ##file is output file
    # for i in range(len(move_combo)):
    #     if((move_combo[i][0]+1) == binary_to_decimal(out_move_combo[i][1:4]) and move_combo[i][1] == int(out_move_combo[i][0])):
    #         if(i == len(move_combo)-1 and out_move_combo[i+1] == "0000"):
    #             return True
    #     else:
    #         print(i) 
    #         return False
    f.close()
    file = open("../golden/motor_dec.txt",'r')
    lines = [line for line in file]
    file.close()
    file = open("../golden/Human_language_output.txt",'w')
    for line in lines:
        if(line[0] == "0"):
            if(line[2] == "0"):
                file.write("Top_clockwise\n")
            if(line[2] == "1"):
                file.write("Top_counterclockwise\n")
        if(line[0] == "1"):
            if(line[2] == "0"):
                file.write("Front_clockwise\n")
            if(line[2] == "1"):
                file.write("Front_counterclockwise\n")
        if(line[0] == "2"):
            if(line[2] == "0"):
                file.write("Right_clockwise\n")
            if(line[2] == "1"):
                file.write("Right_counterclockwise\n")
        if(line[0] == "3"):
            if(line[2] == "0"):
                file.write("Back_clockwise\n")
            if(line[2] == "1"):
                file.write("Back_counterclockwise\n")
        if(line[0] == "4"):
            if(line[2] == "0"):
                file.write("Left_clockwise\n")
            if(line[2] == "1"):
                file.write("Left_counterclockwise\n")
        if(line[0] == "5"):
            if(line[2] == "0"):
                file.write("Down_clockwise\n")
            if(line[2] == "1"):
                file.write("Down_counterclockwise\n")
    file.close()
# def gen_golden(move_combo):
#     f = open("")
if __name__ == "__main__":
    # for i in range(1,101):
    #     file_name = "../input/init_state_{}.txt".format(i)
    #     output_file = "../output/output_{}.txt".format(i)
    #     file = open(file_name, 'r')
    #     file_out = open(output_file, 'r')
    #     print(compare(file, file_out),i)
    test = [1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5,1,2,3,4,0,5]
    for i in range(3):
        test = Right_counterclockwise(test)
        test = Back_counterclockwise(test)
    dec_to_formal_language(test)
             


