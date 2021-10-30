import random
from collections import deque
from datetime import time, datetime
from random import randint

import numpy as np
import pygame
from src.function.game_classes.field import Field
from src.function.game_classes.hider import Hider
from src.function.game_classes.seeker import Player
from src.function.util.stopwatch import Stopwatch
from src.function.util.Image2Array import EnvironmentGenerator
from src.function.util.config import Config

CONFIG = Config()

color_dict = {
    0: (255, 255, 255),
    1: (0, 0, 0),
    2: (2, 58, 218),
    3: (218, 2, 5),
    4: (55, 77, 33),
    5: (33, 77, 60),
    10: (111, 218, 2),
    11: (130, 200, 200),
    12: (87, 47, 23),
    13: (55, 109, 1),
    20: (255, 0, 0),
    21: (0, 0, 255)
}


class Environment:
    P_HEIGHT = 2  # Height of the player
    F_HEIGHT = 100  # Height of the field
    WIDTH = 100  # Width of the field and the walls
    HEIGHT_MUL = 20  # Height Multiplier (used to draw np.array as blocks in pygame )
    WIDTH_MUL = 20  # Width Multiplier (used to draw np.array as blocks in pygame )
    WINDOW_HEIGHT = 600  # Height of the pygame window
    WINDOW_WIDTH = 600  # Widh of the pygame window

    ENVIRONMENT_SHAPE = (F_HEIGHT, WIDTH, 1)
    ACTION_SPACE = [0, 1, 2, 3, 4]
    ACTION_SPACE_SIZE = len(ACTION_SPACE)
    PUNISHMENT = -100  # Punishment increment
    REWARD = 10  # Reward increment
    score = 0  # Initial Score

    MOVE_WALL_EVERY = 4  # Every how many frames the wall moves.
    MOVE_PLAYER_EVERY = 1  # Every how many frames the player moves.
    frames_counter = 0

    def __init__(self):
        self.found = False
        self.field = self.hider = self.player = None
        self.stopwatch = Stopwatch()
        self.generator = EnvironmentGenerator(CONFIG.files.maps.city)
        self.generator.transform_matrix()
        self.current_state = self.reset()
        self.val2color = color_dict
        self.game_over = False
        self.MAX_VAL = 0

    def reset(self):
        self.frames_counter = 0
        self.game_over = False
        self.found = False
        self.stopwatch.start()
        self.field = Field(self.generator)
        old_hider_array = np.argwhere(self.field.body == 21)
        old_seeker_array = np.argwhere(self.field.body == 20)
        for hider_pos in old_hider_array:
            self.field.body[hider_pos[0], hider_pos[1]] = 0
        for seeker_pos in old_seeker_array:
            self.field.body[seeker_pos[0], seeker_pos[1]] = 0
        hider_x, hider_y = self.find_hider_pos()
        seeker_x, seeker_y = self.find_hider_pos()
        self.hider = Hider(hider_x=hider_x, hider_y=hider_y, material=21, field=self.field)
        self.player = Player(height=self.P_HEIGHT, x=seeker_x, y=seeker_y, speed=1)
        # Update the field :
        self.field.put_hider_on_field(self.hider)
        self.field.update_field(self.player)
        self.MAX_VAL = 2

        observation = self.field.body / self.MAX_VAL

        return observation

    def find_hider_pos(self):
        air_array = np.argwhere(self.field.body == 0)
        return air_array[random.randint(0, len(air_array) - 1)]

    def print_text(self, WINDOW=None, text_cords=(0, 0), center=False,
                   text="", color=(0, 0, 0), size=32):
        pygame.init()
        font = pygame.font.Font('freesansbold.ttf', size)
        text_to_print = font.render(text, True, color)
        textRect = text_to_print.get_rect()
        if center:
            textRect.center = text_cords
        else:
            textRect.x = text_cords[0]
            textRect.y = text_cords[1]
        WINDOW.blit(text_to_print, textRect)

    def step(self, action, score_increased):
        self.frames_counter += 1
        reward = 0

        # If the performed action is (move) then player.move method is called:
        if action in [1, 2]:
            self.player.move_x(direction=action, field=self.field)
        # If the performed action is (change_width) then player.change_width method is called:
        if action in [3, 4]:
            self.player.move_y(direction=action, field=self.field)

        # Update the field :
        self.field.update_field(self.player)

        # If the player passed a wall successfully increase the reward +1
        if self.seeker_near_hider():
            reward += self.REWARD
            self.score += self.REWARD
            score_increased = True
            self.found = True

        #  Lose Conditions :
        # C1 : The player hits a wall
        # C2 : Player's width was far thinner than hole's width
        # C3 : Player fully consumed its stamina (energy)
        lose_conds = [self.stopwatch.get_time() >= 30]

        # If one lose condition or more happend, the game ends:
        if True in lose_conds:
            self.game_over = True
            reward = self.PUNISHMENT
            return self.field.body / self.MAX_VAL, reward, self.game_over, score_increased

        # Return New Observation , reward, game_over(bool)
        return self.field.body / self.MAX_VAL, reward, self.game_over, score_increased

    def seeker_near_hider(self):
        if self.hider.hider_x - 1 <= self.player.x <= self.hider.hider_x + 1:
            if self.hider.hider_y - 1 <= self.player.y <= self.hider.hider_y + 1:
                return True
        return False

    def render(self, score_increased, WINDOW=None, human=False):
        if human:
            action = 0
            events = pygame.event.get()
            for event in events:
                if event.type == pygame.QUIT:
                    self.game_over = True
                if event.type == pygame.KEYDOWN:
                    if event.key == pygame.K_LEFT:
                        action = 1
                    if event.key == pygame.K_RIGHT:
                        action = 2
                    if event.key == pygame.K_UP:
                        action = 4
                    if event.key == pygame.K_DOWN:
                        action = 3
            reward, self.game_over, score_increased = self.step(action, score_increased)

        self.field.update_field(self.player)
        for r in range(self.field.body.shape[0]):
            for c in range(self.field.body.shape[1]):
                try:
                    pygame.draw.rect(WINDOW,
                                     self.val2color[self.field.body[r][c]],
                                     (c * 6, r * 6, 10, 10))
                except KeyError:
                    print(f"y:{r}, x:{c} - {self.field.body[r][c]}")
                    pass

        self.print_text(WINDOW=WINDOW, text_cords=(self.WINDOW_WIDTH // 2, int(self.WINDOW_HEIGHT * 0.1)),
                        text=str(self.score), color=(255, 0, 0), center=True)
        self.print_text(WINDOW=WINDOW, text_cords=(self.WINDOW_WIDTH * 0.8, int(self.WINDOW_HEIGHT * 0.1)),
                        text=self.stopwatch.get_time_string(), color=(255, 0, 0), center=True)

        pygame.display.update()
        return score_increased


if __name__ == '__main__':
    env = Environment()
