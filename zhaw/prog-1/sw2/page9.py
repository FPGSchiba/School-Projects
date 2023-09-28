# -*- coding: utf-8 -*-
"""
PROG1 V02 page 09: Variables and basics

@date: 28.09.2023
@author: Jann Erhardt
"""

# Begin Page 9

print("f(x) = 2x^2 + 8")
x = float(input("Please give a value for 'x’: "))
print(f"f({x:.2f}) = {2*(pow(x, 2)) + 8:.2f}")  # pow(x,2) == x**2

# Exercise 1

number = float(input("Please give me a number: "))
string = input("Please give me a small text: ")

print(f'{number} {string}')
print(f'Number: {number:.2f}\nString: {string.strip()}')

# End Page 9
