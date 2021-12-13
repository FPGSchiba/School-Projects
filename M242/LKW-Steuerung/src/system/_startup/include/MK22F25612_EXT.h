/*
 *   This file is part of the DYPS-ONE
 *
 *   Copyright (C) 2018-today:
 *       GASSMANN TECHNOLOGIES AG, Roman Gassmann, roman.gassmann@gate-ag.ch
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program.  If not, see http://www.gnu.org/licenses/gpl-3.0
 *
 */

/**
 * @file MK22F25612_EXT.h
 * @version 1.0
 * @date 2015-07-19
 * @brief Extensions of Headerfile for ARM - Kinetis Processors
 */


#if !defined(MK22F25612_EXT_H_)
#define MK22F25612_EXT_H_                               /**< Symbol preventing repeated inclusion */

#include "definitions.h"
#include "../../config.h"
    /**
     * @enum    uC_Ports
     *
     * @brief   Values that represent uC_Ports.
    **/
    typedef enum {
        uC_PortA = 0x00,
        uC_PortB = 0x01,
        uC_PortC = 0x02,
        uC_PortD = 0x03,
        uC_PortE = 0x04
    } uC_Ports;

    #define PORTA_PIN(PinNr)    uC_PortA, PinNr
    #define PORTB_PIN(PinNr)    uC_PortB, PinNr
    #define PORTC_PIN(PinNr)    uC_PortC, PinNr
    #define PORTD_PIN(PinNr)    uC_PortD, PinNr
    #define PORTE_PIN(PinNr)    uC_PortE, PinNr

    #define __PIN_ALT(Port, PinNr, AltFkt)    Port, PinNr, AltFkt
    #define PIN_ALT(PortPin, AltFkt)    __PIN_ALT(PortPin, AltFkt)

    #define __GPIO(Port, PinNr)               Port, PinNr, 1, 0
    #define GPIO(PortPin)   __GPIO(PortPin)

    #define __GPIO_INV(Port, PinNr)           Port, PinNr, 1, -1
    #define GPIO_INV(PortPin)   __GPIO_INV(PortPin)

    #define PORT_TYPE_OF(Port)     ((PORT_Type *)(PORTA_BASE + Port*(PORTB_BASE-PORTA_BASE)))
    #define GPIO_TYPE_OF(Port)     ((GPIO_Type *)(PTA_BASE+Port*(PTB_BASE-PTA_BASE)))

    #define USE_PORTA       SIM->SCGC5 |= SIM_SCGC5_PORTA_MASK
    #define USE_PORTB       SIM->SCGC5 |= SIM_SCGC5_PORTB_MASK
    #define USE_PORTC       SIM->SCGC5 |= SIM_SCGC5_PORTC_MASK
    #define USE_PORTD       SIM->SCGC5 |= SIM_SCGC5_PORTD_MASK
    #define USE_PORTE       SIM->SCGC5 |= SIM_SCGC5_PORTE_MASK

    static __INLINE void INIT_ALT_PIN_EXT(uC_Ports Port, uint8_t PinNr, uint8_t AltFkt, uint32_t opt) {
        PORT_TYPE_OF(Port)->PCR[PinNr] = PORT_PCR_MUX(AltFkt) | (opt & ~PORT_PCR_MUX_MASK);
    }

    static __INLINE void INIT_ALT_PIN(uC_Ports Port, uint8_t PinNr, uint8_t AltFkt) {
        INIT_ALT_PIN_EXT( Port , PinNr , AltFkt , 0 );
    }

    static __INLINE void INIT_OUTPUT(uC_Ports Port, uint8_t PinNr, uint8_t AltFkt, bool Inv) {
        PORT_TYPE_OF(Port)->PCR[PinNr] = PORT_PCR_MUX(AltFkt) | PORT_PCR_SRE_MASK;
        GPIO_TYPE_OF(Port)->PDDR |= 1 << PinNr; //Set Output
    }

    static __INLINE void INIT_OUTPUT_POWER(uC_Ports Port, uint8_t PinNr, uint8_t AltFkt, bool Inv) {
        PORT_TYPE_OF(Port)->PCR[PinNr] = PORT_PCR_MUX(AltFkt) | PORT_PCR_DSE_MASK | PORT_PCR_SRE_MASK;
        GPIO_TYPE_OF(Port)->PDDR |= 1 << PinNr; //Set Output
    }

    static __INLINE void INIT_OUTPUT_POWER_FAST(uC_Ports Port, uint8_t PinNr, uint8_t AltFkt, bool Inv) {
        PORT_TYPE_OF(Port)->PCR[PinNr] = PORT_PCR_MUX(AltFkt) | PORT_PCR_DSE_MASK;
        GPIO_TYPE_OF(Port)->PDDR |= 1 << PinNr; //Set Output
    }

    static __INLINE void INIT_INPUT(uC_Ports Port, uint8_t PinNr, uint8_t AltFkt, bool Inv) {
        PORT_TYPE_OF(Port)->PCR[PinNr] = PORT_PCR_MUX(AltFkt);
        GPIO_TYPE_OF(Port)->PDDR &= ~(1 << PinNr); //Set Input
    }

    static __INLINE void INIT_INPUT_PULLUP(uC_Ports Port, uint8_t PinNr, uint8_t AltFkt, bool Inv) {
        PORT_TYPE_OF(Port)->PCR[PinNr] = PORT_PCR_MUX(AltFkt) | PORT_PCR_PE_MASK | PORT_PCR_PS_MASK;
        GPIO_TYPE_OF(Port)->PDDR &= ~(1 << PinNr); //Set Input
    }

    static __INLINE void INIT_INPUT_PULLDOWN(uC_Ports Port, uint8_t PinNr, uint8_t AltFkt, bool Inv) {
        PORT_TYPE_OF(Port)->PCR[PinNr] = PORT_PCR_MUX(AltFkt) | PORT_PCR_PE_MASK;
        GPIO_TYPE_OF(Port)->PDDR &= ~(1 << PinNr); //Set Input
    }


    #define POSITION_ON      -1
    #define POSITION_OFF     0

    static __INLINE void OUTPUT_TOGGLE(uC_Ports Port, uint8_t PinNr, uint8_t AltFkt, bool Inv) {
        GPIO_TYPE_OF(Port)->PTOR = 1 << PinNr; //Toggle
    }

    static __INLINE void OUTPUT_SET(uC_Ports Port, uint8_t PinNr, uint8_t AltFkt, bool Inv, bool OnOff) {
        GPIO_TYPE_OF(Port)->PCOR = ((!(OnOff ^ Inv)) & 1) << PinNr;
        GPIO_TYPE_OF(Port)->PSOR = ((OnOff ^ Inv) & 1) << PinNr;
    }

    static __INLINE bool INPUT_GET(uC_Ports Port, uint8_t PinNr, uint8_t AltFkt, bool Inv) {
        return (GPIO_TYPE_OF(Port)->PDIR >> PinNr  ^ Inv) & 1 ;
    }
