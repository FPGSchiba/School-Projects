import numpy as np


class Player:
    def __init__(self, height=1, width=1, x=0, y=0, speed=2):
        self.height = height
        self.width = width
        self.x = x
        self.y = y
        self.old_x = 0
        self.old_y = 0
        self.body = 20

    def move_x(self, field, direction=0):
        '''
        Moves the player :
         - No change          = 0
         - left, if direction  = 1
         - right, if direction = 2
        '''
        val2dir = {0: 0, 1: -1, 2: 1}
        direction = val2dir[direction]
        next_x = (self.x + direction)
        if next_x + self.width <= field.width and next_x >= 0:
            if field.body[self.y, next_x] == 0:
                self.old_y = self.y
                self.old_x = self.x
                self.x = next_x

    def move_y(self, field, direction=0):
        '''
        Change the player's width:
         - No change          = 0
         - narrow by one unit = 3
         - widen by one unit  = 4
        '''
        val2dir = {0: 0, 3: 1, 4: -1}
        direction = val2dir[direction]
        next_y = (self.y + direction)
        if not (next_y + self.width > field.width or next_y < 0):
            if field.body[next_y, self.x] == 0:
                self.old_y = self.y
                self.old_x = self.x
                self.y = next_y
