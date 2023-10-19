number_string = "18237646516298888176253123"

max_product = 0
max_group_5 = ''

for i in range(len(number_string) - 4):
    group_5 = number_string[i:i+5]

    product = 1
    for num in group_5:
        product *= int(num)

    if product > max_product:
        max_product = product
        max_group_5 = group_5

print(f'Max Group: {max_group_5}, product: {max_product}')
