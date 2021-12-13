/*
 *   This file is part of the DYPS-Project
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

/**< @file libDYPS.h
 *  @brief Headerfile for DYPS-Library
 *
 *  This file includes all the necessary library functions for the DYPS-Board
 *  Small code parts have been used from the touchP0P1 lib written by Robert Weber (rw)
 *  and Rico Malacarne (rma)
 *
 *  WARNING - DO NOT CHANGE THIS FILE IF YOU DONT KNOW WHAT YOU ARE DOING!!!
 *
 *  @author Roman Gassmann (Gmn)
 *
 */

#ifndef LIBDYPS_H
#define LIBDYPS_H

#include "../config.h"

// GPIO Definitions --------------------------------------------

    #define MEMMAP_BB_GPIO_ADDR         0x43FE0000  /* Bit Band Alias Region */
    #define MEMMAP_GPIO_BASE_ADDR       0x400FF000

    #define BIT_2_BB2_ADDR(regAddr, bitNum) (MEMMAP_BB_GPIO_ADDR + (((regAddr)-MEMMAP_GPIO_BASE_ADDR)*32) + ((bitNum)*4))

    #define I_BIT(regAddr, bitNum)  (*((__I  uint32_t*)(BIT_2_BB2_ADDR(regAddr, bitNum))))
    #define O_BIT(regAddr, bitNum)  (*((__O  uint32_t*)(BIT_2_BB2_ADDR(regAddr, bitNum))))
    #define BIT(regAddr, bitNum)    (*((__IO uint32_t*)(BIT_2_BB2_ADDR(regAddr, bitNum))))

    #define OFFSET_PDOR 0x00
    #define OFFSET_PSOR 0x04
    #define OFFSET_PCOR 0x08
    #define OFFSET_PTOR 0x0C
    #define OFFSET_PDIR 0x10
    #define OFFSET_PDDR 0x14

    /*-----------------------SWITCHES - P0-------------------------------*/

    #define P0LCD           (*((__IO uint8_t*)(PTC_BASE + OFFSET_PDOR + 1)))
    #define P0              ((*((__I  uint8_t*)(PTC_BASE + OFFSET_PDIR + 1))) | P0LCD)

    #define P0_0_MASK       0x01
    #define P0_1_MASK       0x02
    #define P0_2_MASK       0x04
    #define P0_3_MASK       0x08
    #define P0_4_MASK       0x10
    #define P0_5_MASK       0x20
    #define P0_6_MASK       0x40
    #define P0_7_MASK       0x80

    #define P0_0            (I_BIT( (PTC_BASE + OFFSET_PDIR) ,  8 ) | I_BIT( (PTC_BASE + OFFSET_PDOR) ,  8 ))
    #define P0_1            (I_BIT( (PTC_BASE + OFFSET_PDIR) ,  9 ) | I_BIT( (PTC_BASE + OFFSET_PDOR) ,  9 ))
    #define P0_2            (I_BIT( (PTC_BASE + OFFSET_PDIR) , 10 ) | I_BIT( (PTC_BASE + OFFSET_PDOR) , 10 ))
    #define P0_3            (I_BIT( (PTC_BASE + OFFSET_PDIR) , 11 ) | I_BIT( (PTC_BASE + OFFSET_PDOR) , 11 ))
    #define P0_4            (I_BIT( (PTC_BASE + OFFSET_PDIR) , 12 ) | I_BIT( (PTC_BASE + OFFSET_PDOR) , 12 ))
    #define P0_5            (I_BIT( (PTC_BASE + OFFSET_PDIR) , 13 ) | I_BIT( (PTC_BASE + OFFSET_PDOR) , 13 ))
    #define P0_6            (I_BIT( (PTC_BASE + OFFSET_PDIR) , 14 ) | I_BIT( (PTC_BASE + OFFSET_PDOR) , 14 ))
    #define P0_7            (I_BIT( (PTC_BASE + OFFSET_PDIR) , 15 ) | I_BIT( (PTC_BASE + OFFSET_PDOR) , 15 ))

    #define P0_0_PIN        GPIO(PIN_C8)
    #define P0_1_PIN        GPIO(PIN_C9)
    #define P0_2_PIN        GPIO(PIN_C10)
    #define P0_3_PIN        GPIO(PIN_C11)
    #define P0_4_PIN        GPIO(PIN_C12)
    #define P0_5_PIN        GPIO(PIN_C13)
    #define P0_6_PIN        GPIO(PIN_C14)
    #define P0_7_PIN        GPIO(PIN_C15)

    /*-----------------------LEDS - P1-------------------------------*/
    #define P1              (*((__IO uint8_t*)(PTB_BASE + OFFSET_PDOR + 2)))

    #define P1_0_MASK       0x01
    #define P1_1_MASK       0x02
    #define P1_2_MASK       0x04
    #define P1_3_MASK       0x08
    #define P1_4_MASK       0x10
    #define P1_5_MASK       0x20
    #define P1_6_MASK       0x40
    #define P1_7_MASK       0x80

    #define P1_0_TOGGLE     O_BIT((PTB_BASE + OFFSET_PTOR), 16) = 1
    #define P1_1_TOGGLE     O_BIT((PTB_BASE + OFFSET_PTOR), 17) = 1
    #define P1_2_TOGGLE     O_BIT((PTB_BASE + OFFSET_PTOR), 18) = 1
    #define P1_3_TOGGLE     O_BIT((PTB_BASE + OFFSET_PTOR), 19) = 1
    #define P1_4_TOGGLE     O_BIT((PTB_BASE + OFFSET_PTOR), 20) = 1
    #define P1_5_TOGGLE     O_BIT((PTB_BASE + OFFSET_PTOR), 21) = 1
    #define P1_6_TOGGLE     O_BIT((PTB_BASE + OFFSET_PTOR), 22) = 1
    #define P1_7_TOGGLE     O_BIT((PTB_BASE + OFFSET_PTOR), 23) = 1

    #define P1_0            BIT( (PTB_BASE + OFFSET_PDOR) ,  16 )
    #define P1_1            BIT( (PTB_BASE + OFFSET_PDOR) ,  17 )
    #define P1_2            BIT( (PTB_BASE + OFFSET_PDOR) ,  18 )
    #define P1_3            BIT( (PTB_BASE + OFFSET_PDOR) ,  19 )
    #define P1_4            BIT( (PTB_BASE + OFFSET_PDOR) ,  20 )
    #define P1_5            BIT( (PTB_BASE + OFFSET_PDOR) ,  21 )
    #define P1_6            BIT( (PTB_BASE + OFFSET_PDOR) ,  22 )
    #define P1_7            BIT( (PTB_BASE + OFFSET_PDOR) ,  23 )

    #define P1_0_PIN        GPIO(PIN_B16)
    #define P1_1_PIN        GPIO(PIN_B17)
    #define P1_2_PIN        GPIO(PIN_B18)
    #define P1_3_PIN        GPIO(PIN_B19)
    #define P1_4_PIN        GPIO(PIN_B20)
    #define P1_5_PIN        GPIO(PIN_B21)
    #define P1_6_PIN        GPIO(PIN_B22)
    #define P1_7_PIN        GPIO(PIN_B23)

    /*-----------------------P3-------------------------------*/

    #define P3IN            (*((__I  uint8_t*)(PTC_BASE + OFFSET_PDIR + 0)))
    #define P3OUT           (*((__IO uint8_t*)(PTC_BASE + OFFSET_PDOR + 0)))
    #define P3DIR           (*((__IO uint8_t*)(PTC_BASE + OFFSET_PDDR + 0)))
    #define P3TOG           (*((__O  uint8_t*)(PTC_BASE + OFFSET_PTOR + 0)))
    #define P3SET           (*((__O  uint8_t*)(PTC_BASE + OFFSET_PSOR + 0)))
    #define P3CLR           (*((__O  uint8_t*)(PTC_BASE + OFFSET_PCOR + 0)))

    #define P3_0_OUT        BIT( (PTC_BASE + OFFSET_PDOR) ,  0 )
    #define P3_1_OUT        BIT( (PTC_BASE + OFFSET_PDOR) ,  1 )
    #define P3_2_OUT        BIT( (PTC_BASE + OFFSET_PDOR) ,  2 )
    #define P3_3_OUT        BIT( (PTC_BASE + OFFSET_PDOR) ,  3 )
    #define P3_4_OUT        BIT( (PTC_BASE + OFFSET_PDOR) ,  4 )
    #define P3_5_OUT        BIT( (PTC_BASE + OFFSET_PDOR) ,  5 )
    #define P3_6_OUT        BIT( (PTC_BASE + OFFSET_PDOR) ,  6 )
    #define P3_7_OUT        BIT( (PTC_BASE + OFFSET_PDOR) ,  7 )

    #define P3_0_IN         (I_BIT( (PTC_BASE + OFFSET_PDIR) ,  0 ))
    #define P3_1_IN         (I_BIT( (PTC_BASE + OFFSET_PDIR) ,  1 ))
    #define P3_2_IN         (I_BIT( (PTC_BASE + OFFSET_PDIR) ,  2 ))
    #define P3_3_IN         (I_BIT( (PTC_BASE + OFFSET_PDIR) ,  3 ))
    #define P3_4_IN         (I_BIT( (PTC_BASE + OFFSET_PDIR) ,  4 ))
    #define P3_5_IN         (I_BIT( (PTC_BASE + OFFSET_PDIR) ,  5 ))
    #define P3_6_IN         (I_BIT( (PTC_BASE + OFFSET_PDIR) ,  6 ))
    #define P3_7_IN         (I_BIT( (PTC_BASE + OFFSET_PDIR) ,  7 ))

    #define P3_0_PIN        GPIO(PIN_C0)
    #define P3_1_PIN        GPIO(PIN_C1)
    #define P3_2_PIN        GPIO(PIN_C2)
    #define P3_3_PIN        GPIO(PIN_C3)
    #define P3_4_PIN        GPIO(PIN_C4)
    #define P3_5_PIN        GPIO(PIN_C5)
    #define P3_6_PIN        GPIO(PIN_C6)
    #define P3_7_PIN        GPIO(PIN_C7)

    /*-----------------------P4-------------------------------*/

    #define P4IN            (*((__I  uint8_t*)(PTD_BASE + OFFSET_PDIR + 0)))
    #define P4OUT           (*((__IO uint8_t*)(PTD_BASE + OFFSET_PDOR + 0)))
    #define P4DIR           (*((__IO uint8_t*)(PTD_BASE + OFFSET_PDDR + 0)))
    #define P4TOG           (*((__O  uint8_t*)(PTD_BASE + OFFSET_PTOR + 0)))
    #define P4SET           (*((__O  uint8_t*)(PTD_BASE + OFFSET_PSOR + 0)))
    #define P4CLR           (*((__O  uint8_t*)(PTD_BASE + OFFSET_PCOR + 0)))

    #define P4_0_OUT        BIT( (PTD_BASE + OFFSET_PDOR) ,  0 )
    #define P4_1_OUT        BIT( (PTD_BASE + OFFSET_PDOR) ,  1 )
    #define P4_2_OUT        BIT( (PTD_BASE + OFFSET_PDOR) ,  2 )
    #define P4_3_OUT        BIT( (PTD_BASE + OFFSET_PDOR) ,  3 )
    #define P4_4_OUT        BIT( (PTD_BASE + OFFSET_PDOR) ,  4 )
    #define P4_5_OUT        BIT( (PTD_BASE + OFFSET_PDOR) ,  5 )
    #define P4_6_OUT        BIT( (PTD_BASE + OFFSET_PDOR) ,  6 )
    #define P4_7_OUT        BIT( (PTD_BASE + OFFSET_PDOR) ,  7 )

    #define P4_0_IN         (I_BIT( (PTD_BASE + OFFSET_PDIR) ,  0 ))
    #define P4_1_IN         (I_BIT( (PTD_BASE + OFFSET_PDIR) ,  1 ))
    #define P4_2_IN         (I_BIT( (PTD_BASE + OFFSET_PDIR) ,  2 ))
    #define P4_3_IN         (I_BIT( (PTD_BASE + OFFSET_PDIR) ,  3 ))
    #define P4_4_IN         (I_BIT( (PTD_BASE + OFFSET_PDIR) ,  4 ))
    #define P4_5_IN         (I_BIT( (PTD_BASE + OFFSET_PDIR) ,  5 ))
    #define P4_6_IN         (I_BIT( (PTD_BASE + OFFSET_PDIR) ,  6 ))
    #define P4_7_IN         (I_BIT( (PTD_BASE + OFFSET_PDIR) ,  7 ))

    #define P4_0_PIN        GPIO(PIN_D0)
    #define P4_1_PIN        GPIO(PIN_D1)
    #define P4_2_PIN        GPIO(PIN_D2)
    #define P4_3_PIN        GPIO(PIN_D3)
    #define P4_4_PIN        GPIO(PIN_D4)
    #define P4_5_PIN        GPIO(PIN_D5)
    #define P4_6_PIN        GPIO(PIN_D6)
    #define P4_7_PIN        GPIO(PIN_D7)


