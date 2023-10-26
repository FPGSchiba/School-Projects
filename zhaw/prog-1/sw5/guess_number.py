# -*- coding: utf-8 -*-
"""
PROG1 P03 1.2: Guess the number

@date: 21.10.2023
@author: Jann Erhardt
"""
import random

guessed = False
computer_number = random.randint(1, 10)

while not guessed:
    user_number = int(input('Bitte geben Sie eine ganze Zahl von 1 bis 10 an: '))
    if user_number == computer_number:
        guessed = True
    elif user_number > computer_number:
        print('Die nummer war zu gross.')
    elif user_number < computer_number:
        print('Die nummer war zu klein.')

print(f'Du hast die numer: {computer_number} erfolgreich erraten!')

