/*
 *   This file is part of the DYPS-ONE
 *
 *   Copyright (C) 2018-today:
 *       Roman Gassmann, rog@gassmann-engineering.ch
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

/** @file config.h
 *  @brief System configuration
 *
 *  This file is used to configure the system
 *
 *  @author Roman Gassmann (Gmn)
 *
 */

#ifndef CONFIG_H
#define CONFIG_H

#include "_startup/include/definitions.h"

#include "_startup/include/MK22F25612.h"
#include "_startup/include/MK22F25612_EXT.h"


#define DYPS_BOARD_V1

#ifdef DYPS_BOARD_V1
    #define CPU_TYPE MK22FN256M12
#else
    #error "B4Y_Version not defined in Config.h!"
#endif

#endif //CONFIG_H
