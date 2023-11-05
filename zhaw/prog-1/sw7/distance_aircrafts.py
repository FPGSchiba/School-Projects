# -*- coding: utf-8 -*-
"""
PROG1 P04 1.3: Distance between aircraft

@date: 04.11.2023
@author: Jann Erhardt
"""


def distance(x1: float, y1: float, x2: float, y2: float):
    """
    Calculates a distance, between 2 2D points.
    :param x1: float, x-coordinate of Point 1
    :param y1: float, y-coordinate of Point 1
    :param x2: float, x-coordinate of Point 2
    :param y2: float, y-coordinate of Point 2
    :return: The distance, between the points.
    """
    delta_x = abs(x1 - x2)
    delta_y = abs(y1 - y2)
    return (delta_x ** 2 + delta_y ** 2) ** 0.5
