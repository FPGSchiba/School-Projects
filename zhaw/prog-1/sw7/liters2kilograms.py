# -*- coding: utf-8 -*-
"""
PROG1 P04 1.4: Liters to Kilograms

@date: 04.11.2023
@author: Jann Erhardt
"""

def convert(liters: float, density: float):
    """
    Converts liters and the density to kilograms
    :param liters: float, the Liters to convert
    :param density: float, the density of the liquid in kg/l
    :return: float, the weight of the liquid in Kilogram
    """
    return liters * density
