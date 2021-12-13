//-----------------------------------------------------------------------
//State Transition Diagramme Implementation in C
//Dieses Beispiel zeigt eine Links-,Rechts-, und Stoppsteuerung eines Motors anhand der LED-Anzeigen.
//Schalter 0 stoppt den Motor (alle LED 0),Schalter 1 aktiviert den Linkslauf (LED 0)
//Schalter 1 aktiviert den Rechtslauf (LED 1)

#include "../system/lib/libDYPS.h"					// Controller
//Zustände definieren
#define stStopp	0					                //Motor Stopp
#define stLinks	1					                //Motor Linkslauf
#define stRechts	2					            //Motor Rechtslauf
unsigned char Ein, Zustand, Aus;					// Eingabe- und Zustand
//----------------------------------------------------------------------------------------------
int main(void)
{
     Zustand=stStopp;						        //Startzustand Motor gestoppt
     initP0P1();							        // P0,P1 auf Touchscreen ON
     initTouchP0P1( "mp3" );
     P1=0;							                //Ausgangslage definieren
     while(1) {							            //Endlosschleife
       Ein = P0;							        //Schalter einlesen (EVA-Prinzip)
       switch(Zustand) {						    //Zustandsauswahl =>    Stopp, Rechts, Links
            case stStopp:
                switch (Ein&0x07) {					//Zustandsauswahl Schalter 1 oder 2
                        case 2:
                            Aus = stLinks;			//Nur Schalter 1 ON => Linkslauf
                            Zustand = stLinks;
                            break;				    //Zustandswechsel
                        case 4:
                            Aus = stRechts;		    //Nur Schalter 2 ON => Rechtslauf
                            Zustand= stRechts;		//Zustandswechsel
                            break;
                    }
                break;				                //case stStopp abschliessen
           case stRechts:
               if (Ein&0x01) {					    //Falls Schalter 0 ON => Stopp
                    Aus=0;				            //Motor stoppen
                    Zustand = stStopp;			    //Zustandswechsel
                }
                break;					            //case stRechts abschliessen

           case stLinks:
               if (Ein&0x01){				        //Falls Schalter 0 ON => Stopp
                    Aus =0;				            //Motor stoppen
                    Zustand=stStopp;			    //Zustandswechsel
                }
                break;					            //case stLinks abschliessen
        }
    P1=Aus;							                // Ausgabe auf Port (EVA-Prinzip)
    delay_ms( 100 );
    }
}


