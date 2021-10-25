/*
 *   Project-Titel: Hello World
 *   File-Name: application/bitMask.c
 *   Description: bitMask.c file for DYPS micro processor.
 *   Author: Jann Erhardt
 *
 */

#include "../system/lib/libDYPS.h"

#define LONG_DELAY 1000
#define SHORT_DELAY 200
#define INPUT_DELAY 10


void Blinken(int Switcher){
    int endDelay = 500;
    switch(Switcher){
        case 10:
            break;
        case 0:
            P1 = 0xff;
            delay_ms(500);
            break;
        case 1:
            P1 = 0xff;
            delay_ms(1000);
            endDelay = 1000;
            break;
        case 2:
            P1 = 0xff;
            delay_ms(100);
            endDelay = 100;
            break;
        case 3:
            P1 = 0x0f;
            delay_ms(500);
            break;
        case 4:
            P1_7 = 1;
            delay_ms(500);
            break;
        case 5:
            P1 = 0xf0;
            delay_ms(500);
            P1 = 0x0f;

    }
    if(Switcher != 5){
        P1 = 0x00;
    }

    delay_ms(endDelay);
}

int main(void) {
    initP0P1();

    unsigned char SW0;
    unsigned char SW1;
    unsigned char SW2;
    unsigned char SW3;
    unsigned char SW4;
    unsigned char SW5;

    while(1) {

        SW0 = P0_0;
        SW1 = P0_1;
        SW2 = P0_2;
        SW3 = P0_3;
        SW4 = P0_4;
        SW5 = P0_5;

        int BlinkMode = 10;

        if(SW0){
            BlinkMode = 0;
            if(SW1){
                BlinkMode = 1;
            }
            if(BlinkMode == 0 && SW2){
                BlinkMode = 2;
            }
            if(BlinkMode == 0 && SW3){
                BlinkMode = 3;
            }
            if(BlinkMode == 0 && SW4){
                BlinkMode = 4;
            }
            if(BlinkMode == 0 && SW5){
                BlinkMode = 5;
            }
        }

        Blinken(BlinkMode);
        delay_ms(10);
    }

    P1 = 0;
    return 0;
}