//#if (CPU_TYPE == MK22FN256M12)

    #define		PIN_A0		PORTA_PIN(0)
    #define		PIN_A1		PORTA_PIN(1)
    #define		PIN_A2		PORTA_PIN(2)
    #define		PIN_A3		PORTA_PIN(3)
    #define		PIN_A4		PORTA_PIN(4)
    #define		PIN_A5		PORTA_PIN(5)
//    #define		PIN_A6		PORTA_PIN(6)
//    #define		PIN_A7		PORTA_PIN(7)
//    #define		PIN_A8		PORTA_PIN(8)
//    #define		PIN_A9		PORTA_PIN(9)
//    #define		PIN_A10		PORTA_PIN(10)
//    #define		PIN_A11		PORTA_PIN(11)
    #define		PIN_A12		PORTA_PIN(12)
    #define		PIN_A13		PORTA_PIN(13)
    #define		PIN_A14		PORTA_PIN(14)
    #define		PIN_A15		PORTA_PIN(15)
    #define		PIN_A16		PORTA_PIN(16)
    #define		PIN_A17		PORTA_PIN(17)
    #define		PIN_A18		PORTA_PIN(18)
    #define		PIN_A19		PORTA_PIN(19)
//    #define		PIN_A20		PORTA_PIN(20)
//    #define		PIN_A21		PORTA_PIN(21)
//    #define		PIN_A22		PORTA_PIN(22)
//    #define		PIN_A23		PORTA_PIN(23)
//    #define		PIN_A24		PORTA_PIN(24)
//    #define		PIN_A25		PORTA_PIN(25)
//    #define		PIN_A26		PORTA_PIN(26)
//    #define		PIN_A27		PORTA_PIN(27)
//    #define		PIN_A28		PORTA_PIN(28)
//    #define		PIN_A29		PORTA_PIN(29)
////    #define		PIN_A30		PORTA_PIN(30)
//    #define		PIN_A31		PORTA_PIN(31)

    #define		PIN_B0		PORTB_PIN(0)
    #define		PIN_B1		PORTB_PIN(1)
    #define		PIN_B2		PORTB_PIN(2)
    #define		PIN_B3		PORTB_PIN(3)
