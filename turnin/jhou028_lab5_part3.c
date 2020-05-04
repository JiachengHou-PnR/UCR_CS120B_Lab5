/*	Author: Jiacheng Hou
 *	Lab Section: 022
 *	Assignment: Lab 5  Exercise 3
 *	Exercise Description: [optional - include for your own benefit]
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 */

// Lab Demo Link: https://drive.google.com/open?id=1wv4o_WON3T8GsLoYYup5Ch-cNC6GFjfq

#include <avr/io.h>
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif

enum States {Start, sq_1_1, sq_1_2, sq_1_3, sq_1_4, 
                    sq_2_1, sq_2_2, sq_2_3, sq_2_4, 
                    sq_3_1, sq_3_2, sq_3_3, sq_3_4, sq_3_5, sq_3_6
            } state;

unsigned char tmpA0;
unsigned char tmpB;

void Tick() {

    switch (state)      // Transitions
    {
    case Start:
        tmpB = 0x10;
        state = sq_1_1;
        break;

    case sq_1_1:
        tmpB = 0x2A;
        state = sq_1_2;
        break;

    case sq_1_2:
        tmpB = ~tmpB;
        state = sq_1_3;
        break;     

    case sq_1_3:
        tmpB = ~tmpB;
        state = sq_1_4;
        break;
        
    case sq_1_4:
        tmpB = ~tmpB;
        state = sq_2_1;
        break;

    case sq_2_1:
        tmpB = 0x33;
        state = sq_2_2;
        break;

    case sq_2_2:
        tmpB = ~tmpB;
        state = sq_2_3;
        break;

    case sq_2_3:
        tmpB = ~tmpB;
        state = sq_2_4;
        break;

    case sq_2_4:
        tmpB = ~tmpB;
        state = sq_3_1;
        break;

    case sq_3_1:
        tmpB = 0x01;
        state = sq_3_2;
        break;

    case sq_3_2:
        tmpB = 0x04;
        state = sq_3_3;
        break;

    case sq_3_3:
        tmpB = 0x09;
        state = sq_3_4;
        break;

    case sq_3_4:
        tmpB = 0x24;
        state = sq_3_5;
        break;

    case sq_3_5:
        tmpB = 0x09;
        state = sq_3_6;
        break;

    case sq_3_6:
        tmpB = 0x24;
        state = sq_1_1;
        break;
        
    
    default:
        state = sq_1_1;
        break;
    }

    switch (state)      // State Actions
    {
    case Start:     break;
    
    case sq_1_1:    break;

    case sq_1_2:    break;

    case sq_1_3:    break;

    case sq_1_4:    break;

    case sq_2_1:    break;
    
    case sq_2_2:    break;

    case sq_2_3:    break;
    
    case sq_2_4:    break;

    case sq_3_1:    break;

    case sq_3_2:    break;

    case sq_3_3:    break;

    case sq_3_4:    break;

    case sq_3_5:    break;

    case sq_3_6:    break;

    default:        break;
    }
}

int main(void) {
    /* Insert DDR and PORT initializations */
    // Inputs
    DDRA = 0x00; PORTA = 0xFF;

    // Outputs
    DDRB = 0xFF; PORTB = 0x00;

    /* Insert your solution below */
    tmpB = 0x00;
    state = Start;

    while (1) {
        tmpA0 =  ~PINA & 0x01;

        Tick();

        PORTB = tmpB & 0x3F;
    }

    return 1;
}