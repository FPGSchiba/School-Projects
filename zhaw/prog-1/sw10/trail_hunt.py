# -*- coding: utf-8 -*-
"""
PROG1 P10 9.2: Trail hunt

@date: 30.11.2023
@author: Jann Erhardt
"""
import datetime
import json
import os.path
import sys
import math
from typing import List, Tuple

import xmltodict


def parse(file_path: str) -> list[tuple[float, float, float, datetime.datetime]]:
    """
    Parses a GPX file.
    :param file_path: str, the GPX file to parse
    :return: list, a list of latitudes and longitudes
    """
    if not os.path.exists(file_path):
        raise FileNotFoundError(f'File: {file_path} was not found.')
    if not file_path.endswith('.gpx'):
        raise Exception(f'File: {file_path} is not a GPX file. Please use a GPX file.')
    with open(file_path, 'r+', encoding='utf-8') as file:
        data = xmltodict.parse(file.read(), encoding='utf-8')
    try:
        track_points = data['gpx']['trk']['trkseg']['trkpt']
    except IndexError:
        print('File could not be Parsed.')
        sys.exit(1)
    return [(float(point['@lat']), float(point['@lon']), float(point['ele']),
             datetime.datetime.fromisoformat(point['time'])) for point in track_points]


def haversine(point1: tuple[float, float], point2: tuple[float, float]) -> float:
    """
    Calculate the distance between two Points on earth
    :param point1: tuple, The first point
    :param point2: tuple, the second point
    :return: float, the distance between those points.
    """
    lat1 = point1[0]
    lat2 = point2[0]
    lon1 = point1[1]
    lon2 = point2[1]
    d_lat = (lat2 - lat1) * math.pi / 180.0
    d_lon = (lon2 - lon1) * math.pi / 180.0
    lat1 = lat1 * math.pi / 180.0
    lat2 = lat2 * math.pi / 180.0
    res = (pow(math.sin(d_lat / 2), 2) + pow(math.sin(d_lon / 2), 2) * math.cos(lat1) * math.cos(lat2))
    rad = 6371
    c = 2 * math.asin(math.sqrt(res))
    return rad * c


def calculate_traveled_distance(trail: list[tuple[float, float, float, datetime.datetime]]) -> float:
    """
    Calculates the traveled distance of a trail with the haversine method.
    :param trail: list, the trail to use
    :return: float, the distance traveled in km
    """
    return sum([haversine(trail[i - 1], trail[i]) for i in range(1, len(trail))])


def calculate_elevation_delta(trail: list[tuple[float, float, float, datetime.datetime]]) -> float:
    """
    Calculates the Delta elevation traveled for a trail
    :param trail: list, the trail to calculate the elevation delta from.
    :return: float, the delta elevation in m
    """
    return abs(sum([trail[i - 1][2] - trail[i][2] for i in range(1, len(trail))]))


def calculate_speeds(trail: list[tuple[float, float, float, datetime.datetime]]) -> list[float]:
    """
    Calculates the speeds between trail measurements for a given trail
    :param trail: list, the trail to calculate the speeds for.
    :return: list, a list of speeds for every measurement
    """
    distances = [haversine(trail[i - 1], trail[i]) for i in range(1, len(trail))]
    times = [(trail[i][3] - trail[i - 1][3]).seconds + (trail[i][3] - trail[i - 1][3]).microseconds / 1000000 for i in
             range(1, len(trail))]
    speeds = []
    for i in range(len(distances)):
        dist = distances[i] * 1000
        seconds = times[i]
        speeds.append(dist / seconds)
    return speeds


def calculate_max_speed(trail: list[tuple[float, float, float, datetime.datetime]]) -> float:
    """
    Calculates the max speed for a trail
    :param trail: list, the trail to use
    :return: float, the max speed in m/s
    """
    speeds = calculate_speeds(trail)
    return max(speeds)


def calculate_average_speed(trail: list[tuple[float, float, float, datetime.datetime]]) -> float:
    """
    Calculates the average speed for a given trail
    :param trail: list, the trail to analyse
    :return: float, the average speed in the trail in m/s
    """
    speeds = calculate_speeds(trail)
    return sum(speeds) / len(speeds)


def calculate_time(trail: list[tuple[float, float, float, datetime.datetime]]) -> float:
    """
    Calculates the complete time it took to complete the trail.
    :param trail: list, the trail to analyse
    :return: float, the time it took to traverse the trail in s
    """
    return sum(
        [(trail[i][3] - trail[i - 1][3]).seconds + (trail[i][3] - trail[i - 1][3]).microseconds / 1000000 for i in
         range(1, len(trail))])


def get_ranking_values(file: str) -> tuple[str, float, float, float, float, float]:
    """
    Gets all relevant information from a GPX file.
    :param file: the GPX File to analyse
    :return: tuple, the student name, the distance traveled [km], the elevation delta [m],
    the max speed [m/s], the average speed [m/s], the complete time [s]
    """
    trail = parse(file)
    student_name = os.path.basename(file).split('.')[0]
    distance = calculate_traveled_distance(trail)
    elevation = calculate_elevation_delta(trail)
    max_speed = calculate_max_speed(trail)
    avg_speed = calculate_average_speed(trail)
    time = calculate_time(trail)
    return student_name, distance, elevation, max_speed, avg_speed, time


if __name__ == '__main__':
    file = 'trails/erharjan.gpx'
    print(get_ranking_values(file))
