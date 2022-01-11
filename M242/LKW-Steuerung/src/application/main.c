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
#define gangBackwards   0
#define gangForwards    1


/* VARIABLEN *
 * Zustände */
unsigned char zPower, zHupe, zSchein, zBliner, zRichtung, zTempo, zGang = 0;
/* Eingabe */
unsigned char ePower, eTempo, eRichtungL, eRichtungR, eBlinker, eGang, eHupe, eSchein = 0;
/* Ausgabe */
unsigned char aPower, aHupe, aSchein, aBlinker, aRichtung, aTempo, aGang = 0;
/* Incrementor */
bool iTempo = true;
/* Blink-Safes */
bool iRückBlinkend = false;
/* Blink-Count */
int iRückBlinked = 0;
/* Blinker */
int blinkerCount = 0;
int blinkerMax = 10;
/* Scheinwerfer */
int scheinCount = 0;
int scheinMax = 10;

/* FUNKTIONEN   *
 * VERARBEITUNG *
 * Tempo        */
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

/* FUNKTIONEN   *
 * AUSGABE      *
 * Gang         */
int vAusgabeGang(int gang, int speed) {
    switch(gang) {
        case gangBackwards:
            if (speed == tempoNull){
                return false;
            } else {
                return true;
            }
        case gangForwards:
            return false;
        default:
            return false;

    }
}

/* Tempo */
int vAusgabeTempo(int tempo) {
    switch (tempo) {
        case tempoNull:
            P1_5 = 0;
            P1_6 = 0;
            break;
        case tempoLangsam:
            P1_5 = 0;
            P1_6 = 1;
            break;
        case tempoNormal:
            P1_5 = 1;
            P1_6 = 0;
            break;
        case tempoSchnell:
            P1_5 = 1;
            P1_6 = 1;
            break;
        default:
            break;
    }
    return 0;
}

/* Steuerung */
void vAusgabeSteuerung(int richtung) {
    switch (richtung)
    {
    case richtungGerade:
        P1_3 = 0;
        P1_4 = 0;
        break;
    case richtungLinks:
        P1_3 = 0;
        P1_4 = 1;
        break;
    case richtungRechts:
        P1_3 = 1;
        P1_4 = 0;
        break;
    default:
        break;
    }
}

/* Blinker */
int vAusgabeBlinker(int blinker, int count) {
    switch(blinker) {
        case blinkerNull:
            P1_1 = 0;
            return count;
        case blinkerLinks:
            P1_1 = 1;
            return count;
        case blinkerRechts:
            if (count <= 5) {
                P1_1 = 1;
                count++;
            } else {
                P1_1 = 0;
                count++;
                if (count > blinkerMax) {
                    count = 0;
                }
            }
            return count;
        default:
            return count;
    }
}

/* Scheinwerfer */
int vAusgabeSchein(int schein, int count){
    switch(schein) {
        case scheinNull:
            P1_2 = 0;
            return count;
        case scheinNormal:
            if (count <= 5) {
                P1_2 = 1;
                count++;
            } else {
                P1_2 = 0;
                count++;
                if (count > scheinMax) {
                    count = 0;
                }
            }
            return count;
        case scheinHell:
            P1_2 = 1;
            return count;
        default:
            return count;
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
        eBlinker = P0_1;
        eSchein = P0_2;
        eHupe = P0_0;

        /* VERARBETIUNG */
        /* Power */
        if (ePower) {
            aPower = powerON;
            /* Gang */
            aGang = eGang;
            /* Tempo */
            aTempo = zTempo;
            if (eTempo & iTempo) {
                iTempo = false;
                int zNewTempo;
                if (aGang == gangForwards & zTempo >= tempoSchnell) {
                    zNewTempo = tempoNull;
                } else if (aGang == gangBackwards & zTempo >= tempoLangsam) {
                    zNewTempo = tempoNull;
                } else {
                    zNewTempo = zTempo + 1;
                }
                aTempo = vTempo(zTempo, zNewTempo, aGang);
                zTempo = aTempo;
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
        if (aPower) {
            iRückBlinkend = vAusgabeGang(aGang, aTempo);
            if (iRückBlinkend) {
                if (iRückBlinked < 100) {
                    P1_7 = 1;
                    iRückBlinked++;
                } else {
                    P1_7 = 0;
                    iRückBlinked++;
                    if (iRückBlinked < 200){
                        iRückBlinked = 0;
                    }
                }
            }
            vAusgabeTempo(aTempo);
            vAusgabeSteuerung(aRichtung);
            blinkerCount = vAusgabeBlinker(aBlinker, blinkerCount);
            scheinCount = vAusgabeSchein(aSchein, scheinCount);
            P1_0 = aHupe;
        } else {
            P1 = 0;
        }

        delay_ms( 10 );
    }
}
