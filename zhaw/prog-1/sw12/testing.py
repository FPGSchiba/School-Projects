import datetime
import random
import randomname

from phone_book import PhoneBook

pb = PhoneBook()
names = []


def random_date():
    """
    This function will return a random datetime between two datetime
    objects.
    """
    delta = datetime.timedelta(10000)
    int_delta = (delta.days * 24 * 60 * 60) + delta.seconds
    random_second = random.randrange(int_delta)
    return datetime.datetime.now() - datetime.timedelta(seconds=random_second)


def print_found_people(people: list[str]):
    count = 1
    print('== Found People ==')
    for person in people:
        print(f'{count:02d}: {person}')


for i in range(10):
    name = randomname.get_name()
    names.append(name)
    num_numbers = random.randint(1, 5)
    for j in range(num_numbers):
        pb.add_number(name, f'{random.randint(100000000, 999999999)}')
    pb.add_person_details(name, {
        'nickname': randomname.get_name(),
        'address': randomname.get_name(),
        'birthdate': random_date().strftime('%d.%m.%y %H:%M:%S'),
        'added': datetime.datetime.now().strftime('%d.%m.%y %H:%M:%S')
    })

print(names)

