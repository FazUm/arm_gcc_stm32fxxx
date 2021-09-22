#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include "main.h"

#define CTREE

void leds_blink(){
  static char state = 0;

  BSP_LED_Toggle(state);

  state = (++state & 0x03);

}

int main(void)
{
  plat_init();
  // plat_uart_init();

  BSP_LED_Init(LED_GREEN);
  BSP_LED_Init(LED_BLUE);
  BSP_LED_Init(LED_RED);

  // char *msg = "Hello world!\n\r";
 
  // HAL_UART_Transmit(&uart3, (uint8_t*)msg, strlen(msg), 0xFFFF);
  while (1)
  {

#ifndef CTREE
  BSP_LED_Toggle(LED_GREEN);
#else
  leds_blink();
#endif
  HAL_Delay(500);

  }

}