//    #define		PIN_B4		PORTB_PIN(4)
//    #define		PIN_B5		PORTB_PIN(5)
//    #define		PIN_B6		PORTB_PIN(6)
//    #define		PIN_B7		PORTB_PIN(7)
//    #define		PIN_B8		PORTB_PIN(8)
    #define		PIN_B9		PORTB_PIN(9)
    #define		PIN_B10		PORTB_PIN(10)
    #define		PIN_B11		PORTB_PIN(11)
//    #define		PIN_B12		PORTB_PIN(12)
//    #define		PIN_B13		PORTB_PIN(13)
//    #define		PIN_B14		PORTB_PIN(14)
//    #define		PIN_B15		PORTB_PIN(15)
    #define		PIN_B16		PORTB_PIN(16)
    #define		PIN_B17		PORTB_PIN(17)
    #define		PIN_B18		PORTB_PIN(18)
    #define		PIN_B19		PORTB_PIN(19)
    #define		PIN_B20		PORTB_PIN(20)
    #define		PIN_B21		PORTB_PIN(21)
    #define		PIN_B22		PORTB_PIN(22)
    #define		PIN_B23		PORTB_PIN(23)
//    #define		PIN_B24		PORTB_PIN(24)
//    #define		PIN_B25		PORTB_PIN(25)
//    #define		PIN_B26		PORTB_PIN(26)
//    #define		PIN_B27		PORTB_PIN(27)
//    #define		PIN_B28		PORTB_PIN(28)
//    #define		PIN_B29		PORTB_PIN(29)
//    #define		PIN_B30		PORTB_PIN(30)
//    #define		PIN_B31		PORTB_PIN(31)


    #define		PIN_C0		PORTC_PIN(0)
    #define		PIN_C1		PORTC_PIN(1)
    #define		PIN_C2		PORTC_PIN(2)
    #define		PIN_C3		PORTC_PIN(3)
    #define		PIN_C4		PORTC_PIN(4)
    #define		PIN_C5		PORTC_PIN(5)
    #define		PIN_C6		PORTC_PIN(6)
    #define		PIN_C7		PORTC_PIN(7)
    #define		PIN_C8		PORTC_PIN(8)
    #define		PIN_C9		PORTC_PIN(9)
    #define		PIN_C10		PORTC_PIN(10)
    #define		PIN_C11		PORTC_PIN(11)
    #define		PIN_C12		PORTC_PIN(12)
    #define		PIN_C13		PORTC_PIN(13)
    #define		PIN_C14		PORTC_PIN(14)
    #define		PIN_C15		PORTC_PIN(15)
    #define		PIN_C16		PORTC_PIN(16)
    #define		PIN_C17		PORTC_PIN(17)
    #define		PIN_C18		PORTC_PIN(18)
//    #define		PIN_C19		PORTC_PIN(19)
//    #define		PIN_C20		PORTC_PIN(20)
//    #define		PIN_C21		PORTC_PIN(21)
//    #define		PIN_C22		PORTC_PIN(22)
//    #define		PIN_C23		PORTC_PIN(23)
//    #define		PIN_C24		PORTC_PIN(24)
//    #define		PIN_C25		PORTC_PIN(25)
//    #define		PIN_C26		PORTC_PIN(26)
//    #define		PIN_C27		PORTC_PIN(27)
//    #define		PIN_C28		PORTC_PIN(28)
//    #define		PIN_C29		PORTC_PIN(29)
//    #define		PIN_C30		PORTC_PIN(30)
//    #define		PIN_C31		PORTC_PIN(31)


    #define		PIN_D0		PORTD_PIN(0)
    #define		PIN_D1		PORTD_PIN(1)
    #define		PIN_D2		PORTD_PIN(2)
    #define		PIN_D3		PORTD_PIN(3)
    #define		PIN_D4		PORTD_PIN(4)
    #define		PIN_D5		PORTD_PIN(5)
    #define		PIN_D6		PORTD_PIN(6)
    #define		PIN_D7		PORTD_PIN(7)
