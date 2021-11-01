/*
 *   Project-Titel: Hello World
 *   File-Name: application/mainv0111.c
 *   Description: mainv0111.c version file for DYPS micro processor.
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
        delay_ms(10);
    }

    P1 = 0;
    return 0;
}
