# -*- coding: utf-8 -*-
"""
PROG1 P04 2.4: Rock Paper Scissors

@date: 14.10.2023
@author: Jann Erhardt
"""
import random
import os
import sys

OPTIONS = ['play', 'quit']
GAME_OPTIONS = ['rock', 'paper', 'scissors']
clear = lambda: os.system('cls' if os.name == 'nt' else 'clear')

while True:
    # Clearing screen
    clear()
    # Rematch handling
    option = input('What would you like to do (play, quit)? ')
    if option in OPTIONS:
        # Playing
        if option == 'play':
            # Header
            print('=' * 3, 'rock', '=' * 3, 'paper', '=' * 3, 'scissors', '=' * 3)

            # Game
            item = input('Input rock, paper or scissors: ').lower()
            if item in GAME_OPTIONS:

                # Bot selection
                bot_item = GAME_OPTIONS[random.randint(0, 2)]

                # Win / Loss check
                if bot_item == item:
                    result = 'draw'
                elif bot_item == 'rock' and item == 'paper':
                    result = 'win'
                elif bot_item == 'paper' and item == 'scissors':
                    result = 'win'
                elif bot_item == 'scissors' and item == 'rock':
                    result = 'win'
                else:
                    result = 'loss'

                # Results
                print('Your Result:')
                print(f'You chose: {item}')
                print(f'The computer chose: {bot_item}')
                print(f'The Game was a: {result}')
                input('Press enter to continue...')
            else:
                # Unknown Game Command
                input(f'Not know command: {item}, exiting game... [enter to continue]')
        # Exiting
        elif option == 'quit':
            sys.exit(0)
    # Wrong Option
    else:
        input('This was not a valid option. [enter to continue]')
