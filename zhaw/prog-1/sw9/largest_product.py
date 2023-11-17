# -*- coding: utf-8 -*-
"""
PROG1 P09 9.2: Largesr product in a Grid

@date: 15.11.2023
@author: Jann Erhardt
"""
import random
import threading

SIZE = 4
KERNEL_SIZE = 4


def get_greatest_product(kernel, i: int, j: int):
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
    for index in range(KERNEL_SIZE):
        count = index + 1
        bottom_up *= kernel[index][KERNEL_SIZE - count]
        position_bottom.append((index + i, KERNEL_SIZE - count + j))
    if top_down > bottom_up:
        return top_down, position_top
    else:
        return bottom_up, position_bottom


def calculate_diagonals(numbers):
    """
    Calculates all Diagonal products
    :return: None
    """
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
                    value = numbers[grid_i][grid_j]
                    kernel[kernel_i].append(value)
            product, position = get_greatest_product(kernel, i, j)
            if product >= greatest:
                greatest = product
                greatest_position = position
    return greatest, greatest_position


def calculate_verticals(numbers):
    """
    Calculates the greatest vertical product
    :return: None
    """
    greatest = 0
    greatest_positions = None
    for i in range(SIZE):
        for j in range(SIZE):
            product = 1
            positions = []
            for vertical in range(KERNEL_SIZE):
                index = i + vertical
                if index >= SIZE:
                    break
                value = numbers[index][j]
                product *= value
                positions.append((index, j))
            if product > greatest:
                greatest = product
                greatest_positions = positions
    return greatest, greatest_positions


def calculate_horizontals(numbers):
    """
    Calculates the greatest horizontal product
    :return: None
    """
    greatest = 0
    greatest_position = None
    for i in range(SIZE):
        for j in range(SIZE):
            product = 1
            positions = []
            for horizontal in range(KERNEL_SIZE):
                index = j + horizontal
                if index >= SIZE:
                    break
                value = numbers[i][index]
                product *= value
                positions.append((i, index))
            if product > greatest:
                greatest = product
                greatest_position = positions
    return greatest, greatest_position


def find_largest_product(numbers):
    """
    Bullcrap
    :param numbers: The grid
    :return: Product and position
    """
    global SIZE
    SIZE = len(numbers)
    greatest_dia, position_dia = calculate_diagonals(numbers)
    greatest_ver, position_ver = calculate_verticals(numbers)
    greatest_hor, position_hor = calculate_horizontals(numbers)
    products = [greatest_ver, greatest_hor, greatest_dia]
    positions = [position_ver, position_hor, position_dia]
    max_index = products.index(max(products))
    return products[max_index], ((positions[max_index][0]), positions[max_index][-1])


