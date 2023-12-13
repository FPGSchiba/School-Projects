# -*- coding: utf-8 -*-
"""
PROG1 P07 3: Phone Book

@date: 09.12.2023
@author: Jann Erhardt
"""
import datetime
import json
import os.path
from uuid import uuid4
import re
from difflib import SequenceMatcher


def get_id() -> str:
    """

    :return:
    """
    return str(uuid4())


def is_number(number: str) -> bool:
    """

    :param number:
    :return:
    """
    number = number.strip()
    return re.match(r'^(\d{9,10}|\+\d{11}|\+\d{2}\s\d{2}\s\d{3}\s\d{4}|\d{3}\s\d{3}\s\d{4})$', number) is not None


class PhoneBook:
    """
    This PhoneBook is made to store Data related to Phone Numbers and People owning those numbers.
    """

    def __init__(self):
        """

        """
        self.data = {}
        self.similarity_threshold = 0.45

    def is_similar(self, string_1: str, string_2: str):
        """

        :param string_1:
        :param string_2:
        :return:
        """
        similarity = SequenceMatcher(None, string_1, string_2).ratio()
        return similarity >= self.similarity_threshold

    def get_all_numbers(self) -> list[tuple[str, str]]:
        """

        :return:
        """
        result = []
        for item in self.data.items():
            person = item[1]
            for number in person['numbers']:
                result.append((person['name'], number))
        return result

    def get_person_id(self, person: str) -> str | None:
        """

        :param person:
        :return:
        """
        if self.does_person_exist(person):
            for item in self.data.items():
                person_item = item[1]
                if person_item['name'] == person:
                    return item[0]
        else:
            print('Person does not Exist and ID was searched.')
            return None

    def add_number(self, person: str, number: str):
        """

        :param person:
        :param number:
        :return:
        """
        if self.does_person_exist(person):
            person_id = self.get_person_id(person)
            if is_number(number):
                self.data[person_id]['numbers'].append(number)
            else:
                print(f'Number: {number} is not in the right format!')
        else:
            self.create_person(person)
            self.add_number(person, number)  # Person now exists, so can be recursive.

    def lookup_numbers(self, person) -> list[str]:
        """

        :param person:
        :return:
        """
        result = []
        if self.does_person_exist(person):
            person_id = self.get_person_id(person)
            result = self.data[person_id]['numbers']
        return result

    def remove_number(self, person: str, number: str):
        """

        :param person:
        :param number:
        :return:
        """
        if self.does_person_exist(person):
            person_id = self.get_person_id(person)
            numbers = self.data[person_id]['numbers']
            if number in numbers:
                numbers.remove(number)
                self.data[person_id]['numbers'] = numbers
            else:
                print(f'The Person: {self.data[person_id]["name"]} does not have a number: {number}!')

    def remove_all_numbers(self, person: str):
        """

        :param person:
        :return:
        """
        if self.does_person_exist(person):
            person_id = self.get_person_id(person)
            self.data[person_id]['numbers'] = []

    def remove_number_by_id(self, person: str, index: int):
        """

        :param person:
        :param index:
        :return:
        """
        if self.does_person_exist(person):
            person_id = self.get_person_id(person)
            numbers = self.data[person_id]['numbers']
            if len(numbers) > index > -1:
                numbers.pop(index)
                self.data[person_id]['numbers'] = numbers
            else:
                print(f'The Person: {self.data[person_id]["name"]} does not have a number with ID: {index}!')

    def load(self, file_path='./data.json'):
        """

        :param file_path:
        :return:
        """
        if os.path.isfile(file_path):
            with open(file_path, 'r+', encoding='utf-8') as file:
                self.data = json.load(file)
        else:
            print(f'The file: {file_path} to load from, does not exist.')

    def save(self, file_path='./data.json'):
        """

        :param file_path:
        :return:
        """
        if os.path.isfile(file_path):
            print('File will be Overwritten!')
        with open(file_path, 'w+', encoding='utf-8') as file:
            json.dump(self.data, file)

    def find_person(self, name: str) -> list[str]:
        """

        :param name:
        :return:
        """
        result = []
        for item in self.data.items():
            person = item[1]
            person_name = person['name']
            if self.is_similar(name, person_name):
                result.append(person_name)
            elif person_name.startswith(name):
                result.append(person_name)
        return result

    def does_person_exist(self, name: str) -> bool:
        """

        :param name:
        :return:
        """
        for item in self.data.items():
            person = item[1]
            person_name = person['name']
            if person_name == name:
                return True
        return False

    def add_person_details(self, person: str, details: dict):
        """

        :param person:
        :param details:
        :return:
        """
        if self.does_person_exist(person):
            person_id = self.get_person_id(person)
            self.data[person_id]['details'] = details

    def remove_person_details(self, person: str):
        """

        :param person:
        :return:
        """
        if self.does_person_exist(person):
            person_id = self.get_person_id(person)
            if 'details' in self.data[person_id].keys():
                del self.data[person_id]['details']
            else:
                print(f'The Person: {person} does not have details!')

    def create_person(self, person: str):
        """

        :param person:
        :return:
        """
        person_id = get_id()
        self.data[person_id] = {
            'name': person,
            'numbers': []
        }

    def get_person(self, person: str) -> dict:
        """

        :param person:
        :return:
        """
        result = {}
        if self.does_person_exist(person):
            person_id = self.get_person_id(person)
            result = self.data[person_id].copy()
        else:
            print('Person does not exist!')
        return result


