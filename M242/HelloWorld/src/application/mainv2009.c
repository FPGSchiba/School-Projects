/*
 *   Project-Titel: Hello World
 *   File-Name: application/mainv2009.c
 *   Description: A version File for DYPS micro processor.
 *   Author: Jann Erhardt
 *
 */

#include "../system/lib/libDYPS.h"
#define LONG_DELAY 500
#define SHORT_DELAY 100

int main(void) {
    initP0P1();

    while(1) {
        P1_7 = P0_0;        // Led_7 wenn S_0
        P1_6 = !P0_0;       // LED_6 wenn nicht S_0
        P1_5 = P0_0 | P0_1; // LED_5 wenn S_0 oder S_1
        P1_4 = P0_0 & P0_1; // LED_4 wenn S_0 und S_1

        if (P0_3){
            P1_3 = 1;       // LED_3 wenn S_3
        }
        else if (P0_0 & P0_1 & P0_2) {
            P1_3 = 0;       // nicht LED_3 wenn S_0, S_1 und S_2
        }

        delay_ms(10);
    }

    P1 = 0;
    return 0;
}

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