if __name__ == '__main__':
    examples = [[[1, 1, 1, 1, 1], [1, 1, 1, 1, 1], [1, 1, 1, 1, 1], [1, 1, 1, 1, 1], [1, 1, 1, 1, 1]],
                [[1, 1, 1, 1, 1], [11, 1, 1, 1, 1], [1, 11, 1, 1, 1], [1, 1, 11, 1, 1], [1, 1, 1, 11, 1]],
                [[1, 1, 1, 1, 1], [1, 1, 1, 11, 1], [1, 1, 11, 1, 1], [1, 11, 1, 1, 1], [11, 1, 1, 1, 1]],
                [[1, 1, 1, 1, 1], [1, 1, 1, 1, 1], [1, 1, 1, 1, 1], [1, 1, 1, 1, 1], [11, 11, 11, 11, 1]],
                [[1, 1, 1, 1, 1], [11, 1, 1, 1, 1], [11, 1, 1, 1, 1], [11, 1, 1, 1, 1], [11, 1, 1, 1, 1]],
                [[1, 1, 1, 1, 1], [1, 11, 1, 1, 1], [1, 1, 11, 1, 1], [1, 1, 1, 11, 1], [1, 1, 1, 1, 11]],
                [[1, 1, 1, 1, 1], [1, 1, 1, 1, 11], [1, 1, 1, 11, 1], [1, 1, 11, 1, 1], [1, 11, 1, 1, 1]],
                [[1, 1, 1, 1, 1], [1, 1, 1, 1, 1], [1, 1, 1, 1, 1], [1, 1, 1, 1, 1], [1, 11, 11, 11, 11]],
                [[1, 1, 1, 1, 1], [1, 1, 1, 1, 11], [1, 1, 1, 1, 11], [1, 1, 1, 1, 11], [1, 1, 1, 1, 11]],
                [[1, 1, 1, 1, 1, 1], [1, 11, 1, 1, 1, 1], [1, 1, 11, 1, 1, 1], [1, 1, 1, 11, 1, 1], [1, 1, 1, 1, 11, 1], [1, 1, 1, 1, 1, 1]],
                [[1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 11, 1], [1, 1, 1, 11, 1, 1], [1, 1, 11, 1, 1, 1], [1, 11, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1]],
                [[1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1], [1, 11, 11, 11, 11, 1], [1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1]],
                [[1, 1, 1, 1, 1, 1], [1, 1, 11, 1, 1, 1], [1, 1, 11, 1, 1, 1], [1, 1, 11, 1, 1, 1], [1, 1, 11, 1, 1, 1], [1, 1, 1, 1, 1, 1]],
                [[8, 2, 22, 97, 38, 15, 0, 40, 0, 75, 4, 5, 7, 78, 52, 12, 50, 77, 91, 8],
                 [49, 49, 99, 40, 17, 81, 18, 57, 60, 87, 17, 40, 98, 43, 69, 48, 4, 56, 62, 0],
                 [81, 49, 31, 73, 55, 79, 14, 29, 93, 71, 40, 67, 53, 88, 30, 3, 49, 13, 36, 65],
                 [52, 70, 95, 23, 4, 60, 11, 42, 69, 24, 68, 56, 1, 32, 56, 71, 37, 2, 36, 91],
                 [22, 31, 16, 71, 51, 67, 63, 89, 41, 92, 36, 54, 22, 40, 40, 28, 66, 33, 13, 80],
                 [24, 47, 32, 60, 99, 3, 45, 2, 44, 75, 33, 53, 78, 36, 84, 20, 35, 17, 12, 50],
                 [32, 98, 81, 28, 64, 23, 67, 10, 26, 38, 40, 67, 59, 54, 70, 66, 18, 38, 64, 70],
                 [67, 26, 20, 68, 2, 62, 12, 20, 95, 63, 94, 39, 63, 8, 40, 91, 66, 49, 94, 21],
                 [24, 55, 58, 5, 66, 73, 99, 26, 97, 17, 78, 78, 96, 83, 14, 88, 34, 89, 63, 72],
                 [21, 36, 23, 9, 75, 0, 76, 44, 20, 45, 35, 14, 0, 61, 33, 97, 34, 31, 33, 95],
                 [78, 17, 53, 28, 22, 75, 31, 67, 15, 94, 3, 80, 4, 62, 16, 14, 9, 53, 56, 92],
                 [16, 39, 5, 42, 96, 35, 31, 47, 55, 58, 88, 24, 0, 17, 54, 24, 36, 29, 85, 57],
                 [86, 56, 0, 48, 35, 71, 89, 7, 5, 44, 44, 37, 44, 60, 21, 58, 51, 54, 17, 58],
                 [19, 80, 81, 68, 5, 94, 47, 69, 28, 73, 92, 13, 86, 52, 17, 77, 4, 89, 55, 40],
                 [4, 52, 8, 83, 97, 35, 99, 16, 7, 97, 57, 32, 16, 26, 26, 79, 33, 27, 98, 66],
                 [88, 36, 68, 87, 57, 62, 20, 72, 3, 46, 33, 67, 46, 55, 12, 32, 63, 93, 53, 69],
                 [4, 42, 16, 73, 38, 25, 39, 11, 24, 94, 72, 18, 8, 46, 29, 32, 40, 62, 76, 36],
                 [20, 69, 36, 41, 72, 30, 23, 88, 34, 62, 99, 69, 82, 67, 59, 85, 74, 4, 36, 16],
                 [20, 73, 35, 29, 78, 31, 90, 1, 74, 31, 49, 71, 48, 86, 81, 16, 23, 57, 5, 54],
                 [1, 70, 54, 71, 83, 51, 54, 69, 16, 92, 33, 48, 61, 43, 52, 1, 89, 19, 67, 48]],
                [[11, 1, 1, 1, 1], [1, 11, 1, 1, 1], [1, 1, 11, 1, 1], [1, 1, 1, 11, 1], [1, 1, 1, 1, 1]],
                [[1, 1, 1, 11, 1], [1, 1, 11, 1, 1], [1, 11, 1, 1, 1], [11, 1, 1, 1, 1], [1, 1, 1, 1, 1]],
                [[11, 11, 11, 11, 1], [1, 1, 1, 1, 1], [1, 1, 1, 1, 1], [1, 1, 1, 1, 1], [1, 1, 1, 1, 1]],
                [[11, 1, 1, 1, 1], [11, 1, 1, 1, 1], [11, 1, 1, 1, 1], [11, 1, 1, 1, 1], [1, 1, 1, 1, 1]],
                [[1, 11, 1, 1, 1], [1, 1, 11, 1, 1], [1, 1, 1, 11, 1], [1, 1, 1, 1, 11], [1, 1, 1, 1, 1]],
                [[1, 1, 1, 1, 11], [1, 1, 1, 11, 1], [1, 1, 11, 1, 1], [1, 11, 1, 1, 1], [1, 1, 1, 1, 1]],
                [[1, 11, 11, 11, 11], [1, 1, 1, 1, 1], [1, 1, 1, 1, 1], [1, 1, 1, 1, 1], [1, 1, 1, 1, 1]],
                [[1, 1, 1, 1, 11], [1, 1, 1, 1, 11], [1, 1, 1, 1, 11], [1, 1, 1, 1, 11], [1, 1, 1, 1, 1]]]
    for grid in examples:
        product, position = find_largest_product(grid)
        print('Product: ' + str(product))
        print('Position: ' + str(position))
        print()
