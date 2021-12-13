/*
 *   This file is part of the DYPS-ONE
 *
 *   Copyright (C) 2018-today:
 *       GASSMANN TECHNOLOGIES AG, Roman Gassmann, roman.gassmann@gate-ag.ch
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program.  If not, see http://www.gnu.org/licenses/gpl-3.0
 *
 */

#ifndef DEFINTIONS_H
#define DEFINTIONS_H

#define MAX(x, y) (((x) > (y)) ? (x) : (y))
#define MIN(x, y) (((x) < (y)) ? (x) : (y))

typedef enum {true = -1, false = 0} bool;

typedef unsigned char       uint8_t;
typedef unsigned short      uint16_t;
typedef unsigned long       uint32_t;
typedef unsigned long long  uint64_t;

typedef signed char         int8_t;
typedef signed short        int16_t;
typedef signed long         int32_t;
typedef signed long long    int64_t;

#endif //DEFINTIONS_H
