# -*- coding: utf-8 -*-
"""
PROG1 P03: Domino

@date: 28.10.2023
@author: Jann Erhardt
"""
DOMINO_RANGES = range(7)

COMBINATIONS = []

for i in DOMINO_RANGES:
    for j in DOMINO_RANGES:
        if (i,j) in COMBINATIONS or (j,i) in COMBINATIONS:
            continue
        COMBINATIONS.append((i,j))

string = ''
for comb in COMBINATIONS:
    string +='(' + str(comb[0]) + '|' + str(comb[1]) + '),'

print(string[0:-1])
