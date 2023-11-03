import math

RANGE = 10000000
A1 = 6
D = 6
Q = 2

GOAL = 6138


def geometric(n):
    return A1 * Q ** (n - 1)


def sum_geometric(n):
    return A1 * ((1 - Q**n)/(1 - Q))


def aritmetic(n):
    return A1 + (n - 1) * D


def sum_aritmetic(n):
    return (n / 2) * (A1 + aritmetic(n))


values = []

for i in range(RANGE):
    if sum_geometric(i) == GOAL:
        print(i)
        break

print(values)
