def check(card_number : str) -> bool:
    sum = 0
    splited_numb = card_number.split(" ")
    print(splited_numb)
    if len(splited_numb) == 4:
        card_numb = str(splited_numb[0] + splited_numb[1] + splited_numb[2] + splited_numb[3])
        if card_numb.isdigit():
            print(card_numb)
            for numb in card_numb:
                sum = sum + int(numb)
                print(numb)
            if sum % 10 == 0:
                return True
            else:
                return False
        else:
            return False
    else:
     return False