/** Color-scheme: RRRR'RGGG'GGGB'BBBB */
    #define COLOR_BLACK           	0x0000
    #define COLOR_WHITE           	0xFFFF

    #define COLOR_RED             	0x8000
    #define COLOR_RED_BRIGHT      	0xF800

    #define COLOR_GREEN           	0x0400
    #define COLOR_GREEN_BRIGHT    	0x07E0
    #define COLOR_GREEN_DARK       	0x1C03
    #define COLOR_BLUE            	0x0010
    #define COLOR_BLUE_BRIGHT     	0x001F

    #define COLOR_YELLOW          	0xFFE0
    #define COLOR_YELLOW_BRIGHT   	0xFFE0
    #define COLOR_YELLOW_DARK  		0x8403
    #define COLOR_CYAN            	0x0410
    #define COLOR_CYAN_BRIGHT     	0x07FF
    #define COLOR_CYAN_DARK     	0x03EF

    #define COLOR_MAGENTA         	0x8010
    #define COLOR_MAGENTA_BRIGHT  	0xF81F

    #define COLOR_BROWN           	0xFC00
    #define COLOR_NAVY           	0x000F
    #define COLOR_OLIVE	        	0x8400
    #define COLOR_ORANGE        	0xFD20
    #define COLOR_GREENYELLOW      	0xAFE5

    #define COLOR_GRAY0       	    0xE71C
    #define COLOR_GRAY1        		0xC618
    #define COLOR_GRAY2           	0xA514
    #define COLOR_GRAY3           	0x630C
    #define COLOR_GRAY4           	0x4208
    #define COLOR_GRAY5	        	0x2104
    #define	COLOR_GRAY6	        	0x3186

