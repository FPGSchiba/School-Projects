import math

RANGE = 10000000
A1 = 6
D = 6

GOAL = 6138

def aritmetic(n):
    return A1 + (n - 1) * D

def sum_aritmetic(n):
    return (n/2)*(A1 + aritmetic(n))

values = []

for i in range(RANGE):
    if sum_aritmetic(i) == GOAL:
        values.append(i)

print(values)
