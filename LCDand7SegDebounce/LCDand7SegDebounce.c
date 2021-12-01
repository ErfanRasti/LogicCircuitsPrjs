/**
 * We wanna increase 7segment and LCD number with falling and rising state of keys.
 * @file LCDand7SegDebounce.c
 * @author Erfan Rasti
 * @version 1.0.0
 */

// Setting CPU Frequency
#ifndef F_CPU
#define F_CPU 8000000UL //clock speed is 8MHz
#endif

// Importing Libraries
#include <mega32a.h>
#include <delay.h>
#include <stdio.h>

// Alphanumeric LCD functions
#include <alcd.h>

// Defining Variables
unsigned char digit[10] = {0xfc, 0x60, 0xda, 0xf2, 0x66, 0xb6, 0xbe, 0xe0, 0xfe, 0xf6};
int i = 0;
unsigned char str[16] = "";

interrupt[EXT_INT0] void ext_int0_isr(void)
{

      i++;

      // Restart Digits
      if ((i > 99) || (i < 0))
            i = 0;

      delay_ms(25);
} // end interrupt 0

// External Interrupt 1 service routine
interrupt[EXT_INT1] void ext_int1_isr(void)
{

      i--;

      // Restart Digits
      if ((i > 99) || (i < 0))
            i = 0;

      delay_ms(25);
} // end interrupt 1

void main(void)
{

      // Input/Output Ports initialization
      // Port A initialization
      // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
      DDRA = (0 << DDA7) | (0 << DDA6) | (0 << DDA5) | (0 << DDA4) | (0 << DDA3) | (0 << DDA2) | (0 << DDA1) | (0 << DDA0);
      // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
      PORTA = (0 << PORTA7) | (0 << PORTA6) | (0 << PORTA5) | (0 << PORTA4) | (0 << PORTA3) | (0 << PORTA2) | (0 << PORTA1) | (0 << PORTA0);

      // Port B initialization
      // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
      DDRB = (1 << DDB7) | (1 << DDB6) | (1 << DDB5) | (1 << DDB4) | (1 << DDB3) | (1 << DDB2) | (1 << DDB1) | (1 << DDB0);
      // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
      PORTB = (0 << PORTB7) | (0 << PORTB6) | (0 << PORTB5) | (0 << PORTB4) | (0 << PORTB3) | (0 << PORTB2) | (0 << PORTB1) | (0 << PORTB0);

      // Port C initialization
      // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=Out Bit0=Out
      DDRC = (0 << DDC7) | (0 << DDC6) | (0 << DDC5) | (0 << DDC4) | (0 << DDC3) | (0 << DDC2) | (1 << DDC1) | (1 << DDC0);
      // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=0 Bit0=0
      PORTC = (0 << PORTC7) | (0 << PORTC6) | (0 << PORTC5) | (0 << PORTC4) | (0 << PORTC3) | (0 << PORTC2) | (0 << PORTC1) | (0 << PORTC0);

      // Port D initialization
      // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
      DDRD = (0 << DDD7) | (0 << DDD6) | (0 << DDD5) | (0 << DDD4) | (0 << DDD3) | (0 << DDD2) | (0 << DDD1) | (0 << DDD0);
      // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
      PORTD = (0 << PORTD7) | (0 << PORTD6) | (0 << PORTD5) | (0 << PORTD4) | (0 << PORTD3) | (0 << PORTD2) | (0 << PORTD1) | (0 << PORTD0);

      // External Interrupt(s) initialization
      // INT0: On
      // INT0 Mode: Rising Edge
      // INT1: On
      // INT1 Mode: Falling Edge
      // INT2: Off
      GICR |= (1 << INT1) | (1 << INT0) | (0 << INT2);
      MCUCR = (1 << ISC11) | (0 << ISC10) | (1 << ISC01) | (1 << ISC00);
      MCUCSR = (0 << ISC2);
      GIFR = (1 << INTF1) | (1 << INTF0) | (0 << INTF2);

      // Alphanumeric LCD initialization
      // Connections are specified in the
      // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
      // RS - PORTA Bit 0
      // RD - PORTA Bit 1
      // EN - PORTA Bit 2
      // D4 - PORTA Bit 4
      // D5 - PORTA Bit 5
      // D6 - PORTA Bit 6
      // D7 - PORTA Bit 7
      // Characters/line: 16
      lcd_init(16);

// Global enable interrupts
#asm("sei")

      while (1)
      {

            lcd_clear();

            PORTC = 0x02;
            PORTB = digit[i % 10];
            delay_ms(10);

            PORTC = 0x01;
            PORTB = digit[i / 10];
            delay_ms(10);

            sprintf(str, "Number: %d", i);
            lcd_gotoxy(0, 0);
            lcd_puts(str);
            delay_ms(10);

      } // end while
} // end main