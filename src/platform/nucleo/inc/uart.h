#ifndef __UART_H__
#define __UART_H__

#include "nucleo_configs.h"

#define UART_BUFFER_SIZE

extern uint8_t UART_BUFFER[UART_BUFFER_SIZE];
extern volatile uint8_t UART_INDEX ;

void nucleo_144_uart_init(void);

#endif