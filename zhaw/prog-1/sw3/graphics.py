# -*- coding: utf-8 -*-
"""
PROG1 P03 Aufgabe 1.1: Text-based graphics with Python

@date: 07.10.2023
@author: Jann Erhardt
"""
import math

image_length = 5

for i in range(1, math.ceil(image_length / 2) + 1):
    print(('* ' * i).strip())

for i in range(math.floor(image_length / 2), 0, -1):
    print(('* ' * i).strip())
