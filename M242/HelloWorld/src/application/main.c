/*
 *   Project-Titel: Hello World
 *   File-Name: application/main.c
 *   Description: Main.c file for DYPS micro processor.
 *   Author: Jann Erhardt
 *
 */

#include "../system/lib/libDYPS.h"
#define LONG_DELAY 500
#define SHORT_DELAY 100

int main(void) {
    initP0P1();
    const unsigned char LED_1 = 0x01;
    const unsigned char LED_2 = 0x02;
    const unsigned char LED_3 = 0x04;
    const unsigned char LED_4 = 0x08;
    const unsigned char LED_5 = 0x10;
    const unsigned char LED_6 = 0x20;
    const unsigned char LED_7 = 0x40;
    const unsigned char LED_8 = 0x80;
    const unsigned char LED_No = 0x00;
    const unsigned char LED_All = 0xff;
    const unsigned char LSB = 0x0f;
    const unsigned char MSB = 0xf0;

    int loopCount = 1;
    while(1) {
        P1 = LED_1;                 delay_ms(LONG_DELAY);
        P1 = LED_2;                 delay_ms(LONG_DELAY);
        P1 = LED_3;                 delay_ms(LONG_DELAY);
        P1 = LED_4;                 delay_ms(LONG_DELAY);
        P1 = LED_5;                 delay_ms(LONG_DELAY);
        P1 = LED_6;                 delay_ms(LONG_DELAY);
        P1 = LED_7;                 delay_ms(LONG_DELAY);
        P1 = LED_8;                 delay_ms(LONG_DELAY);
        P1 = LED_All;               delay_ms(LONG_DELAY);
        P1 = LED_No;                delay_ms(LONG_DELAY);
        P1 = LED_1 | LED_3 | LED_8; delay_ms(LONG_DELAY);
        P1 = LED_All & MSB;         delay_ms(LONG_DELAY);
        P1 = LED_All & LSB;         delay_ms(LONG_DELAY);
        P1 = LED_All;               delay_ms(LONG_DELAY);
        P1 = LED_All ^ LSB;         delay_ms(LONG_DELAY);

        loopCount++;
    }

    P1 = 0;
    return 0;
}
