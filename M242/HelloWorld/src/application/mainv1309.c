/*
 *   Project-Titel: hello World
 *   File-Name: mainv0609.c
 *   Description: main version 06.09.2021
 *   Author: Jann Erhardt
 *
 */

#include "../system/lib/libDYPS.h"

int main(void) {
    initP0P1();

    unsigned char LED_1 = 0b00000001;
    LED_1 = 0x01;
    unsigned char LED_2 = 0b00000010;
    LED_2 = 0x02;
    unsigned char LED_3 = 0b00000100;
    LED_3 = 0x04;
    unsigned char LED_4 = 0b00001000;
    LED_4 = 0x08;
    unsigned char LED_5 = 0b00010000;
    LED_5 = 0x10;
    unsigned char LED_6 = 0b00100000;
    LED_6 = 0x20;
    unsigned char LED_7 = 0b01000000;
    LED_7 = 0x40;
    unsigned char LED_8 = 0b10000000;
    LED_8 = 0x80;

    int loopCount = 1;
    while(1) {
        P1 = 0x0f;
        delay_ms(1000);
        P1 = 0xf0;
        delay_ms(1000);

        loopCount++;
    }

    P1 = 0;
    return 0;
}


#include "../system/lib/libDYPS.h"
#define LONG_DELAY 1000
#define SHORT_DELAY 100

int main(void) {
    initP0P1();
    unsigned char LED_1 = 0b00000001;
    LED_1 = 0x01;
    unsigned char LED_2 = 0b00000010;
    LED_2 = 0x02;
    unsigned char LED_3 = 0b00000100;
    LED_3 = 0x04;
    unsigned char LED_4 = 0b00001000;
    LED_4 = 0x08;
    unsigned char LED_5 = 0b00010000;
    LED_5 = 0x10;
    unsigned char LED_6 = 0b00100000;
    LED_6 = 0x20;
    unsigned char LED_7 = 0b01000000;
    LED_7 = 0x40;
    unsigned char LED_8 = 0b10000000;
    LED_8 = 0x80;

    int loopCount = 1;
    int longDelay = 1000;
    while(1) {
        P1 = LED_1;
        delay_ms(LOGN_DELAY);
        P1 = LED_2;
        delay_ms(LOGN_DELAY);
        P1 = LED_3;
        delay_ms(LOGN_DELAY);
        P1 = LED_4;
        delay_ms(LOGN_DELAY);
        P1 = LED_5;
        delay_ms(LOGN_DELAY);
        P1 = LED_6;
        delay_ms(LOGN_DELAY);
        P1 = LED_7;
        delay_ms(LOGN_DELAY);
        P1 = LED_8;
        delay_ms(LOGN_DELAY);
        P1 = 0xff;
        delay_ms(LOGN_DELAY);

        loopCount++;
    }

    P1 = 0;
    return 0;
}

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
        P1 = LED_1;     delay_ms(LONG_DELAY);
        P1 = LED_2;     delay_ms(LONG_DELAY);
        P1 = LED_3;     delay_ms(LONG_DELAY);
        P1 = LED_4;     delay_ms(LONG_DELAY);
        P1 = LED_5;     delay_ms(LONG_DELAY);
        P1 = LED_6;     delay_ms(LONG_DELAY);
        P1 = LED_7;     delay_ms(LONG_DELAY);
        P1 = LED_8;     delay_ms(LONG_DELAY);
        P1 = LED_All;   delay_ms(LONG_DELAY);
        P1 = LED_No;    delay_ms(LONG_DELAY);
        P1 = LED_1 | LED_3 | LED_8; delay_ms(LONG_DELAY);
        P1 = LED_All & MSB;         delay_ms(LONG_DELAY);
        P1 = LED_All & LSB;         delay_ms(LONG_DELAY);
        P1 = LED_All;   delay_ms(LONG_DELAY);
        P1 = LED_All ^ LSB;   delay_ms(LONG_DELAY);

        loopCount++;
    }

    P1 = 0;
    return 0;
}

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