def print_numbers(numbers: list[tuple[str, str]]):
    """

    :param numbers:
    :return:
    """
    old_name = ''
    number_count = 1
    for item in numbers:
        name = item[0]
        number = item[1]
        if old_name != name:
            number_count = 1
            print(f'{name}:')
            print(f'  {number_count:02d}: {number}')
            old_name = name
        else:
            print(f'  {number_count:02d}: {number}')
            number_count += 1


def print_numbers_for_person(numbers: list[str], name: str):
    """

    :param numbers:
    :param name:
    :return:
    """
    print(f'{name}: ')
    number_count = 1
    for number in numbers:
        print(f'  {number_count:02d}: {number}')
        number_count += 1


def print_found_people(people: list[str]):
    count = 1
    print('== Found People ==')
    for person in people:
        print(f'{count:02d}: {person}')


def print_person(person: dict):
    print(f'== {person["name"]} ==')
    print(' = Numbers =')
    number_count = 1
    for number in person['numbers']:
        print(f'  {number_count:02d}: {number}')
        number_count += 1
    if 'details' in person.keys():
        details = person["details"]
        print(' = Details =')
        print(f'  Details Added: {details["added"]}')
        print(f'  Birthdate    : {details["birthdate"]}')
        print(f'  Address      : {details["address"]}')
        print(f'  Nickname     : {details["nickname"]}')


def print_menu():
    """
    Prints the menu of the Application
    :return: None
    """
    print('=== PHONE BOOK ===')
    print('1. Print Phone Numbers')
    print('2. Add a Phone Number')
    print('3. Remove a Phone Number')
    print('4. Remove all Numbers from a Person')
    print("5. Lookup a Person's Numbers")
    print('6. Find a Person')
    print('7. Add details to a Person')
    print('8. Remove all Details from a Person')
    print('9. Print a Person')
    print('10. Load Phone Book')
    print('11. Save Phone Book')
    print('100. Quit')
    print()


if __name__ == '__main__':
    print_menu()
    phone_book = PhoneBook()

    while True:
        menu_choice = int(input("Type in a number (1-11|100): "))
        if menu_choice == 1:
            numbers = phone_book.get_all_numbers()
            print_numbers(numbers)
        elif menu_choice == 2:
            print("Add Name and Number")
            name = input("Name: ")
            phone = input("Number: ")
            phone_book.add_number(name, phone)
        elif menu_choice == 3:
            print("Remove Name and Number")
            name = input("Name: ")
            number = input("Number: ")
            phone_book.remove_number(name, number)
        elif menu_choice == 4:
            print("Remove all Numbers from Person")
            name = input("Name: ")
            phone_book.remove_all_numbers(name)
        elif menu_choice == 5:
            print("Lookup Number")
            name = input("Name: ")
            numbers = phone_book.lookup_numbers(name)
            print_numbers_for_person(numbers, name)
        elif menu_choice == 6:
            print('Find People')
            name = input('Search: ')
            people = phone_book.find_person(name)
            print_found_people(people)
        elif menu_choice == 7:
            print('Add Details')
            name = input('Name: ')
            address = input('Address: ')
            birthdate = input('Birthdate: ')
            nickname = input('Nickname: ')
            details = {
                'address': address,
                'birthdate': birthdate,
                'nickname': nickname,
                'added': datetime.datetime.now().strftime('%d.%m.%y %H:%M:%S')
            }
            phone_book.add_person_details(name, details)
        elif menu_choice == 8:
            print('Remove Details')
            name = input("Name: ")
            phone_book.remove_person_details(name)
        elif menu_choice == 9:
            print('Show Person')
            name = input('Name: ')
            person = phone_book.get_person(name)
            print_person(person)
        elif menu_choice == 10:
            filename = input("Filename to load: ")
            phone_book.load(filename)
        elif menu_choice == 11:
            filename = input("Filename to save: ")
            phone_book.save(filename)
        elif menu_choice == 100:
            break
        else:
            print_menu()
