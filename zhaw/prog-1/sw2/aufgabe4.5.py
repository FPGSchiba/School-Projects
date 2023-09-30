# -*- coding: utf-8 -*-
"""
PROG1 P02 Aufgabe 4.5: Kilograms to Liters

@date: 30.09.2023
@author: Jann Erhardt
"""

quantity_liters = float(input('Liters [l]: '))
density_fluid = float(input('Density for Fluid [kg/l]: '))

print(f'Weight: {density_fluid * quantity_liters} kg')
