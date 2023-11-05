# -*- coding: utf-8 -*-
"""
PROG1 P04 1.4: Caesar Cipher

@date: 04.11.2023
@author: Jann Erhardt
"""
import re

SHIFT = 5


def encrypt(message: str):
    """
    Encrypts a string with the configured Cipher shift
    :param message: str, the message that should be encrypted
    :return: the encrypted message
    """
    encrypted = ""
    for char in message:
        if char.isupper():  # check if it's an uppercase character
            c_index = ord(char) - ord('A')
            # shift the current character by key positions
            c_shifted = (c_index + SHIFT) % 26 + ord('A')
            c_new = chr(c_shifted)
            encrypted += c_new
        elif char.islower():  # check if its a lowecase character
            # subtract the unicode of 'a' to get index in [0-25) range
            c_index = ord(char) - ord('a')
            c_shifted = (c_index + SHIFT) % 26 + ord('a')
            c_new = chr(c_shifted)
            encrypted += c_new
        else:
            # if its neither alphabetical nor a number, just leave it like that
            encrypted += char
    return encrypted


def decrypt(message: str):
    """
    Decrypts a string with the configured Cipher shift
    :param message:str, message to be decrypted
    :return: the decrypted message
    """
    encrypted = ""
    for char in message:
        if char.isupper():  # check if it's an uppercase character
            c_index = ord(char) - ord('A')
            # shift the current character by key positions
            c_shifted = (c_index - SHIFT) % 26 + ord('A')
            c_new = chr(c_shifted)
            encrypted += c_new
        elif char.islower():  # check if its a lowecase character
            # subtract the unicode of 'a' to get index in [0-25) range
            c_index = ord(char) - ord('a')
            c_shifted = (c_index - SHIFT) % 26 + ord('a')
            c_new = chr(c_shifted)
            encrypted += c_new
        else:
            # if its neither alphabetical nor a number, just leave it like that
            encrypted += char
    return encrypted

print(encrypt('''
this python script shall pass my test with flying colors and not fail.
If this fails it was not very intended and I am sorry my friend, but this is wrong.
If you see this is is not wrong. So we will have faith in you and pray to the gods.
I will also be very interested to see if it can pass your Python senses, or if it will fail.
As I said before we will hope for the best and not tolarate any error to get as many points as we can.
'''))