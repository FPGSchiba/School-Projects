# -*- coding: utf-8 -*-
"""
PROG1 P09 9.2: Largesr product in a Grid

@date: 15.11.2023
@author: Jann Erhardt
"""
import random
import threading

SIZE = 20
KERNEL_SIZE = 4
grid = [[random.randint(1, 99) for _ in range(SIZE)] for _ in range(SIZE)]
DIAGONAL_GREATEST = 0
VERTICAL_GREATEST = 0
HORIZONTAL_GREATEST = 0
GREATEST_POSITION_D = [(0, 0) * KERNEL_SIZE]
GREATEST_POSITION_V = [(0, 0) * KERNEL_SIZE]
GREATEST_POSITION_H = [(0, 0) * KERNEL_SIZE]


def get_greatest_product(kernel: list[list[int]], i: int, j: int) -> tuple[int, list[tuple[int, int]]]:
    """
    Calculate the greatest product for a part of the grid
    :param j: j, Current x position in the grid
    :param i: i, Current y position in the grid
    :param kernel: The current kernel to analyse
    :return: The greatest product within the kernel
    """
    top_down = 1
    bottom_up = 1
    position_top = []
    position_bottom = []
    for index in range(KERNEL_SIZE):
        top_down *= kernel[index][index]
        position_top.append((index + i, index + j))
    count = 1
    for index in range(KERNEL_SIZE):
        bottom_up *= kernel[KERNEL_SIZE - count][index]
        position_bottom.append((KERNEL_SIZE - count + i, index + j))
        count += 1
    if top_down > bottom_up:
        return top_down, position_top
    else:
        return bottom_up, position_bottom


def calculate_diagonals():
    """
    Calculates all Diagonal products
    :return: None
    """
    global GREATEST_POSITION_D
    global DIAGONAL_GREATEST
    n_moves = SIZE - 2
    greatest = 0
    greatest_position = None
    for i in range(n_moves - 1):
        for j in range(n_moves - 1):
            kernel = []
            for kernel_i in range(KERNEL_SIZE):
                kernel.append([])
                for kernel_j in range(KERNEL_SIZE):
                    grid_i = i + kernel_i
                    grid_j = j + kernel_j
                    value = grid[grid_i][grid_j]
                    kernel[kernel_i].append(value)
            product, position = get_greatest_product(kernel, i, j)
            if product >= greatest:
                greatest = product
                greatest_position = position
    DIAGONAL_GREATEST = greatest
    GREATEST_POSITION_D = greatest_position


def calculate_verticals():
    """
    Calculates the greatest vertical product
    :return: None
    """
    global GREATEST_POSITION_V
    global VERTICAL_GREATEST
    n_moves = SIZE - 2
    greatest = 0
    greatest_positions = None
    for i in range(n_moves - 1):
        for j in range(n_moves - 1):
            product = 1
            positions = []
            for vertical in range(KERNEL_SIZE):
                index = i + vertical
                value = grid[index][j]
                product *= value
                positions.append((index, j))
            if product >= greatest:
                greatest = product
                greatest_positions = positions
    VERTICAL_GREATEST = greatest
    GREATEST_POSITION_V = greatest_positions


def calculate_horizontals():
    """
    Calculates the greatest horizontal product
    :return: None
    """
    global GREATEST_POSITION_H
    global HORIZONTAL_GREATEST
    n_moves = SIZE - 2
    greatest = 0
    greatest_position = None
    for i in range(n_moves - 1):
        for j in range(n_moves - 1):
            product = 1
            positions = []
            for horizontal in range(KERNEL_SIZE):
                index = j + horizontal
                value = grid[i][index]
                product *= value
                positions.append((i, index))
            if product >= greatest:
                greatest = product
                greatest_position = positions
    HORIZONTAL_GREATEST = greatest
    GREATEST_POSITION_H = greatest_position


diagonals = threading.Thread(target=calculate_diagonals)
verticals = threading.Thread(target=calculate_verticals)
horizontals = threading.Thread(target=calculate_horizontals)
diagonals.start()
verticals.start()
horizontals.start()
threads = [diagonals, verticals, horizontals]

for thread in threads:
    thread.join()

products = [DIAGONAL_GREATEST, VERTICAL_GREATEST, HORIZONTAL_GREATEST]
positions = [GREATEST_POSITION_D, GREATEST_POSITION_V, GREATEST_POSITION_H]
max_index = products.index(max(products))
for row in grid:
    for number in row:
        print(f'{number:02d} ', end='')
    print()

print(f'Max Product: {products[max_index]}')
print(f'Location: {positions[max_index]}')

print('Max Product Type: ', end='')
if max_index == 0:
    print('Diagonal')
elif max_index == 1:
    print('vertical')
else:
    print('Horizontal')
