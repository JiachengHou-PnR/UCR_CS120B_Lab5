/*	Author: Jiacheng Hou
 *	Lab Section: 022
 *	Assignment: Lab 5  Exercise 1
 *	Exercise Description: [optional - include for your own benefit]
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 */
#include <avr/io.h>
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif

int main(void)
{
    /* Insert DDR and PORT initializations */
    // Inputs
    DDRA = 0x00; PORTA = 0xFF;
    // Outputs
    DDRC = 0xFF; PORTC = 0x00;

    /* Insert your solution below */
    unsigned char tmpA; // tmpB;
    unsigned char level, lowFuel;

    while (1) 
    {
        tmpA = ~PINA & 0x0F;
        //tmpB = PINB;

        level = 0;
        lowFuel = 0x00;

        // set lowFuel light
        if (tmpA <= 4)
        {
            lowFuel = 0x01 << 6;
        }

        // set fuel level lights
        switch (tmpA)
        {
        case 15 :
        case 14 :
        case 13 :
            level = level | 0x01;
        case 12 :
        case 11 :
        case 10 :
            level = level | 0x02;
        case 9  :
        case 8  :
        case 7  :
            level = level | 0x04;
        case 6  :
        case 5  :
            level = level | 0x08;
        case 4  :
        case 3  :
            level = level | 0x10;
        case 2  :
        case 1  :
            level = level | 0x20;
            break;
        default:
            break;
        }

        PORTC = level | lowFuel;
    }
    return 1;
}