// Library Interface ----------------------------------------------------------
    /** @brief  Function that returns the library Version as String
     *
     *  This function returns the Library version as String
     *
     *  @retval Version as String
     */
    char*   libdyps_getVersionsStr();

    /** @brief  Function that returns the library Version
     *
     *  This function returns the Library version. (Format: yymmddvv)
     *
     *  @retval Version as unsigend long
     */
    unsigned long libdyps_getVersion();

// P0P1 Interface -------------------------------------------------------------

    /** @brief  Initializes the DYPS-Environment
     *
     *  @param  None
     *
     *  @return None
     */
    void initP0P1(void);

// P3 Interface ---------------------------------------------------------------

    /** @brief  Function to initialize P3
     *
     *  This function initialized the port P3
     *
     *  @param  input_mask - Mask that defines which PIN will be initialized as INPUT (=1). PINs were the corresponding bit is 0, will be initialized as OUTPUTS.
     *
     *  @return None
     */
    void initP3(unsigned char input_mask);

// P4 Interface ---------------------------------------------------------------

    /** @brief  Function to initialize P4
     *
     *  This function initialized the port P4
     *
     *  @param  input_mask - Mask that defines which PIN will be initialized as INPUT (=1). PINs were the corresponding bit is 0, will be initialized as OUTPUTS.
     *
     *  @return None
     */
    void initP4(unsigned char input_mask);

