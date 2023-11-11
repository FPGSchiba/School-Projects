# -*- coding: utf-8 -*-
"""
PROG1 P04: Comments Gender detection

@date: 11.11.2023
@author: Jann Erhardt
"""
import re

def count_singular_pronouns(text: str) -> int:
    singular_pronouns = ["I", "me", "my"]
    pronoun_count = 0
    for pronoun in singular_pronouns:
        pattern = r'\s?' + pronoun + r'(\s|\.)'
        pronoun_count += len(re.findall(pattern, text, flags=re.IGNORECASE))
    return pronoun_count


def document_length(text: str) -> int:
    return len(text.split())


def words_per_sentence(text: str) -> int:
    sentences = re.split(r'[!?.]', text, flags=re.IGNORECASE)
    sentences = [sentence.strip() for sentence in sentences if sentence != '']
    return round(document_length(text) / len(sentences))