//    #define		PIN_D8		PORTD_PIN(8)
//    #define		PIN_D9		PORTD_PIN(9)
//    #define		PIN_D10		PORTD_PIN(10)
//    #define		PIN_D11		PORTD_PIN(11)
//    #define		PIN_D12		PORTD_PIN(12)
//    #define		PIN_D13		PORTD_PIN(13)
//    #define		PIN_D14		PORTD_PIN(14)
//    #define		PIN_D15		PORTD_PIN(15)
//    #define		PIN_D16		PORTD_PIN(16)
//    #define		PIN_D17		PORTD_PIN(17)
//    #define		PIN_D18		PORTD_PIN(18)
//    #define		PIN_D19		PORTD_PIN(19)
//    #define		PIN_D20		PORTD_PIN(20)
//    #define		PIN_D21		PORTD_PIN(21)
//    #define		PIN_D22		PORTD_PIN(22)
//    #define		PIN_D23		PORTD_PIN(23)
//    #define		PIN_D24		PORTD_PIN(24)
//    #define		PIN_D25		PORTD_PIN(25)
//    #define		PIN_D26		PORTD_PIN(26)
//    #define		PIN_D27		PORTD_PIN(27)
//    #define		PIN_D28		PORTD_PIN(28)
//    #define		PIN_D29		PORTD_PIN(29)
//    #define		PIN_D30		PORTD_PIN(30)
//    #define		PIN_D31		PORTD_PIN(31)



    #define		PIN_E0		PORTE_PIN(0)
    #define		PIN_E1		PORTE_PIN(1)
    #define		PIN_E2		PORTE_PIN(2)
    #define		PIN_E3		PORTE_PIN(3)
    #define		PIN_E4		PORTE_PIN(4)
    #define		PIN_E5		PORTE_PIN(5)
    #define		PIN_E6		PORTE_PIN(6)
//    #define		PIN_E7		PORTE_PIN(7)
//    #define		PIN_E8		PORTE_PIN(8)
//    #define		PIN_E9		PORTE_PIN(9)
//    #define		PIN_E10		PORTE_PIN(10)
//    #define		PIN_E11		PORTE_PIN(11)
//    #define		PIN_E12		PORTE_PIN(12)
//    #define		PIN_E13		PORTE_PIN(13)
//    #define		PIN_E14		PORTE_PIN(14)
//    #define		PIN_E15		PORTE_PIN(15)
//    #define		PIN_E16		PORTE_PIN(16)
//    #define		PIN_E17		PORTE_PIN(17)
//    #define		PIN_E18		PORTE_PIN(18)
//    #define		PIN_E19		PORTE_PIN(19)
//    #define		PIN_E20		PORTE_PIN(20)
//    #define		PIN_E21		PORTE_PIN(21)
//    #define		PIN_E22		PORTE_PIN(22)
//    #define		PIN_E23		PORTE_PIN(23)
    #define		PIN_E24		PORTE_PIN(24)
    #define		PIN_E25		PORTE_PIN(25)
    #define		PIN_E26		PORTE_PIN(26)
//    #define		PIN_E27		PORTE_PIN(27)
//    #define		PIN_E28		PORTE_PIN(28)
//    #define		PIN_E29		PORTE_PIN(29)
//    #define		PIN_E30		PORTE_PIN(30)
//    #define		PIN_E31		PORTE_PIN(31)


#define CPU_HAS_UART0
    #define UART0_RX_PIN_A1     PIN_ALT( PIN_A1 , 2 )
    #define UART0_TX_PIN_A2     PIN_ALT( PIN_A2 , 2 )

#define CPU_HAS_SPI1
    #define SPI1_PCS1_PIN_E0    PIN_ALT( PIN_E0 , 2 )
    #define SPI1_MOSI_PIN_E1    PIN_ALT( PIN_E1 , 2 )
    #define SPI1_SCK_PIN_E2     PIN_ALT( PIN_E2 , 2 )
    #define SPI1_MISO_PIN_E3    PIN_ALT( PIN_E3 , 2 )
    #define SPI1_PCS0_PIN_E4    PIN_ALT( PIN_E4 , 2 )
    #define SPI1_PCS2_PIN_E5    PIN_ALT( PIN_E5 , 2 )

    #define SPI0_MOSI_PIN_A16    PIN_ALT( PIN_A16 , 2 )
    #define SPI0_MISO_PIN_A17    PIN_ALT( PIN_A17 , 2 )
    #define SPI0_SCK_PIN_A15     PIN_ALT( PIN_A15 , 2 )
    #define SPI0_CS0_PIN_A14     PIN_ALT( PIN_A14 , 2 )
    #define SPI0_CS1_PIN_A13     PIN_ALT( PIN_A13 , 1 )
    #define SPI0_CS2_PIN_A12     PIN_ALT( PIN_A12 , 1 )
    #define SPI0_CS4_PIN_C0      PIN_ALT( PIN_C0 , 2 )

#define CPU_HAS_FTM0
    #define FTM0_CH3_PIN_C3     PIN_ALT( PIN_C3 , 4 )
    #define FTM0_CH7_PIN_D7     PIN_ALT( PIN_D7 , 4 )


//#else
//    #error "MK22F25612_EXT.h PIN-Configuration for this CPU-Package not defined! Please define!"
//#endif

#endif  /* #if !defined(MK22F25612_EXT_H_) */

/* MK22F25612_EXT.h, eof. */
