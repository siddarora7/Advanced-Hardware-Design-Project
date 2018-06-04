//
//  main.cpp
//  machinecode
//
//  Created by Karl bou khalil on 11/18/16.
//  Copyright © 2016 Karl bou khalil. All rights reserved.
//

#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include<bitset>

#define R 0
#define I 1
#define J 2

using namespace std;

int Opcode(string opcode, ofstream &outfile) {
    
    if ((opcode == "add ") || (opcode == "sub ") || (opcode == "and ")
        || (opcode == "or  ") || (opcode == "nor ")) {
        outfile<<"000000";
        
        return R;
    }
    if (opcode == "addi") {
        outfile<<"000001";
        return I;
    }
    if (opcode == "subi") {
        outfile<<"000010";
        return I;
    }
    if (opcode == "andi") {
        outfile<<"000011";
        return I;
    }
    if (opcode == "ori ") {
        outfile<<"000100";
        return I;
    }
    if (opcode == "shl ") {
        outfile<<"000101";
        return I;
    }
    if (opcode == "shr ") {
        outfile<<"000110";
        return I;
    }
    if (opcode == "lw  ") {
        outfile<<"000111";
        return I;
    }
    if (opcode == "sw  ") {
        outfile<<"001000";
        return I;
    }
    if (opcode == "blt ") {
        outfile<<"001001";
        return I;
    }
    if (opcode == "beq ") {
        outfile<<"001010";
        return I;
    }
    if (opcode == "bne ") {
        outfile<<"001011";
        return I;
    }
    if (opcode == "jmp ") {
        outfile<<"001100";
        return J;
    }
    if (opcode == "hal ") {
        outfile<<"111111";
        return J;
    }
    
    return R;
}

void operand(string op, ofstream &outfile) {
    
    string tmp = "  ";
    tmp[0] = op[1];
    tmp[1] = op[2];
    int num = stoi(tmp);
    outfile<<bitset<5>(num);
}

void Function(string opcode, ofstream &outfile) {
    
    if (opcode == "add ")
        outfile<<"010000";
    if (opcode == "sub ")
        outfile<<"010001";
    if (opcode == "and ")
        outfile<<"010010";
    if (opcode == "or  ")
        outfile<<"010011";
    if (opcode == "nor ")
        outfile<<"010100";
}

int main(int argc, const char * argv[]) {
    ifstream file("code.txt");
    string line;
    
    ofstream outfile;
    outfile.open("machinecodeBIN.txt");
    
    while (getline(file, line)) {
        int i = 0;
        string opcode = "    ";
        string op1 = "rss";
        string op2 = "rtt";
        string op3 = "rdd";
        string imm = "     ";
        string addr = "        ";
        
        while (line[i] != ' ') {
            opcode[i] = line[i];
            i++;
        }
        
        int type = Opcode(opcode, outfile);
        
        if (type == R) {
            i++;
            int j = 0;
            
            while (line[i] != ',') {
                op1[j++] = line[i++];
            }
            
            i += 2;
            j = 0;
            while (line[i] != ',') {
                op2[j++] = line[i++];
            }
            
            i += 2;
            j = 0;
            while (line[i]) {
                op3[j++] = line[i++];
            }
            
            operand(op3, outfile);
            operand(op2, outfile);
            operand(op1, outfile);
            
            outfile<<"00000"; // Shamt
            
            Function(opcode, outfile);
            
            outfile<<endl;
        }
        else if (type == I) {
            i++;
            int j = 0;
            
            while (line[i] != ',') {
                op1[j++] = line[i++];
            }
            
            i += 2;
            j = 0;
            while (line[i] != ',') {
                op2[j++] = line[i++];
            }
            
            operand(op2, outfile);
            operand(op1, outfile);
            
            i += 2;
            j = 0;
            while (line[i]) {
                imm[j++] = line[i++];
            }
            
            int num = stoi(imm);
            outfile<<bitset<16>(num);
            
            outfile<<endl;
        }
        else if (type == J) {
            i++;
            int j = 0;
            
            if (opcode == "jmp ") {
                while (line[i]) {
                    addr[j++] = line[i++];
                }
                
                int num = stoi(addr);
                outfile<<bitset<26>(num);
            }
            else if (opcode == "hal ") {
                outfile<<"00000000000000000000000000";
            }
            
            outfile<<endl;
        }
    }
    
    file.close();
    outfile.close();
    
    ifstream infile("machinecodeBIN.txt");
    string fline;
    
    ofstream Outfile;
    Outfile.open("machinecodeHEX.txt");
    
    while (getline(infile, fline)) {
        Outfile<<"x\"";
        int i = 0;
        string bin = "    ";
        while (fline[i]) {
            bin[i%4] = fline[i];
            
            if (i%4 == 3) {
                if (bin == "0000")
                    Outfile<<"0";
                if (bin == "0001")
                    Outfile<<"1";
                if (bin == "0010")
                    Outfile<<"2";
                if (bin == "0011")
                    Outfile<<"3";
                if (bin == "0100")
                    Outfile<<"4";
                if (bin == "0101")
                    Outfile<<"5";
                if (bin == "0110")
                    Outfile<<"6";
                if (bin == "0111")
                    Outfile<<"7";
                if (bin == "1000")
                    Outfile<<"8";
                if (bin == "1001")
                    Outfile<<"9";
                if (bin == "1010")
                    Outfile<<"A";
                if (bin == "1011")
                    Outfile<<"B";
                if (bin == "1100")
                    Outfile<<"C";
                if (bin == "1101")
                    Outfile<<"D";
                if (bin == "1110")
                    Outfile<<"E";
                if (bin == "1111")
                    Outfile<<"F";
            }
            i++;
        }
        Outfile<<"\","<<endl;
    }
    
    infile.close();
    Outfile.close();
    
    return 0;
}
