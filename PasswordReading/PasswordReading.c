/**
 * In this code we wanna set a password to control LED, active buzzer and relay.
 * @file PasswordReading.c
 * @author Erfan Rasti
 * @version 1.0.0
 */

// Setting CPU Frequency
#ifndef F_CPU
#define F_CPU 8000000UL //clock speed is 8MHz
#endif

// N is the number of password characters.
#define N 8

// Importing Libraries
#include <mega32a.h>
#include <delay.h>
#include <alcd.h>
#include <stdio.h>

// Prototypes
unsigned char keypadInputtedChar(unsigned int a0, unsigned int a1, unsigned int a2, unsigned int a3);
unsigned int showAndCheckPassword(void);
unsigned int openTheMenu(void);

// Defining Variables
unsigned char digit[10] = {0x3f, 0x06, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x07, 0x7f, 0x6f};
unsigned char true_password[12] = "9823034*";
unsigned int isItCorrect = 1, firstMissionState = 0, menuIndex = 0, isItSelected = 0, SegCounter = 0;
int indexOfPass = -1;
unsigned char passwordCharValue = '';

// External Interrupt 0 service routine
interrupt[EXT_INT0] void ext_int0_isr(void)
{
      menuIndex++;
      delay_us(5);
}

// External Interrupt 1 service routine
interrupt[EXT_INT1] void ext_int1_isr(void)
{
      isItSelected = 1;
}

// External Interrupt 2 service routine
interrupt[EXT_INT2] void ext_int2_isr(void)
{
      passwordCharValue = keypadInputtedChar(PINB .3, PINB .4, PINB .5, PINB .6);
      indexOfPass++;
      delay_ms(10);
}

void main(void)
{
      // Input/Output Ports initialization
      // Port A initialization
      // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
      DDRA = (1 << DDA7) | (1 << DDA6) | (1 << DDA5) | (1 << DDA4) | (1 << DDA3) | (1 << DDA2) | (1 << DDA1) | (1 << DDA0);
      // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
      PORTA = (0 << PORTA7) | (0 << PORTA6) | (0 << PORTA5) | (0 << PORTA4) | (0 << PORTA3) | (0 << PORTA2) | (0 << PORTA1) | (0 << PORTA0);

      // Port B initialization
      // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
      DDRB = (0 << DDB7) | (0 << DDB6) | (0 << DDB5) | (0 << DDB4) | (0 << DDB3) | (0 << DDB2) | (0 << DDB1) | (0 << DDB0);
      // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
      PORTB = (0 << PORTB7) | (0 << PORTB6) | (0 << PORTB5) | (0 << PORTB4) | (0 << PORTB3) | (0 << PORTB2) | (0 << PORTB1) | (0 << PORTB0);

      // Port C initialization
      // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=Out Bit1=Out Bit0=Out
      DDRC = (0 << DDC7) | (0 << DDC6) | (0 << DDC5) | (0 << DDC4) | (0 << DDC3) | (1 << DDC2) | (1 << DDC1) | (1 << DDC0);
      // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=0 Bit1=0 Bit0=0
      PORTC = (0 << PORTC7) | (0 << PORTC6) | (0 << PORTC5) | (0 << PORTC4) | (0 << PORTC3) | (0 << PORTC2) | (0 << PORTC1) | (0 << PORTC0);

      // Port D initialization
      // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
      DDRD = (0 << DDD7) | (0 << DDD6) | (0 << DDD5) | (0 << DDD4) | (0 << DDD3) | (0 << DDD2) | (0 << DDD1) | (0 << DDD0);
      // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
      PORTD = (0 << PORTD7) | (0 << PORTD6) | (0 << PORTD5) | (0 << PORTD4) | (0 << PORTD3) | (0 << PORTD2) | (0 << PORTD1) | (0 << PORTD0);

      // External Interrupt(s) initialization
      // INT0: On
      // INT0 Mode: Falling Edge
      // INT1: On
      // INT1 Mode: Falling Edge
      // INT2: On
      // INT2 Mode: Falling Edge
      GICR |= (1 << INT1) | (1 << INT0) | (1 << INT2);
      MCUCR = (1 << ISC11) | (0 << ISC10) | (1 << ISC01) | (0 << ISC00);
      MCUCSR = (0 << ISC2);
      GIFR = (1 << INTF1) | (1 << INTF0) | (1 << INTF2);

      // Alphanumeric LCD initialization
      // Connections are specified in the
      // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
      // RS - PORTC Bit 7
      // RD - PORTD Bit 0
      // EN - PORTD Bit 1
      // D4 - PORTD Bit 4
      // D5 - PORTD Bit 5
      // D6 - PORTD Bit 6
      // D7 - PORTD Bit 7
      // Characters/line: 16
      lcd_init(16);

// Global enable interrupts
#asm("sei")

      // clear for the first time
      lcd_clear();

      while (1)
      {
            if (firstMissionState)
                  openTheMenu();

            else
                  showAndCheckPassword();
      }

} // end main