// P0P1_SHELL -----------------------------------------------------------------
    typedef enum _orientation_t{
        rot0   = 0x00,
        rot90  = 0x01,
        rot180 = 0x02,
        rot270 = 0x03
    } orientation_t;

    typedef struct _coordinate_t {
        uint16_t    x;
        uint16_t    y;
    } coordinate_t;

    typedef enum _switch_t {
        switch_pos = 0, /** 1 - Switchtype ON-OFF Hold */
        switch_neg = 1, /** 2 - Switchtype OFF-ON Hold */
        taster_pos = 2, /** 3 - Switchtype OFF-ON-OFF  */
        taster_neg = 3  /** 4 - Switchtype ON-OFF-ON   */
    } switch_t;

    /** @brief  Function to initialize P0 and P1 as well as the touchscreen
     *
     *  This function initializes the input-port (P0) and output-port (P1) and also the touchscreen-display
     *
     *  @param  args - defines how the Display will be initialized /
     *          d - initialize debug interface /
     *          c - calibrate display at startup /
     *          p - portexchange P0-P1 -> P1-P0 /
     *          r - rotates the display (can be used multiple times) /
     *          m - mirrored 0-7 -> 7-0 /
     *          1 - Switchtype ON-OFF Hold /
     *          2 - Switchtype OFF-ON Hold /
     *          3 - Switchtype OFF-ON-OFF /
     *          4 - Switchtype ON-OFF-ON
     *
     *  @return None
     */
    void initTouchP0P1(char* args);

    /** @brief  Function to set the orientation of the display
     *
     *  This function sets the orientation of the touchscreen-display
     *
     *  @param  orientation 0 = rot0, 1 = rot90 (default), 2 = rot180 , 3 = rot270
     *
     *  @return None
     */
    void setRotation ( orientation_t or );

    /** @brief  Function to set the captions of the switches
     *
     *  This function sets the captions of all switches.
     *  Be aware that just the first 3 characters are used.
     *
     *  @param  str0..str7 - Captions of the switches
     *
     *  @return None
     */
    void setP0Caption( char* str0, char* str1, char* str2, char* str3,
                       char* str4, char* str5, char* str6, char* str7 );

    /** @brief  Function to set the captions of the LEDs
     *
     *  This function sets the captions of all LEDs.
     *  Be aware that just the first 3 characters are used.
     *
     *  @param  str0..str7 - Captions of the LEDs
     *
     *  @return None
     */
    void setP1Caption( char* str0, char* str1, char* str2, char* str3,
                       char* str4, char* str5, char* str6, char* str7 );

    /** @brief  Function to set the color of the switches
     *
     *  This function sets the color of the masked switches.
     *
     *  @param  mask - mask to choose the switches
     *  @param  OFFColor - color of the switches when they are OFF
     *  @param  ONColor - color of the switches when they are ON
     *
     *  @return None
     */
    void setP0Colors( unsigned char mask , unsigned short OFFColor , unsigned short ONColor);

    /** @brief  Function to set the color of the LEDs
     *
     *  This function sets the color of the masked LEDs.
     *
     *  @param  mask - mask to choose the LEDs
     *  @param  OFFColor - color of the LEDs when they are OFF
     *  @param  ONColor - color of the LEDs when they are ON
     *
     *  @return None
     */
    void setP1Colors( unsigned char mask , unsigned short OFFColor , unsigned short ONColor);

    /** @brief  Function to set the type of each switch
     *
     *  This function sets the type of each switch.
     *
     *  @param  s0..s7 - type of each switch
     *
     *  @return None
     */
    void setP0SwitchType ( switch_t s0 , switch_t s1 , switch_t s2 , switch_t s3 , switch_t s4 , switch_t s5 , switch_t s6 , switch_t s7 );

    /** @brief  Function to set the type of each switch
     *
     *  This function sets the type of each switch specified by the mask.
     *
     *  @param  mask - mask to choose the switch (each bit represents a switch)
     *  @param  st - type of switch
     *
     *  @return None
     */
    void setP0SwitchTypeMask ( unsigned char mask, switch_t st );

