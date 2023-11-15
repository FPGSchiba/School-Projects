# -*- coding: utf-8 -*-
"""
PROG1 P09 9.1: GPS Tracking & Length

@date: 15.11.2023
@author: Jann Erhardt
"""
import math


def pathlength(trail: list) -> float:
    """
    Calculates the Trail Path from Points in the GPS System
    :param trail: list of Points, that make up the trail walked.
    :return: float, the total distance of the trail
    """
    values = []
    for i in range(1, len(trail)):
        entry_now = trail[i]
        entry_before = trail[i - 1]
        x1 = entry_now[0]
        y1 = entry_now[1]
        x2 = entry_before[0]
        y2 = entry_before[1]
        values.append(math.sqrt((x1 - x2) ** 2 + (y1 - y2) ** 2))
    return sum(values)


if __name__ == '__main__':
    length = pathlength([(142.492, 208.536), (142.658, 207.06), (143.522, 205.978), (145.009, 205.546)])
    print(length)
