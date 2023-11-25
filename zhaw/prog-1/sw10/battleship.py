# -*- coding: utf-8 -*-
"""
PROG1 P09 9.3: Battleship

@date: 25.11.2023
@author: Jann Erhardt
"""
import datetime
import os
import random
import re
import string

SIZE = 10  # Cannot be higher then 26
MAX_GUESSES = 10
WATER = 0
SHIP = 1
HIT = 2
LOG_FILE = './log.txt'
board = [[WATER for _ in range(SIZE)] for _ in range(SIZE)]
guesses = 0

if not os.path.exists(LOG_FILE):
    open(LOG_FILE, 'x')

rand_x = random.randint(0, SIZE - 1)
rand_y = random.randint(0, SIZE - 1)

board[rand_x][rand_y] = SHIP


def log(message: str, level: str = 'info'):
    """
    Appends a message to the log file.
    :param message: str, the message to log.
    :param level: str, the level to log at.
    :return: None
    """
    line = f'[{datetime.datetime.now().strftime("%d.%m.%Y %H:%M:%S")}] ({level}) | {message}\n'
    print(line)
    with open(LOG_FILE, 'a', encoding='utf-8') as file:
        file.write(line)
        file.close()


def show(field: list[list[int]], num_guess: int) -> None:
    """
    Prints the board to the screen.
    :param num_guess: int, how many guesses the user already had.
    :param field: list, the board to print to the screen.
    :return: None
    """
    print('=' * 10 + " BOARD " + '=' * 10)
    for i in range(SIZE + 1):
        if i == 0:
            print("  ", end='')
        else:
            print(f'{string.ascii_lowercase[i - 1]} ', end='')
    print()
    for x, row in enumerate(field):
        print(f'{x} ', end='')
        for value in row:
            if value == WATER:
                print('o ', end='')
            elif value == SHIP:
                print('o ', end='')
            elif value == HIT:
                print('x ', end='')
        print()
    print(f'Guesses: {num_guess}')


def get_input() -> tuple[int, int]:
    """
    Gets the Input of the player.
    :return: tuple, the x and y coordinates to Hit.
    """
    print('\n' + '=' * 10 + ' INPUT ' + '=' * 10)
    correct_input = False
    inp = ''
    while not correct_input:
        inp = input('Field to hit: ([a-z][0-9] z.b: b5): ')
        match = re.match(r'^[a-z][0-9]{1,2}$', inp)
        if match:
            correct_input = True
        else:
            print('Bitte die Vorgaben des Inputs beachten, danke :D')
    column = string.ascii_lowercase.index(inp[0])
    if len(inp) == 2:
        row = int(inp[1])
    else:
        row = int(inp[1:])
    if row < SIZE and column < SIZE:
        return column, row


while guesses < MAX_GUESSES:
    show(board, guesses)
    target = get_input()
    if target:
        target_value = board[target[0]][target[1]]
        if target_value == WATER:
            board[target[0]][target[1]] = HIT
            log(f'Guess {guesses + 1}: shoots ({target[0]}, {target[1]}) misses.')
        elif target_value == HIT:
            print('The location you selected, was already hit, please select again.')
            log(f'Guess {guesses + 1}: shoots at already shot spot: ({target[0]}, {target[1]})', 'warning')
            input('Press [enter] to continue...')
            continue
        elif target_value == SHIP:
            print('You Hit the Ship and won the Game!')
            log(f'Guess {guesses + 1}: shoots ({target[0]}, {target[1]}) Hits ship.')
            break
        guesses += 1
    else:
        print('Please select values within the bound of the board.')
        log(f'Guess {guesses + 1}: Shoots at Spot not within Field: ({target[0]}, {target[1]})', 'error')
        input('Press [enter] to continue...')
        continue

if guesses == MAX_GUESSES:
    print('You do not have any Guesses left, please try again.')
    log(f'Ship was at ({rand_x}, {rand_y}) - nice try ;)')
