# -*- coding: utf-8 -*-
"""
PROG1 P02 Aufgabe 4.4: Sqrt with math

@date: 30.09.2023
@author: Jann Erhardt
"""
# compute the square root of a quantity (number) a and store it in a variable square_root_of_a:
import math

positions_plane_1 = input('X, Y Coordinates for Plane 1 comma seperated (X,Y): ').split(',')
positions_plane_1 = [float(coord) for coord in positions_plane_1]

positions_plane_2 = input('X, Y Coordinates for Plane 2 comma seperated (X,Y): ').split(',')
positions_plane_2 = [float(coord) for coord in positions_plane_2]

distance = math.sqrt((positions_plane_2[0] - positions_plane_1[0])**2 + (positions_plane_2[1] - positions_plane_1[1])**2)

print(f'Distance between Plane 1 and Plane 2: {distance:.2f}')
