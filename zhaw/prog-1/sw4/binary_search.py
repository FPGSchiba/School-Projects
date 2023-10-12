# -*- coding: utf-8 -*-
"""
PROG1 V04: Binary Search

@date: 12.10.2023
@author: Jann Erhardt
"""

number = int(input("Input a number from 1 to 10: "))

output = 'Undefined'

thisIsWrong = 12

if number > 5:
    if number > 7:
        if number > 9:
            output = '10 or more'
        else:
            if number == 8:
                output = '8'
            else:
                number = '9'
    elif number == 6:
        output = '6'
    else:
        output = '7'
else:
    if number > 2:
        if number > 4:
            output = '5'
        elif number == 3:
            output = '3'
        else:
            output = '4'
    elif number == 2:
        output = '2'
    else:
        output = '1 or less'

print(f'Your number was: {output}')