// Graphical Interface ---------------------------------------------------------
    /** @brief  Put LCD in Sleep-Mode
     *
     *  This function puts the LCD in sleep mode
     *  @note Display will be white
     *
     *  @return None
     */
    void lcd_sleep( void );

    /** @brief  Wake up the LCD from Sleep-Mode
     *
     *  This function wakes up the LCD if its in Sleep-Mode
     *
     *  @return None
     */
    void lcd_wakeup( void );

    /** @brief  Clear/fill the screen with a single color
     *
     *  This function clears/fills the screen with a single color
     *
     *  @param  color   - color
     *
     *  @return None
     */
    void lcd_clear(uint16_t color);

    /** @brief  Set the orientation of the display
     *
     *  This function sets the orientation of the touchscreen-display
     *
     *  @param  orientation 0 = rot0, 1 = rot90 (default), 2 = rot180 , 3 = rot270
     *
     *  @return None
     */
    void lcd_setOrientation(orientation_t orientation);

    /** @brief  Get the orientation of the display
     *
     *  This function returns the orientation of the touchscreen-display
     *
     *  @return orientation 0 = rot0, 1 = rot90 (default), 2 = rot180 , 3 = rot270
     */
    orientation_t const lcd_getOrientation( void );

    /** @brief  Set the LCD-segment to write to
     *
     *  This function sets the segment of the LCD.
     *  After this command PIXEL-Data have to be sent to the LCD.
     *
     *  @note This function sends 11 bytes to the LCD.
     *
     *  @param x1 - start position x
     *  @param y1 - start position y
     *  @param x2 - end position x
     *  @param y2 - end position y
     *
     *  @return Boolean about success. 1 = Success, 0 = Clipped
     */
    bool lcd_setAddress(uint16_t x1,uint16_t y1,uint16_t x2,uint16_t y2);

    /** @brief  Set a single pixel
     *
     *  This function sets a single pixel to a defined color. Be aware that this
     *  function is not efficient as it first sends the address data (11 bytes)
     *  and after words the color data (2 bytes).
     *
     *  @note If the desired position is outside the LCD this function will be ignored.
     *
     *  @param x     - x position
     *  @param y     - y position
     *  @param color - the desired color of the pixel
     *
     *  @return none
     */
    void lcd_setPixel(uint16_t x, uint16_t y, uint16_t color);

    /** @brief  Draw a line
     *
     *  This function draws a line on the LCD.
     *
     *  @note Positions outside the LCD will be clipped to the LCD-size
     *
     *  @param x1    - start position x
     *  @param y1    - start position y
     *  @param x2    - end position x
     *  @param y2    - end position y
     *  @param color - the desired color
     *
     *  @return none
     */
    void lcd_drawLine(uint16_t x1, uint16_t y1, uint16_t x2, uint16_t y2, uint16_t color);

    /** @brief  Draw a plus sign (+)
     *
     *  This function draws a + sign on the LCD
     *
     *  @param  x     - x position
     *  @param  y     - y position
     *  @param  r     - radius
     *  @param  color - color of the sign
     *
     *  @return None
     */
    void lcd_drawMark( uint16_t x , uint16_t y , uint16_t r , uint16_t color );

    /** @brief  Draw a rectangularvoid dypsInit_extTouch( void )

     *
     *  This function draws a rectangular on the LCD.
     *
     *  @note Positions outside the LCD will be clipped to the LCD-size
     *
     *  @param x1    - start position x
     *  @param y1    - start position y
     *  @param x2    - end position x
     *  @param y2    - end position y
     *  @param color - the desired color
     *  @param fill  - 1 = filled rectangular, 0 = just frame
     *
     *  @return none
     */
    void lcd_drawRect(uint16_t x1, uint16_t y1, uint16_t x2, uint16_t y2, uint16_t color, uint8_t fill);

    /** @brief  Draw a rectangular with full height
     *
     *  This function draws a rectangular on the LCD with full height
     *
     *  @note Positions outside the LCD will be clipped to the LCD-size
     *
     *  @param x     - start position x
     *  @param width - width of the rectangular
     *  @param color - the desired color
     *  @param fill  - 1 = filled rectangular, 0 = just frame
     *
     *  @return none
     */
    void lcd_drawRectFullHeight(uint16_t x, uint16_t width, uint16_t color, uint8_t fill);

    /** @brief  Draw a rectangular with full width
     *
     *  This function draws a rectangular on the LCD with full width
     *
     *  @note Positions outside the LCD will be clipped to the LCD-size
     *
     *  @param y      - start position y
     *  @param height - height of the rectangular
     *  @param color  - the desired color
     *  @param fill   - 1 = filled rectangular, 0 = just frame
     *
     *  @return none
     */
    void lcd_drawRectFullWidth(uint16_t y, uint16_t height, uint16_t color, uint8_t fill);

    /** @brief  Draw a circle
     *
     *  This function draws a circle on the LCD
     *
     *  @note Positions outside the LCD will be clipped
     *
     *  @param x     - center position x
     *  @param y     - center position y
     *  @param r     - radius of circle
     *  @param color - the desired color
     *
     *  @return none
     */
    void lcd_drawCircle(uint16_t x, uint16_t y, uint16_t r, uint16_t color);

    // Advanced LCD

    typedef struct _LCD_FONT{
        const uint8_t width;        /**< @brief max. character width, for monospaced font */
        const uint8_t height;       /**< @brief character height */
        const uint8_t first_char;   /**< @brief first printable character in data */
        const uint8_t last_char;    /**< @brief last printable character in data */
        const uint8_t *char_width;  /**< @brief list of character widths, proportional font */
        const uint16_t *pixel_offset;   /**< @brief list of pixel offsets in data */
        const uint8_t *data;        /**< @brief pixel data */
    } LCD_FONT;

    extern const LCD_FONT Font8x11; /**< @brief Font containing characters of size 8x11 pixels */
    extern const LCD_FONT Font13x16;/**< @brief Font containing characters of size 13x16 pixels */

    typedef union _PIXEL_COLOR{
        uint8_t Byte[2];
        struct{
            uint8_t  Hi;
            uint8_t  Lo;
        }Bytes;
        uint16_t Word;
    } PIXEL_COLOR;

    typedef struct _d_theme_t{
        PIXEL_COLOR BG_Color;
        PIXEL_COLOR Font_Color;
    } d_theme_t;

    typedef struct _GIMP_INDEXED_IMG{
        const uint16_t  width;
        const uint16_t  height;
        const uint8_t   (*cmap)[3];
        const uint8_t   *data;
    } GIMP_INDEXED_IMG;

    typedef struct _LCD_BITMAP{
        const uint8_t width;
        const uint8_t height;
        const uint8_t *data;
    } LCD_BITMAP;

    /** @brief  Set font color
     *
     *  This function sets the desired font-color for next strings to write.
     *
     *  @param color - the desired font-color
     *
     *  @return none
     */
    void lcd_setColorFont(uint16_t color);

    /** @brief  Get font color
     *
     *  This function returns the current font-color.
     *
     *  @return the current font-color
     */
    uint16_t const lcd_getColorFont(void);

    /** @brief  Set background color
     *
     *  This function sets the desired background-color for next strings to write.
     *
     *  @param color - the desired background-color
     *
     *  @return none
     */
    void lcd_setColorBackground(uint16_t color);

    /** @brief  Get background color
     *
     *  This function returns the current background-color.
     *
     *  @return the current background-color
     */
    uint16_t const lcd_getColorBackground(void);

    /** @brief  Set theme (font and background color)
     *
     *  This function sets the desired theme for next strings to write.
     *
     *  @param theme - pointer to the desired color theme
     *
     *  @return none
     */
    void lcd_setTheme(d_theme_t *theme);

    /** @brief  Save theme (font and background color)
     *
     *  This function returns the current theme.
     *
     *  @param theme - pointer to a theme-structure to save the current theme to
     *
     *  @return none
     */
    void lcd_getTheme(d_theme_t *theme);

    /*! \brief  Set font type.
     *
     *  This function sets the desired font for the next strings to write.
     *
     *  @param font - Pointer to the desired font structure.
     *                The following fonts are available:
     *                \ref Font8x11, \ref Font13x16.
     *  @param use_monospace - Defines if the font has to be written in monospaced or
     *                         proportional style. 0: proportional, 1: monospaced.
     *
     *  @return none
     */
    void lcd_setFont(volatile const LCD_FONT *font, uint8_t use_monospace);

    /*! \brief  Save font type.
     *
     *  This function saves the current font.
     *
     *  @param font - Pointer to store the current font.
     *  @param use_monospace - Memory-pointer to store whether the font has to be written in monospaced or
     *                         proportional style. 0: proportional, 1: monospaced.
     *
     *  @return none
     */
    void lcd_getFont(volatile const LCD_FONT *font, uint8_t *monospace);

    /*! \brief  Get font height.
     *
     *  This function returns the height of the current font.
     *
     *  @return the height of the current font
     */
    uint8_t const lcd_getFontHeight();

    /*! \brief  Get string width
     *
     *  This function returns the width of a string written with the current font.
     *
     *  @param str - pointer to zero-terminated string.
     *
     *  @return the width of the string
     */
    uint16_t lcd_getStringWidth( const char *str );

    /*! \brief  Write a single character
     *
     *  This function writes a single character at the given position.
     *
     *  @param x - Offset to the left
     *  @param y - Offset to the top
     *  @param c - ASCII character
     *
     *  @return The width of the character written
     */
    uint16_t lcd_writeChar( uint16_t x , uint16_t y , char c );

    /*! \brief  Write a string
     *
     *  This function writes a string on the LCD at the given position.
     *
     *  @param x - Offset to the left
     *  @param y - Offset to the top
     *  @param str - pointer to zero-terminated string.
     *
     *  @return new position x
     */
    uint16_t lcd_writeString( uint16_t x , uint16_t y , char *str );

    /*! \brief  Write a string centered on screen
     *
     *  This function writes a string on the LCD in the center at a given height.
     *
     *  @param y - Offset to the top
     *  @param str - pointer to zero-terminated string.
     *
     *  @return new position x
     */
    uint16_t lcd_writeStringCenter( uint16_t y , char *str );

    /*! \brief  Write an integer
     *
     *  This function writes a integer value at the given position.
     *
     *  @param x - Offset to the left
     *  @param y - Offset to the top
     *  @param integer - integer to write
     *  @param decimalPlaces - decimalPlaces 0...10
     *
     *  @return new position x
     */
    uint16_t lcd_writeInt(uint16_t x, uint16_t y, int32_t integer, uint8_t decimalPlaces);

    /*! \brief  Write a digit
     *
     *  This function writes a single digit at the given position.
     *
     *  @param x - Offset to the left
     *  @param y - Offset to the top
     *  @param digit - digit to write (0...9)
     *  @param scale - scale of the digit
     *
     *  @return The width of the digit written
     */
    uint16_t lcd_writeDigit( uint16_t x , uint16_t y , uint16_t digit , uint16_t scale );

    /*! \brief  Draws a battery-symbol
     *
     *  This function draws a battery-symbol and the percentage at the given position.
     *
     *  @param x - Offset to the left
     *  @param y - Offset to the top
     *  @param percentage - percentage (0...100) of battery charge state
     *
     *  @return none
     */
    void lcd_drawBattery( int16_t x , int16_t y , uint8_t percentage );

    /*! \brief  Draws a bitmap
     *
     *  This function draws a bitmap at the given position.
     *
     *  @param x - Offset to the left
     *  @param y - Offset to the top
     *  @param bitmap - pointer to the bitmap data
     *
     *  @return none
     */
    void lcd_drawBitmap( int16_t x , int16_t y , const LCD_BITMAP *bitmap );

    /*! \brief  Draws a GIMP_IMG
     *
     *  This function draws a GIMP-IMG at the given position.
     *
     *  @param x - Offset to the left
     *  @param y - Offset to the top
     *  @param bitmap - pointer to the IMG-data
     *
     *  @return none
     */
    void lcd_drawGimpImg( int16_t x , int16_t y , const GIMP_INDEXED_IMG *img );

