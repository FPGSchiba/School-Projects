/*
 *   Project-Titel: Hello World
 *   File-Name: application/main.c
 *   Description: main.c file for DYPS micro processor.
 *   Author: Jann Erhardt
 *
 */

#include "../system/lib/libDYPS.h"

#define LONG_DELAY 1000
#define SHORT_DELAY 200
#define INPUT_DELAY 10

int main(void) {
    initP0P1();

    while(1) {
        P1 = 0xff;
        delay_ms(1000);
        P1 = 0x00;
        delay_ms(1000);
    }

    P1 = 0;
    return 0;
}
