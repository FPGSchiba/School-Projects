# -*- coding: utf-8 -*-
"""
PROG1 P02 G3: Draw a Board

@date: 02.11.2023
@author: Jann Erhardt
"""

BEGIN = -2
NUM_END = 3
SIZE = 15

SYMBOL_1 = 'x'
SYMBOL_2 = '-'

END = ' '

for i in range(SIZE):
    count = BEGIN
    for j in range(SIZE):
        if BEGIN <= j < NUM_END:
            if count % 2 == 0:
                print(SYMBOL_2, end=END)
            else:
                print(SYMBOL_1, end=END)
        else:
            print(SYMBOL_1, end=END)
        count += 1
    NUM_END += 1
    BEGIN += 1
    print()
