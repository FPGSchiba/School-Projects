# -*- coding: utf-8 -*-
"""
PROG1 P04 1.1: Breaking Distance

@date: 04.11.2023
@author: Jann Erhardt
"""


def calc_distance(v0: float, mu: float):
    """
    This function calculates the breaking distance for a start velocity and a friction coefficient
    :param v0: float,  Starting velocity [m/s]
    :param mu: float, Friction coefficient
    :return: float, the distance in meters
    """
    g = 9.81
    return 0.5 * (v0 / 3.6) ** 2 / (mu * g)


print(calc_distance(120, 0.3))
