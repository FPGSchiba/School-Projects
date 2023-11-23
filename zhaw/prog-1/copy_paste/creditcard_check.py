def check(card_number: str) -> bool:
    """
    Checks if a credit card number is valid.
    :param card_number: str, The Credit Card number to check.
    :return: bool, if the credit card number is valid.
    """
    split_numb = card_number.split(" ")
    if len(split_numb) == 4:
        card_numb = str(split_numb[0] + split_numb[1] + split_numb[2] + split_numb[3])
        if card_numb.isdigit():
            card_sum = 0
            for numb in card_numb:
                card_sum = card_sum + int(numb)
                print(numb)
            return card_sum % 10 == 0
        return False
    return False
