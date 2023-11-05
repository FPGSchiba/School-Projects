# -*- coding: utf-8 -*-
"""
PROG1 P04 G4: Caesar Cipher Crack

@date: 04.11.2023
@author: Jann Erhardt
"""
import re

SHIFT_RANGE = range(-10, 11)


def decrypt(message: str, key: int):
    """
    Decrypts a string with the configured Cipher shift
    :param message: str, message to be decrypted
    :param key: int, The caesar shift to use to decrypt the string
    :return: the decrypted message
    """
    encrypted = ""
    for char in message:
        if char.isupper():  # check if it's an uppercase character
            c_index = ord(char) - ord('A')
            # shift the current character by key positions
            c_shifted = (c_index - key) % 26 + ord('A')
            c_new = chr(c_shifted)
            encrypted += c_new
        elif char.islower():  # check if its a lowecase character
            # subtract the unicode of 'a' to get index in [0-25) range
            c_index = ord(char) - ord('a')
            c_shifted = (c_index - key) % 26 + ord('a')
            c_new = chr(c_shifted)
            encrypted += c_new
        else:
            encrypted += char
    return encrypted


def crack_message(message: str):
    """
    Cracks the Key and message to a given caesar ciphered message.
    :param message: str, The encrypted message, that should be cracked.
    :return:
    1. int, The Shift used as the key
    2. str, The decrypted message
    """
    for key in SHIFT_RANGE:
        decrypted = decrypt(message, key)
        python_pattern = r'python'
        if re.search(python_pattern, decrypted, re.IGNORECASE):
            return key, decrypted


print(crack_message("""
mabl bl t fxlltzx ykhf ztbnl bnebnl vtxltk. by rhn uxebxox pbdbixwbt, b ptl t khftg zxgxkte tgw lmtmxlftg. t fxfuxk hy max ybklm mkbnfobktmx, b exw max khftg tkfbxl bg max zteebv ptkl uxyhkx wxyxtmbgz fr ihebmbvte kbote ihfixr bg t vbobe ptk, tgw lnulxjnxgmer uxvtfx wbvmtmhk ykhf 49 uv ngmbe fr tlltllbgtmbhg bg 44 uv. b ietrxw t vkbmbvte khex bg max xoxgml matm exw mh max wxfblx hy max khftg kxinuebv tgw max kblx hy max khftg xfibkx. b gxoxk nlxw irmahg.
"""))
