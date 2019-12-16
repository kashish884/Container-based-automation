import csv
import os

class ContactDetails():
    def __init__(self, filename):
        with open(filename, "r") as f_input:
            csv_input = csv.reader(f_input)
            self.details = list(csv_input)

    def get_col_row(self, col, row):
        return self.details[row-1][col-1]

data = ContactDetails("input.csv")

net = data.get_col_row(0,1)
cont1 = data.get_col_row(1,1)
cont2 = data.get_col_row(2,1)




f = open("net.txt","w+")
f.write(net)

f = open("c1.txt","w+")
f.write(cont1)

f = open("c2.txt","w+")
f.write(cont2)




os.system("sudo bash ansible_scripts.sh")

