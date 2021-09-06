/*
 *   Titel: hello World
 *   Description:
 *   Author: Jann Erhardt
 *
 */

#include "../system/lib/libDYPS.h"

int main(void) {
    initP0P1();
    initTouchP0P1("mp 3");
    int loopCount = 0;

    while(1) {
        int delayTime = loopCount * 100;
        P1 = 1;
        for(int i = 0; i<8; i++){
            delay_ms(delayTime);
            // P1 = P1 * 2;
            P1 = P1 << 1; // bit schieben
        }

        P1 = 128;
        for(int i = 0; i<8; i++){
            delay_ms(delayTime);
            // P1 = P1 / 2;
            P1 = P1 >> 1;
        }

        loopCount++;
    }

    P1 = 0;
    return 0;
}
