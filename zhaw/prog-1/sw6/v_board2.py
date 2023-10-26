# -*- coding: utf-8 -*-
"""
PROG1 V06: Listenindex

@date: 26.10.2023
@author: Jann Erhardt
"""
import random

board = \
    [[0, 0, 0, 0, 0, 0, 0, 0],
     [0, 0, 0, 0, 0, 0, 0, 0],
     [0, 0, 0, 0, 0, 0, 0, 0],
     [0, 0, 0, 0, 0, 0, 0, 0],
     [0, 0, 0, 0, 0, 0, 0, 0],
     [0, 0, 0, 0, 0, 0, 0, 0],
     [0, 0, 0, 0, 0, 0, 0, 0],
     [0, 0, 0, 0, 0, 0, 0, 0]]

ir = random.randint(0, len(board) - 1)
ic = random.randint(0, len(board[0]) - 1)

for i, row in enumerate(board):
    for j, item in enumerate(row):
        if ir == i and ic == j:
            print('*', end=' ')
        else:
            print('.', end=' ')
    print()
