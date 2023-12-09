# -*- coding: utf-8 -*-
"""
PROG1 P07 3: Phone Book

@date: 09.12.2023
@author: Jann Erhardt
"""
import json
import os.path

PHONE_BOOK = {}


def print_numbers():
    """
    Prints all the numbers and corresponding names.
    :return: None
    """
    print('== NUMBERS ==')
    for item in PHONE_BOOK.items():
        print(f'{item[0]}: {item[1]}')


def add_number(name: str, number: str):
    """
    Adds a new number to the Phone Book
    :param name: str, the name of the person which has this number
    :param number: str, the number to save
    :return: None
    """
    if name not in PHONE_BOOK.keys():
        PHONE_BOOK[name] = number
    else:
        print('This name already has a Number.')


def lookup_number(name: str):
    """
    Looks the number up for a name.
    :param name: str, the name to lookup the number from.
    :return: str, the number for a name
    """
    try:
        return PHONE_BOOK[name]
    except KeyError:
        return 'Name has no Number.'


def remove_number(name: str):
    """
    Removes a number from the Phone book with a name.
    :param name: The name to delete the number from.
    :return: None
    """
    try:
        del PHONE_BOOK[name]
    except KeyError:
        print('Number does not exist.')


def load_numbers(file_name: str) -> dict | None:
    """
    Loads the phone book from a json file.
    :param file_name: str, the filename of the json file to load from.
    :return: dict, the loaded Phone Book
    """
    if not os.path.isfile(file_name):
        print('File does not exist.')
        return None
    with open(file_name, 'r', encoding='utf-8') as file:
        return json.load(file)


def save_numbers(file_name: str):
    """
    Saves a File containing the Dictionary to a file.
    :param file_name: str, The filename of a json file
    :return: None
    """
    if os.path.isfile(file_name):
        print('A file already exists with this name.')
        print('Overwriting existing file...')
    with open(file_name, 'w+', encoding='utf-8') as file:
        json.dump(PHONE_BOOK, file)


def print_menu():
    """
    Prints the menu of the Application
    :return: None
    """
    print('=== PHONE BOOK ===')
    print('1. Print Phone Numbers')
    print('2. Add a Phone Number')
    print('3. Remove a Phone Number')
    print('4. Lookup a Phone Number')
    print('5. Load numbers')
    print('6. Save numbers')
    print('7. Quit')
    print()


print_menu()

while True:
    menu_choice = int(input("Type in a number (1-7): "))
    if menu_choice == 1:
        print_numbers()
    elif menu_choice == 2:
        print("Add Name and Number")
        name = input("Name: ")
        phone = input("Number: ")
        add_number(name, phone)
    elif menu_choice == 3:
        print("Remove Name and Number")
        name = input("Name: ")
        remove_number(name)
    elif menu_choice == 4:
        print("Lookup Number")
        name = input("Name: ")
        print(lookup_number(name))
    elif menu_choice == 5:
        filename = input("Filename to load: ")
        PHONE_BOOK = load_numbers(filename)
    elif menu_choice == 6:
        filename = input("Filename to save: ")
        save_numbers(filename)
    elif menu_choice == 7:
        break
    else:
        print_menu()
