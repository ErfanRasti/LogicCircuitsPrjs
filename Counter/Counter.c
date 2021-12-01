/**
 * We wanna make a two digits counter with 7-segment and lcd.
 * @file Counter.c
 * @author Erfan Rasti
 * @version 1.0.0
*/

// Setting CPU Frequency
#ifndef F_CPU
#define F_CPU 8000000UL //clock speed is 8MHz
#endif

// Importing Libraries
#include <mega32.h>
#include <alcd.h>
#include <stdio.h>
#include <delay.h>

// Defining Variables
unsigned char digit[10] = {0xfc, 0x60, 0xda, 0xf2, 0x66, 0xb6, 0xbe, 0xe0, 0xfe, 0xf6};
unsigned int i = 0;
unsigned char lcdValue[16];

void main(void) // main starts
{

      // Setting Data Direction Registers
      // PORTA = input, PORTB = output, PORTC = input (but PORTC.0 = output, PORTC.1 = output), PORTD = input
      DDRA = DDRD = 0x00;
      DDRB = 0xff;
      DDRC = 0x03;


          // Initialization of Port Resgisters
          // PORTC.2 = +5v, o.w. = 0v
          PORTA = PORTB = PORTD = 0x00;
      PORTC = 0x04;

      // Alphanumerical LCD 16 * 2 Initialization
      lcd_init(16);

      while (1)
      {

            // Restart Digits
            if (i > 99)
            {
                  i = 0;
                  lcd_clear();
            }

            if (!(PINC & (1 << 2)))
            {
                  while (!(PINC & (1 << 2)))
                        ;

                  i++;
            }
            else
            {
                  sprintf(lcdValue, "Value = %d", i);
                  lcd_gotoxy(0, 0);
                  lcd_puts(lcdValue);

                  PORTC = 0x02;
                  PORTB = digit[i % 10];
                  delay_ms(10);

                  PORTC = 0x01;
                  PORTB = digit[i / 10];
                  delay_ms(10);
            }

      } // while loop ends

} // main ends
