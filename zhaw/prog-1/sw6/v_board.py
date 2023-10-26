# -*- coding: utf-8 -*-
"""
PROG1 V06: Listenausgabe

@date: 26.10.2023
@author: Jann Erhardt
"""
liste = \
    [[0, 0, 0, 0, 1, 1, 0, 0],
     [0, 2, 0, 0, 0, 1, 2, 0],
     [0, 0, 0, 0, 0, 0, 0, 0],
     [0, 0, 0, 0, 0, 0, 0, 0],
     [0, 0, 0, 0, 0, 1, 0, 0],
     [0, 0, 0, 0, 1, 1, 0, 0],
     [0, 2, 0, 0, 0, 0, 2, 0],
     [0, 0, 0, 0, 1, 0, 0, 0]]

outs = ['.', '#', '*']

for row in liste:
    for item in row:
        print(outs[item], end=' ')
    print()
