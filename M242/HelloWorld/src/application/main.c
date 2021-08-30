/*
 *   This file is part of the DYPS-ONE
 *
 *   Copyright (C) 2018-today:
 *       Roman Gassmann (GMN), Ing. Büro Gassmann, rog@gassmann-engineering.ch
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

#include "../system/lib/libDYPS.h"

int main(void) {
    initP0P1();
    initTouchP0P1("mp 3");

    while(1) {
        P1 = P0;
        delay_ms(10);
    }

    return 0;
}
