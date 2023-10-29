import random
import time
import subprocess

import pygame
from button import Button

# Source https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

SIZE = 300
BEGINNING_CELLS = round((SIZE*SIZE)/20)
SCALE = 3

FPS = 10

AGE_DEATH_CAP = 10
DEAD_CELL = 0
MUTATED_CELL = -1

MUTATION_CHANCE = 0.1
INSTANT_DEATH_CHANCE = 0.1

AGING_FACTOR = 8
DEAD_COLOR = pygame.Color(255, 255, 255)

playing = True

environment = [[DEAD_CELL for _ in range(SIZE)] for _ in range(SIZE)]

pygame.init()
screen = pygame.display.set_mode((SIZE*SCALE, SIZE*SCALE))
clock = pygame.time.Clock()

def get_num_neighbors(x, y):
    neighbors = 0
    #Check for errors
    env_size = SIZE - 1
    if x < env_size and environment[y][x+1] != DEAD_CELL:
        neighbors += 1
    if x > 0 and environment[y][x-1] != DEAD_CELL:
        neighbors += 1
    if y < env_size and environment[y+1][x] != DEAD_CELL:
        neighbors += 1
    if y > 0 and environment[y-1][x] != DEAD_CELL:
        neighbors += 1
    if x < env_size and y < env_size and environment[y+1][x+1] != DEAD_CELL:
        neighbors += 1
    if x > 0 and y < env_size and environment[y+1][x-1] != DEAD_CELL:
        neighbors += 1
    if y > 0 and x < env_size and environment[y-1][x+1] != DEAD_CELL:
        neighbors += 1
    if y > 0 and x > 0 and environment[y-1][x-1] != DEAD_CELL:
        neighbors += 1
    return neighbors

def draw_cell(x, y, cell): # X = 1 -> Scaled-X: 4
    scaled_x = x * SCALE
    scaled_y = y * SCALE
    pos = (scaled_x, scaled_y)
    if cell == DEAD_CELL:
        color = DEAD_COLOR
    elif cell <= MUTATED_CELL:
        cell = abs(cell)
        if cell * 4 < 200:
            color = (0, 0, cell*4)
        else:
            color = (0, 0, 200)
    else:
        if cell * 4 < 200:
            color = (cell*4, cell*4, cell*4)
        else:
            color = (200, 200, 200)
    screen.fill(color, (pos, (SCALE, SCALE)))

def prepare_game():
    global environment
    environment = [[DEAD_CELL for _ in range(SIZE)] for _ in range(SIZE)]
    generated_cells = 0

    for _ in range(BEGINNING_CELLS):
        generating = True
        while generating:
            x = random.randint(0, SIZE - 1)
            y = random.randint(0, SIZE - 1)
            if environment[y][x] == DEAD_CELL:
                environment[y][x] = 1
                generated_cells += 1
                generating = False

    print(f'Starting Game with: {generated_cells} cells.')
    screen.fill((255, 255, 255), ((0,0), (SIZE, SIZE)))
    pygame.display.flip()

restartButton = Button(0, 0, 100, 50, screen, 'Restart', prepare_game)
prepare_game()

while playing:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            playing = False

    for y, row in enumerate(environment):
        for x, cell in enumerate(row):
            draw_cell(x, y, cell)
            num_neighbors = get_num_neighbors(x, y)
            if cell == DEAD_CELL:
                if num_neighbors == 3:
                    environment[y][x] += 1
            else:
                if random.random() < INSTANT_DEATH_CHANCE and not cell <= MUTATED_CELL:
                    environment[y][x] = DEAD_CELL
                elif (num_neighbors > 3 or num_neighbors < 2) and not cell <= MUTATED_CELL:
                    environment[y][x] = DEAD_CELL
                else:
                    # Check for mutation
                    if cell <= MUTATED_CELL:
                        environment[y][x] -= 1
                    else:
                        environment[y][x] += 1
                        if random.random() < MUTATION_CHANCE:
                            environment[y][x] = MUTATED_CELL
                if cell > AGE_DEATH_CAP or cell < -AGE_DEATH_CAP*2:
                    environment[y][x] = DEAD_CELL

    restartButton.process()
    pygame.display.flip()
    clock.tick(FPS)

pygame.quit()