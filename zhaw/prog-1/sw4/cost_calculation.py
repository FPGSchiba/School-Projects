# -*- coding: utf-8 -*-
"""
PROG1 P04 2.2: Cost Calculation

@date: 14.10.2023
@author: Jann Erhardt
"""
import sys

# Input-Types
MACHINE_TYPES = ['machine_a', 'machine_b']

# Costs
MATERIAL_A1_COST = 335  # Per Unit Price
MATERIAL_A2_COST = 1520  # Per Unit Price
MATERIAL_B1_COST = 865  # Per Unit Price
SPECIALIST_A_HOURLY_COST = 150  # Hourly Price
SPECIALIST_B_HOURLY_COST = 175  # Hourly Price
PROJECT_MANAGER_HOURLY_COST = 200
MACHINE_A_COST = 25000
MACHINE_B_COST = 40000

# Needs
MACHINE_A_MA1 = 47  # Number of units of material_a1 needed by machine_a
MACHINE_A_MA2 = 119  # Number of units of material_a2 needed by machine_a
MACHINE_B_B1 = 159  # Number of units of material_b1 needed by machine_b
PROJECT_MANAGER_HOURS_PER_MONTH = 42

# Input
budget = float(input('How much budget is there [number]: '))
time_frame = int(input('How long will your Project run in months [number]: '))
machine_to_use = input('Which machine are you going to use (machine_a or machine_b)? ')

if machine_to_use not in MACHINE_TYPES:
    print(f'Machine type not found: {machine_to_use}')
    sys.exit(1)

# PM Costs
pm_costs = time_frame * PROJECT_MANAGER_HOURS_PER_MONTH * PROJECT_MANAGER_HOURLY_COST

# Machine Budget Checks
machine_cost = 0
material_cost = 0

# Machine A
if machine_to_use == MACHINE_TYPES[0]:
    machine_cost = MACHINE_A_COST
    material_cost = MACHINE_A_MA1 * MATERIAL_A1_COST + MACHINE_A_MA2 * MATERIAL_A2_COST

# Machine B
if machine_to_use == MACHINE_TYPES[1]:
    machine_cost = MACHINE_B_COST
    material_cost = MACHINE_B_B1 * MATERIAL_B1_COST

# Error
if machine_cost == 0 or material_cost == 0:
    print('Some error happened, please try again...')
    sys.exit(1)

if (machine_cost + material_cost) * 100 / budget > 25:
    print(f'Machine & Material Costs are too high for budget: {(machine_cost + material_cost) * 100 / budget:.2f}%')
    sys.exit(1)

specialist_budget = budget - (pm_costs + machine_cost + material_cost)

specialist_hours_per_month = 0

# Machine A
if machine_to_use == MACHINE_TYPES[0]:
    specialist_hours_per_month = specialist_budget / time_frame / SPECIALIST_A_HOURLY_COST

# Machine B
if machine_to_use == MACHINE_TYPES[1]:
    specialist_hours_per_month = specialist_budget / time_frame / SPECIALIST_B_HOURLY_COST

# Error
if specialist_hours_per_month == 0:
    print('Some error happened, please try again...')
    sys.exit(1)

# Project Manager Budget Checks with total Labour
pm_costs_percent = pm_costs * 100 / (specialist_budget + pm_costs)

if pm_costs_percent > 12:
    print(f'Project Manager costs too much: {pm_costs_percent:.2f}%')
    sys.exit(1)

if pm_costs_percent < 8:
    print(f'Project Manager uses to little budget: {pm_costs_percent:.2f}%')

print(f'Specialist Hours Per Month: {specialist_hours_per_month:.2f} hours')
