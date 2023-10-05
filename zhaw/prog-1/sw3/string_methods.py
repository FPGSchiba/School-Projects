# -*- coding: utf-8 -*-
"""
PROG1 V03 String-Methoden

@date: 05.10.2023
@author: Jann Erhardt
"""
import string

# Exercise 16
str1 = 'I am 25 years and 10 months old'
solution = ''.join([item for item in str1 if item.isdigit()])
print(solution)

# Exercise 17
str1 = "Emma25 is Data scientist50 and AI Expert"

splits = str1.split(' ')
solution = '\n'.join([split for split in splits if any([item.isdigit() for item in split])])
print(solution)

# Exercise 18
str1 = '/*Jon is @developer & musician!!'

chars = string.punctuation
solution = ''
for char in str1:
    if char in chars:
        solution += '#'
    else:
        solution += char

print(solution)
