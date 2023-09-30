# -*- coding: utf-8 -*-
"""
PROG1 P02 page 17-Finish: Variables and basics

@date: 30.09.2023
@author: Jann Erhardt
"""
years_of_investment = 8

base_capital = float(input('Base Capital [CHF]: '))
interest_rate = float(input('Interest Rate [%]: '))

interest_rate = 1 + interest_rate / 100
print(f'Interest Rate: {interest_rate}')

yearly_amount = base_capital * interest_rate ** years_of_investment

print(f'Starting Capital: {base_capital:.2f} CHF')
print(f'Final Amount: {yearly_amount:.2f} CHF (After {years_of_investment} years)')