// TOUCH ----------------------------------------------------------------------

    typedef struct _tsc_calibartionData_t{
        long divider;
        long An;
        long Bn;
        long Cn;
        long Dn;
        long En;
        long Fn;
    } tsc_calibartionData_t;// Struct to hold calibration-coefficient

    /** @brief   Initialize the TSC2046
    *
    *  This function initialized the SPI-Interface and the TSC2046
    *
    *  @author  Roman Gassmann
    *
    *  @return  none
    */
    void tsc_init ( void );

    /** @brief   Check the state of TSC2046 IRQ
    *
    *  This function returns the state of the TSC2046-Interrupt-Pin
    *
    *  @author  Roman Gassmann
    *
    *  @return  boolean - true = touched, false = not touched
    */
    bool tsc_getIRQ(void);

    /** @brief   Get the touched-coordinates
    *
    *   This function calculates the touched coordinates from the touchsensor
    *
    *  @author  Roman Gassmann
    *
    *  @param   pos - pointer to where the coordinates should be write to
    *  @return  boolean if the written coordinates are valid
    */
    bool tsc_getXY ( coordinate_t *pos );

    /** @brief   Calibrate Touchscreen
    *
    *   This function shows 3 points (marked with a +) sequentially.
    *   If all points have been touched it calculates the calibration coefficients (Matrix).
    *   The calculated coefficients will then be set for further touch-calculations
    *
    *  @author  unknown
    *
    *  @param   cData - pointer to a set of calibration data (to write to)
    *  @return  None
    */
    void tsc_calibrate ( tsc_calibartionData_t *cData );

