from random import randint
import numpy as np


class Hider:
    def __init__(self,  hider_x, hider_y, height=1, width=1, material=13, field=None):
        self.hider_x = hider_x
        self.hider_y = hider_y
        self.material = material
        self.height = height
        self.width = width
        self.field = field
        self.body_unit = 1
        self.body = np.full((self.height, self.width), self.material) * self.body_unit
        self.out_of_range = False
