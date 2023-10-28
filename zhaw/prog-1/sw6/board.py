# -*- coding: utf-8 -*-
"""
PROG1 P03: Draw a board

@date: 28.10.2023
@author: Jann Erhardt
"""

LENGTH = 14

LAST_POINT = 1
FIRST_POINT = 0
END = ''
POINT = '.'
CROSS = 'x'

for i in range(LENGTH + 1):
    for j in range(LENGTH + 1):
        if LAST_POINT >= j >= FIRST_POINT:
            print(POINT, end=END)
        else:
            print(CROSS, end=END)
    print()
    LAST_POINT += 1
    if not i == 0:
        FIRST_POINT += 1
