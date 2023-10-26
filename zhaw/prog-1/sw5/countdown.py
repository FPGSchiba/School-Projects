# -*- coding: utf-8 -*-
"""
PROG1 P03 1.1: Countdown

@date: 21.10.2023
@author: Jann Erhardt
"""
import time

user_number = int(input('Bitte geben Sie eine ganze Zahl ein: '))

for number in range(user_number, 0, -1):
    print(number)
    time.sleep(0.1)