// ADC ------------------------------------------------------------------------

    /** @brief  Initialize the ADC
     *
     *  This function initializes the ADC for 16Bit conversions.
     *  It further initialized the ADC_IN1 and ADC_IN2.
     *
     *  @return None
     */
    void driver_ADC_init();

    /** @brief  Get ADC-Values from channel
     *
     *  This function returns the ADC-Values from a desired channel.
     *
     *  @param CH - Desired channel for conversion.
     *
     *  @return ADC-Value of the Channel CH
     */
    uint16_t driver_ADC_get(uint8_t CH);

    /** @brief  Get ADC-Values from ADC_IN1
     *
     *  This function returns the ADC-Values of the ADC_IN1 (Channel 17).
     *
     *  @return ADC-Value of the ADC_IN1
     */
    uint16_t driver_ADC_getIn1();

    /** @brief  Get ADC-Values from ADC_IN2
     *
     *  This function returns the ADC-Values of the ADC_IN2 (Channel 18).
     *
     *  @return ADC-Value of the ADC_IN2
     */
    uint16_t driver_ADC_getIn2();

// DAC ------------------------------------------------------------------------

    /** @brief  Initialize the DAC
     *
     *  This function initializes the DAC for 12Bit conversions.
     *
     *  @return None
     */
    void driver_DAC_init();

    /** @brief  Set DAC value
     *
     *  This function sets the DAC to a desired value.
     *  @note This is just a 12Bit DAC. Values > 12Bit will be truncated.
     *
     *  @param value - The desired value (12Bit)
     *
     *  @return None
     */
    void driver_DAC_set( uint16_t value );

// I2C ------------------------------------------------------------------------

    /*! @brief  Initialize the I2C-Interface
     *
     *  Initializes the I2C-Interface with the given Baud-rate.
     *  See RM 45.3.2 I2C Frequency Divider register
     *
     *  @param I2Cx_F - the Frequency Divider value
     *
     *  @return None
     */
    void driver_i2c_init ( unsigned char I2Cx_F );

    /*! @brief  Checks if a Slave exists
     *
     * Checks if slave returns ACK on slaveID transmission
     * @param slaveID ID of the slave (7Bit)
     *
     * @return bool true if ACK received, otherwise false
     */
    bool driver_i2c_checkSlave ( unsigned char slaveID );

    /*! @brief  Writes n bytes to a Slave
     *
     * Write n bytes of Data to the slave
     * @param slaveID ID of the slave (7Bit)
     * @param txData is Array of Data to write
     * @param txLen is length of Data to write
     *
     * @return bool true if ACK received, otherwise false
     */
    bool driver_i2c_write ( unsigned char slaveID, unsigned char *txData, unsigned char txLen );

    /*! @brief  Writes a bytes to a specified register of a Slave
     *
     * Write a byte of Data to specified register
     * @param slaveID ID of the slave (7Bit)
     * @param registerAddress is Register Address
     * @param txData is Data to write
     *
     * @return bool true if ACK received, otherwise false
     */
    bool driver_i2c_writeRegister ( unsigned char slaveID, unsigned char registerAddress, unsigned char txData );

    /*! @brief  Writes n bytes to a specified register of a Slave
     *
     * Write n bytes of Data to the slave at the specified register.
     * This obviously requires the slave to have a register auto-increment function.
     * @param slaveID ID of the slave (7Bit)
     * @param registerAddress is Register Address
     * @param txData is Array of Data to write
     * @param txLen is length of Data to write
     *
     * @return bool true if ACK received, otherwise false
     */
    bool driver_i2c_writeRegisterCont ( unsigned char slaveID, unsigned char registerAddress, unsigned char *txData, unsigned char txLen );

    /*! @brief  Reads a specified register of a Slave
     *
     * Read a register
     * @param slaveID ID of the slave (7Bit)
     * @param registerAddress is Register Address
     * @param rxData stored in Register
     *
     * @return bool true if ACK received, otherwise false
     */
    bool driver_i2c_readRegister ( unsigned char slaveID, unsigned char registerAddress, unsigned char *rxData );

    /*! @brief  Reads n bytes of a specified register of a Slave
     *
     * Read n bytes of Data from slave at the specified register
     * This obviously requires the slave to have a register auto-increment function.
     * @param slaveID ID of the slave (7Bit)
     * @param registerAddress is Register Address
     * @param rxData is Array of Data to write to
     * @param rxLen is length of Data to read
     *
     * @return bool true if ACK received, otherwise false
     */
    bool driver_i2c_readRegisterCont ( unsigned char slaveID, unsigned char registerAddress, unsigned char *rxData, unsigned char rxLen );

    /*! @brief  Writes n bytes to and reads m bytes of a Slave
     *
     * Write n bytes to and read m bytes from slave
     * @param slaveID ID of the slave (7Bit)
     * @param txData is Array of Data to write
     * @param txLen is length of Data to write
     * @param rxData is Array of Data to write to
     * @param rxLen is length of Data to read
     *
     * @return bool true if ACK received, otherwise false
     */
    bool driver_i2c_writeReadCont ( unsigned char slaveID, unsigned char* txData, unsigned char txLen, unsigned char *rxData, unsigned char rxLen );

