# -*- coding: utf-8 -*-
"""
PROG1 P04 1.4: Caesar Cipher

@date: 04.11.2023
@author: Jann Erhardt
"""
import re

SHIFT = -2


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
Once upon a time in the whimsical world of programming, a group of quirky snakes decided to host a comedy night in the enchanted forest of algorithms. The headlining act was a Python named Monty, renowned for his slippery sense of humor and knack for debugging life's absurdities.
As Monty slithered onto the stage, the crowd of algorithms and data structures hissed with anticipation. "Why did the Python cross the road?" Monty hissed, his audience hanging on every byte. "To slither into the other byte!"
The forest echoed with laughter, a chorus of "hiss-terical" amusement. Monty continued, weaving tales of mischievous bugs and clever tricks, each punchline punctuated by a sibilant punch from the audience. "You know you're a Python programmer when your code is more organized than your sock drawer!"
The laughter cascaded through the trees like a joyful syntax error. Even the wise old compiler chuckled, emitting a low hum of approval. In this magical realm where the language of laughter transcended syntax, Python ruled as the supreme jester, proving that in the kingdom of code, a bit of humor is the most powerful debug spell of all.
'''))