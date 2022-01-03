/*
 *    Authors: Anne-Catherine Straub & Jann Erhardt
 *    Projetct-Name: LKW-Steuerung
 **************************************************************
 *    Chages:
 *     - Init (03.01.2021)
 *       * Implemented Zustände
 *       * Implemented Varialbes
 *       * Implemented Eingabe
 *       * Implemented Verarbeitung
 **************************************************************
 */

/* IMPORT */
#include "../system/lib/libDYPS.h"

/* ZUSTÄNDE
 * Tempi */
#define tempoNull       0
#define tempoLangsam    1
#define tempoNormal     2
#define tempoSchnell    3

/* Richtung */
#define richtungGerade  0
#define richtungLinks   1
#define richtungRechts  2

/* Bilnker */
#define blinkerNull     0
#define blinkerLinks    1
#define blinkerRechts   2

/* Scheinwerfer */
#define scheinNull      0
#define scheinNormal    1
#define scheinHell      2

/* Hupe */
#define hupeNull        0
#define hupeHupt        1

/* Power */
#define powerOFF        0
#define powerON         1

/* Gang */
#define gangBackwards       0
#define gangForwards        1


/* VARIABLEN *
 * Zustände */
unsigned char zPower, zHupe, zSchein, zBliner, zRichtung, zTempo, zGang = 0;
/* Eingabe */
unsigned char ePower, eTempo, eRichtungL, eRichtungR, eBlinker, eGang, eHupe, eSchein = 0;
/* Ausgabe */
unsigned char aPower, aHupe, aSchein, aBlinker, aRichtung, aTempo, aGang = 0;
/* Incrementor */
bool iTempo = true;

/* FUNKTIONEN *
 * Tempo */
int vTempo (int zTempo, int eTempo, int zGang) {
    switch (eTempo) {
        case tempoNull:
            return eTempo;
        case tempoLangsam:
            return eTempo;
        case tempoNormal:
            if (zGang != gangForwards){
                return eTempo;
            } else {
                return zTempo;
            }
        case tempoSchnell:
            if (zGang != gangForwards){
                return eTempo;
            } else {
                return zTempo;
            }
        default:
            return tempoNull;
    }
}

/* Richtung */
int vRichtung(int RL, int RR) {
    if (RL & !RR) {
        return richtungLinks;
    } else if (RR & !RL) {
        return richtungRechts;
    } else {
        return richtungGerade;
    }
}

/* Blinker */
int vBlinker(int blinker, int richtung) {
    if (blinker) {
        switch (richtung) {
            case richtungGerade:
                return blinkerNull;
            case richtungLinks:
                return blinkerLinks;
            case richtungRechts:
                return blinkerRechts;
            default:
                return blinkerNull;
        }
    } else {
        return blinkerNull;
    }
}

/* Main-Funktion */
int main( void ) {
    initP0P1();             // Initialiserung

    while ( 1 ) {
        /* EINGABE */
        ePower = P0_7;
        eGang = P0_6;
        eTempo = P0_5;
        eRichtungL = P0_4;
        eRichtungR = P0_3;
        eBlinker = P0_2;
        eSchein = P0_1;
        eHupe = P0_0;

        /* VERARBETIUNG */
        /* Power */
        if (ePower) {
            aPower = powerON;
            /* Gang */
            aGang = eGang;
            if(aGang == gangBackwards) {
                // Rückwärtslicht & Ton
            }
            /* Tempo */
            if (eTempo && iTempo) {
                iTempo = false;
                int zNewTempo;
                if (zTempo >= tempoSchnell) {
                    zNewTempo = tempoNull;
                } else {
                    zNewTempo = zTempo + 1;
                }
                aTempo = vTempo(zTempo, zNewTempo, aGang);
            } else if (!eTempo) {
                iTempo = true;
            }
            /* Richtung */
            aRichtung = vRichtung(eRichtungL, eRichtungR);
            /* Blinker */
            aBlinker = vBlinker(eBlinker, aRichtung);
            /* Schein */
            aSchein = eSchein ? scheinHell : scheinNormal;
            /* Hupe */
            aHupe = eHupe ? hupeHupt : hupeNull;
        } else {
            aPower = powerOFF;
        }

        /* AUSGABE */
        
        delay_ms( 10 );
    }
}
