# -*- coding: utf-8 -*-
"""
PROG1 P10 9.2: Trail Hunt Ranking

@date: 30.11.2023
@author: Jann Erhardt
"""
import glob
import math

from trail_hunt import get_ranking_values

FILES = glob.glob('./trails/*.gpx')
RANKING_FILE = 'ranking.txt'

RANKINGS = ['distance', 'elevation', 'speed-max', 'speed-avg', 'time']
RANKING_META = {
    'heading': {
        'distance': ' DISTANCE ',
        'elevation': ' ELEVATION ',
        'speed-max': ' MAX SPEED ',
        'speed-avg': ' AVG SPEED ',
        'time': ' TIME '
    },
    'einheit': {
        'distance': 'km',
        'elevation': 'm',
        'speed-max': 'm/s',
        'speed-avg': 'm/s'
    }
}


def zpad(val, n):
    bits = val.split('.')
    return "%s.%s" % (bits[0].zfill(n), bits[1])


def get_ranking_for_variable(values: dict[str, dict], variable: str) -> list[str]:
    """

    :param values:
    :return:
    """
    variable_values = [values[key][variable] for key in values.keys()]
    students = list(values.keys())
    old_variable_values = variable_values.copy()
    variable_values.sort(reverse=True)
    result = []
    for dist in variable_values:
        result.append(students[old_variable_values.index(dist)])
    return result


def get_time_string(seconds: float) -> str:
    """

    :param seconds:
    :return:
    """
    if seconds >= 60**2:
        hours_full = seconds / 60**2
        hours = math.floor(hours_full)
        minutes = hours_full - hours
        minutes *= 60
        seconds = minutes
        minutes = math.floor(minutes)
        seconds = seconds - minutes
        seconds *= 60
        hours = f'{hours:.2f}'
        minutes = f'{minutes:.2f}'
        seconds = f'{seconds:.2f}'
        return f'{zpad(hours, 2)}h {zpad(minutes, 2)}m {zpad(seconds, 2)}s'
    elif seconds >= 60:
        minutes_full = seconds / 60
        minutes = math.floor(minutes_full)
        seconds = minutes_full - minutes
        seconds *= 60
        minutes = f'{minutes:.2f}'
        seconds = f'{seconds:.2f}'
        return f'       {zpad(minutes, 2)}m {zpad(seconds, 2)}s'
    else:
        return f'{seconds}s'


def generate_rankings():
    values = {}
    for file in FILES:
        value = get_ranking_values(file)
        values[value[0]] = {
            'distance': value[1],
            'elevation': value[2],
            'speed-max': value[3],
            'speed-avg': value[4],
            'time': value[5]
        }
    with open(RANKING_FILE, 'w+', encoding='utf-8') as rank_file:
        rank_file.write('=' * 20 + ' RANKINGS ' + '=' * 20 + '\n')
    for current_var in RANKINGS:
        current_ranking = get_ranking_for_variable(values, current_var)
        with open(RANKING_FILE, 'a', encoding='utf-8') as rank_file:
            rank_file.write('=' * 10 + RANKING_META["heading"][current_var] + '=' * 10 + '\n')
            if current_var != 'time':
                for index, student in enumerate(current_ranking):
                    rank_file.write(f'{index + 1}. {student}: {values[student][current_var]:.2f} {RANKING_META["einheit"][current_var]}' + '\n')
            else:
                for index, student in enumerate(current_ranking):
                    rank_file.write(f'{index + 1}. {student}: {get_time_string(values[student]["time"])}' + '\n')


if __name__ == '__main__':
    generate_rankings()
