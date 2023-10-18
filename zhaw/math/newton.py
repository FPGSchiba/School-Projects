"""
Finally
"""
depth = 3
round_to = 5
x_zero = -0.9


def func(x):
    return 4 * x ** 5 - 1


def func1(x):
    return 5 * x ** 4 + 3


xs = []

for i in range(depth):
    if len(xs) == 0:
        xs.append(func(x_zero) / func1(x_zero))
    else:
        xs.append(func(xs[i - 1]) / func1(xs[i - 1]))

for i in range(len(xs)):
    print(f'X-{i+1}: {round(xs[i], round_to)}')
