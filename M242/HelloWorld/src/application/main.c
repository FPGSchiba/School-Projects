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
#define INPUT_DELAY 10

#define S2 P0_2
#define S1 P0_1
#define L1 P1_1
#define L2 P1_2

int main(void) {
    initP0P1();

    while(1) {
        L1 = !S2 & S1;
        L2 = (!S2 & S1) | (S2 & !S1);
        delay_ms(INPUT_DELAY);
    }

    P1 = 0;
    return 0;
}
