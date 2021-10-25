/*
 *   Project-Titel: Hello World
 *   File-Name: application/mainv2709.c
 *   Description: Main.c version-file for DYPS micro processor.
 *   Author: Jann Erhardt
 *
 */
#include "../system/lib/libDYPS.h"

#define LONG_DELAY 1000
#define SHORT_DELAY 200
#define INPUT_DELAY 10

unsigned char X(unsigned char A, unsigned char C, unsigned char D) {
    return !((A | C) & (!A | D));
}

unsigned char Y(unsigned char A, unsigned char C, unsigned char D) {
    return !A & C & !D;
}


unsigned char X_13(unsigned char M, unsigned char N){
        /*
        M N X
        0 0 1
        0 1 0
        1 0 1
        1 1 1
        */
        return (M & !N) | (M & N) | (!M & !N);
}

unsigned char Y_14(unsigned char T, unsigned char S, unsigned char R){
    /*
    R S T Y
    0 0 0 0
    0 0 1 1
    0 1 0 1
    0 1 1 0
    1 0 0 1
    1 0 1 0
    1 1 0 0
    1 1 1 0
    */
    return (!R & !S & T) | (!R & S & !T) | (R & !S & !T);
}

void endTest(unsigned char newBit){
    P1 = 0x00;
    delay_ms(SHORT_DELAY);
    P1 = 0xff;
    delay_ms(LONG_DELAY);
    P1 = 0x00;
}

int main(void) {
    initP0P1();

    while(1) {
        //  1. Pin 7 des Ausgabeports ist auf logisch 1 zu setzen.
        //P1_7 = 1;

        //  2. Setze den Ausgabewert von Pin 6 auf logisch 0 zurück.
        //P1_6 = 0;

        //  3. Schalte Pin 0 der Eingabe auf Pin 0 der Ausgabe durch.
        //P1_0 = P0_0;

        //  4. Schalte Pin 1 der Eingabe invertiert zu Pin 1 der Ausgabe durch.
        //P1_1 = !P0_1;

        //  5. Codiere die Grundverknüpfung P1.2  =  P0.2  AND   P0.3
        //P1_2 = P0_2 & P0_3;

        //  6. Codiere die Grundverknüpfung P1.3  =  P0.2   OR   P0.3
        //P1_3 = P0_2 | P0_3;

        //  7. Ermögliche:        P1.4  =  P0.2   NOR   P0.3
        //P1_4 = !(P0_2 | P0_3);
        /*
        0 + 0 -> 1
        1 + 0 -> 0
        0 + 1 -> 0
        1 + 1 -> 0
        */

        //  8. Ermögliche:        P1.5  =  P0.2   XOR   P0.3
        /*
        0 -> 0 + 0
        1 -> 0 + 1
        1 -> 1 + 0
        0 -> 1 + 1
        */
        //P1_5 = (P0_2 & !P0_3) | (!P0_2 & P0_3);

        //  9. Setze in C-Code um:   X  =  NOT  ( (  A  OR  C  )  AND  (  NOT  ( A )  OR  D ) )
        //P1_0 = X(P0_4, P0_5, P0_6);

        // 10. Setze in C-Code um:   Y  =   NOT (A)    AND   C   AND   NOT (D)
        //P1_1 = Y(P0_4, P0_5, P0_6);

        // 11. Ein Motor dürfe starten,  wenn  der Handschalter, der Fussschalter oder beide gedrückt werden.
        //P1_2 = P0_1 | P0_0;

        // 12. Bei  zwei  Endschaltern ist eine Störung zu melden, wenn beide gleichzeitig betätigt sind.
        //P1_3 = P0_2 & P0_3;

        // 13.     Realisiere die Funktion X  gemäss  Wahrheitstabelle !
        //P1_0 = X_13(P0_0, P0_1);

        // 14.     Realisiere die Funktion Y gemäss  Wahrheitstabelle !
        //P1_0 = Y_14(P0_0, P0_1, P0_2);

        delay_ms(10);
    }

    P1 = 0;
    return 0;
}
