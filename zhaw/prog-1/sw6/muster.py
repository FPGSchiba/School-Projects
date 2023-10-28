# -*- coding: utf-8 -*-
"""
PROG1 P03 G3: Draw a board

@date: 28.10.2023
@author: Jann Erhardt
"""

BOARD_SIZE = 15

SYMBOL_1 = 'x'
SYMBOL_2 = '*'
SYMBOL_3 = 'o'

START_POINT = 0
END_POINT = 0

END = ' '

for i in range(BOARD_SIZE):
    for j in range(BOARD_SIZE):
        if i * j % 3 == 0:
            print(SYMBOL_3, end=END)
        elif i * j % 3 == 1:
            print(SYMBOL_2, end=END)
        elif i * j % 3 == 2:
            print(SYMBOL_1, end=END)
    print()