// This function opens the menu and allows us to control LED, buzzer, relay and 7 segment.
unsigned int openTheMenu(void)
{
      /**
       * @return
       * menuINdex: Index of menu
       */
      switch (menuIndex % 4)
      {
      case 0:
            lcd_clear();
            lcd_gotoxy(0, 0);
            lcd_puts("1)LED  <=\n2)Buzzer");
            delay_ms(5);

            // is this option selected?
            if (isItSelected)
            {
                  // deselect the key
                  isItSelected = 0;

                  // Activating the LED
                  PORTC .0 = 1;
                  delay_ms(1000);
                  PORTC .0 = 0;
            }

            break;

      case 1:
            lcd_clear();
            lcd_gotoxy(0, 0);
            lcd_puts("1)LED  \n2)Buzzer  <=");
            delay_ms(5);

            // is this option selected?
            if (isItSelected)
            {
                  // deselect the key
                  isItSelected = 0;

                  // Activating the Buzzer
                  PORTC .1 = 1;
                  delay_ms(1000);
                  PORTC .1 = 0;
            }

            break;
      case 2:
            lcd_clear();
            lcd_gotoxy(0, 0);
            lcd_puts("2)Buzzer  \n3)Relay  <=");
            delay_ms(5);

            // is this option selected?
            if (isItSelected)
            {
                  // deselect the key
                  isItSelected = 0;

                  // Activating the Relay
                  PORTC .2 = 1;
                  delay_ms(1000);
                  PORTC .2 = 0;
            }

            break;
      case 3:
            lcd_clear();
            lcd_gotoxy(0, 0);
            lcd_puts("3)Relay \n4)7 Segment <=");
            delay_ms(5);

            // is this option selected?
            if (isItSelected)
            {
                  if (SegCounter <= 9)
                  {
                        // Activating the 7 Segment
                        PORTA = digit[SegCounter];
                        delay_ms(300);
                        SegCounter++;
                  }
                  else
                  {
                        isItSelected = 0;
                        PORTA = 0x00;
                  }
            }

            break;
      }

      return menuIndex + 1;
}

// This function shows the password on LCD and check if the password is correct.
unsigned int showAndCheckPassword(void)
{
      /**
       * @return
       * 1: correct password
       * 0: wrong password
       * 2: no password entered yet
       */
      lcd_gotoxy(0, 0);
      lcd_puts("Password:");
      delay_ms(20);

      // Checking correctly of inputted character
      if ((passwordCharValue != true_password[indexOfPass]) && (0 <= indexOfPass) && (indexOfPass < N))
            isItCorrect = 0;

      // Showing the character on LCD
      lcd_gotoxy(indexOfPass, 1);
      lcd_putchar(passwordCharValue);
      delay_ms(20);

      if (passwordCharValue == 'o')
      {

            lcd_clear();
            delay_ms(10);
            if (isItCorrect && (indexOfPass == N))
            {
                  lcd_gotoxy(0, 0);
                  lcd_puts("Correct");
                  delay_ms(1000);

                  // reseting the values
                  isItCorrect = 1;
                  passwordCharValue ='';
                  indexOfPass = -1;

                  // first mission succeed
                  firstMissionState = 1;

                  return 1;
            }
            else
            {
                  lcd_gotoxy(0, 0);
                  lcd_puts("Wrong");
                  delay_ms(500);

                  // reseting the values for trying again
                  isItCorrect = 1;
                  passwordCharValue = '';
                  indexOfPass = -1;

                  return 0;
            }
      }

      return 2;
}

// This function converts the keypad binary numbers to the real char value.
unsigned char keypadInputtedChar(unsigned int a0, unsigned int a1, unsigned int a2, unsigned int a3)
{
      /**
       * @param
       * a0: first binary number
       * a1: second binary number
       * a2: third binary number
       * a3: fourth binary number
       * @return
       * the real char value
      */
      unsigned int charIndex = a0 * 1 + a1 * 2 + a2 * 4 + a3 * 8;
      unsigned char realChar[16] = {'7', '8', '9', '%', '4', '5', '6', '*', '1', '2', '3', '-', 'o', '0', '=', '+'};
      return realChar[charIndex];
}
