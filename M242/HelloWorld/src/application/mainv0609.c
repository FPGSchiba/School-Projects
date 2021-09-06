
/*
 *   Titel: hello World
 *   Description: main version 06.09.2021
 *   Author: Jann Erhardt
 *
 */

#include "../system/lib/libDYPS.h"

int main(void) {
    initP0P1();
    initTouchP0P1("mp 3");

    while(1) {
        // Symmetrical blinker (hex)
        for (int i = 0; i < 8; i++){ // 8x Schlaufe
            P1 = 0x1A;
            delay_ms(500);
            P1 = 0;
            delay_ms(500);
        }

        P1 = 255;
        delay_ms(5000);

        // Blinker Asymtrical (dec)
        for (int i = 0; i < 8; i++){ // 8x Schlaufe
            P1 = 26;
            delay_ms(1000);
            P1 = 0;
            delay_ms(400);
        }

        P1 = 'U';
        delay_ms(5000);

        // Blinker Symetrical (ASCII)
        for (int i = 0; i < 8; i++){ // 8x Schlaufe
            P1 = 'J';
            delay_ms(500);
            P1 = 0;
            delay_ms(500);
        }

        P1 = 255;
        delay_ms(5000);

        // Binärer Zähler
        P1 = 0;
        for(int i = 0; i<512; i++){
            P1 = i;
            delay_ms(10);
        }

        // Lauflicht Bit schieben + mal 2
        P1 = 1;
        delay_ms(100);
        for(int i = 0; i<8; i++){
            // P1 = P1 * 2;
            P1 = P1 << 1; // bit schieben
            delay_ms(100);
        }

        // Lauflicht Bit schieben + durch 2
        P1 = 128;
        delay_ms(100);
        for(int i = 0; i<8; i++){
            // P1 = P1 / 2;
            P1 = P1 >> 1;
            delay_ms(100);
        }
    }

    P1 = 0;
    return 0;
}
