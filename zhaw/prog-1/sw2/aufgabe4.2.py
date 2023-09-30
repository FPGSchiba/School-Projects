# -*- coding: utf-8 -*-
"""
PROG1 P02 Aufgabe 4.2: Physics (breaking)

@date: 30.09.2023
@author: Jann Erhardt
"""
g = 9.81
v = float(input('Velocity, before breaking [m/s]: '))
mu = float(input('Friction coefficient []: '))

d = 0.5*v**2/(mu*g)

print(f'Breaking distance: {d:.2f}m')