// SPI ------------------------------------------------------------------------
    typedef enum _dyps_spi_baudrate_t{
        SPI_BAUDRATE_30MHz = 0x00,
        SPI_BAUDRATE_15MHz = 0x01,
        SPI_BAUDRATE_10MHz = 0x02,
        SPI_BAUDRATE_7M5Hz = 0x03,
        SPI_BAUDRATE_3M75Hz = 0x04,
        SPI_BAUDRATE_1M875Hz = 0x05,
        SPI_BAUDRATE_937k5Hz = 0x06,
        SPI_BAUDRATE_468k75Hz = 0x07,
        SPI_BAUDRATE_234k375Hz = 0x08,
        SPI_BAUDRATE_117k188Hz = 0x09,
        SPI_BAUDRATE_58k594Hz = 0x0A,
        SPI_BAUDRATE_29k297Hz = 0x0B,
        SPI_BAUDRATE_14k648Hz = 0x0C,
        SPI_BAUDRATE_7k324Hz = 0x0D,
        SPI_BAUDRATE_3k662Hz = 0x0E,
        SPI_BAUDRATE_1k831Hz = 0x0F,
    } dyps_spi_baudrate_t;

    /*! @brief  Initialize the SPI-Interface
     *
     *  Initializes the SPI-Interface.
     *
     * @param bauderate - Baudrate of SPI-CLK
     * @param CPOL - Clock Polarity 0: The inactive state value of SCK is low. , 1: The inactive state value of SCK is high.
     * @param CPHA - Clock Phase 0: Data is captured on the leading edge of SCK and changed on the following edge. , 1: Data is changed on the leading edge of SCK and captured on the following edge.
     *
     * @return None
     */
    void driver_spi_init(dyps_spi_baudrate_t bauderate, bool CPOL, bool CPHA);

    /*! @brief  Write and reads one byte to / from the slave
     *
     * Writes one byte to and reads one byte from the slave.
     * CS has to be handled by user!
     *
     * @param byte - data to write
     * @param last - true if its the last byte to write, false otherwise
     *
     * @return read byte
     */
    uint8_t driver_spi_writeRead(uint8_t byte, bool last);

    /*! @brief  Write and reads n byte to and from the slave
     *
     * Writes and reads n bytes to and from the slave.
     * CS has to be handled by user!
     *
     * @param txData - write-Data array
     * @param rxData - read-Data array
     * @param len - len of data-arrays
     *
     * @return none
     */
    void driver_spi_writeReadCont(uint8_t *txData, uint8_t *rxData, uint8_t len);

    /*! @brief  Write n byte to the slave
     *
     * Writes n bytes to the slave.
     * CS has to be handled by user!
     *
     * @param txData - write-Data array
     * @param len - len of data-arrays
     *
     * @return none
     */
    void driver_spi_writeCont(uint8_t *txData, uint8_t len) ;

// Delays ---------------------------------------------------------------------

    /** @brief  Delays the MCU for a given amount of ms (blocking)
     *
     *  This function is a simple and ugly while - NOP() delay.
     *
     *  @param  ms - Amount of ms to delay the MCU
     *
     *  @return None
     */
    void delay_ms(unsigned long ms);

    /** @brief  Delays the MCU for a given amount of us (blocking)
     *
     *  This function is a simple and ugly while - NOP() delay.
     *
     *  @param  us - Amount of us to delay the MCU
     *
     *  @return None
     */
    void delay_us(unsigned long us);

// Edge-triggering ------------------------------------------------------------

    typedef struct _edge_trg_t{
        char act;
        char old;
        char edge;
        char edge_pos;
        char edge_neg;
    } edge_trg_t;

    /** @brief  Edge-triggering-helper function
     *
     *  This function detects edges and splits them into the positive and negative ones.
     *
     *  @param  trg - pointer to an edge_trg_t that holds the "old" triggering data
     *
     *  @param  new_state - the new input data e.g. P0
     *
     *  @retval None
     */
    void driver_GPIO_edgeTriggering( edge_trg_t *trg , unsigned char new_state );

    // mem-Fkt
    /**
     * @brief Memory Copy
     *
     * This function copies n bytes from src adr to dest adr.
     */
    void * memcpy (void *dest, const void *src, unsigned int n);

    /**
     * @brief Memory Compare
     *
     * This function compares n bytes from src1 adr and src2 adr.
     */
    bool    mem_cmp (const void *src1, const void *src2, unsigned int n);

// Extensions
    /** @brief  Function to initialize the DYPS TOUCH
     *
     *  This function initializes the TOUCH-Display. Examplecode: dypsInit_extTouch("",&test);
     *
     *  @param  args - defines how the Display will be initialized
     *          d - initialize debug interface
     *          c - calibrate display at startup
     *  @param  updateFKT - function that will be called every 2.333ms), set to 0 if not used
     *
     *  @return None
     */
    void dyps_initExtTouch( char* args , void (*updateFKT)() );

    /** @brief  Function to initialize the DYPS TRAFFIC LIGHT
     *
     *  This function initializes the DYPS TRAFFIC LIGHT Hardware.
     *  Is equivalent to call initP3(0x88); initP4(0x88);
     *
     *  @param  None
     *
     *  @return None
     */
    void dyps_initExtTrafficLight( void );

    /** @brief  Function to initialize the DYPS SENSO
     *
     *  This function initializes the DYPS SENSO Hardware. Examplecode: dypsInit_extTouch("",&test);
     *
     *  @param  None
     *  @return None
     */
    void dyps_initExtSenso( void );

    /** @brief  Initialize the debug USBDM-UART-Interface
     *
     *  This function initializes the USBDM-Uart-Interface.
     *
     *  @return None
     */
    void dyps_initDebugInterface( void );

    /** @brief  Write a debug message via USBDM-UART-Interface
     *
     *  This function sends a message (str) via the USBDM-Uart-Interface.
     *  Caution: To use this function the initialization of the debug interface
     *           must be done!
     *
     *  @param  str - message string to send (null terminated)
     *
     *  @return None
     */
    void dyps_writeDebugMsg( char* str );

// String Manipulationen
    char* itoa(int32_t i, char b[]);
    char* itoaComma(int32_t i, char *b, uint8_t decimalPlaces);
    char* itoh(uint32_t i, char b[]);

#endif // LIBDYPS_H

