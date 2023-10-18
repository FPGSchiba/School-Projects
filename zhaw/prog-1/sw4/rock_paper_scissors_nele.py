# -*- coding: utf-8 -*-
"""
@author: neleb
"""

# Eingabe
x = "rock"
y = "paper"
z = "scissors"
# Ich würde Variablen immer nachdem bennen, was sie sind, also scissor_value = "scissors" oder so
# ähnlich, macht den code viel lesbarer

# generate computer's choice
import random  # Konvention: import steht immer ganz oben, unterhalb des headers

values = ["rock", "paper", "scissors"]
selection_computer = random.choice(values)  # Sehr gute anwendung, aber lists hatten wir noch nicht ;)

# input
your_selection = input("Let's play a game. Rock, paper, scissors, go![rock,paper,scissors]: ")

# Hier könntest du überprüfen, ob die auswahl richtig, war, als z.B.
# if your_selection in values:
# Dann bräuchtests du nur 4 Vergleiche: 1x Unentschieden schauen und 3x Schauenen,
# ob der Spieler gewonnen gat, dann kennst du alle Endungen des Spiels

# print the both selections
print("Computer chose " + str(selection_computer) + ".")
print("You chose " + str(your_selection) + ".")

# processing and output
if your_selection == selection_computer:
    print("draw game, insert new value")
elif your_selection == x and selection_computer == y:
    print("Computer beat you:(")
elif your_selection == x and selection_computer == z:
    print("You won!")
elif your_selection == y and selection_computer == x:
    print("Computer beat you:(")
elif your_selection == y and selection_computer == z:
    print("You won!")
elif your_selection == z and selection_computer == x:
    print("Computer beat you:(")
elif your_selection == z and selection_computer == y:
    print("You beat computer!")
else:  # Ein print hier hätte glaube ich gereicht, aber gute Anwendung von raise
    raise SystemExit("Enter correct value.")
