#ifndef __PLATFORM_INIT_H__
#define __PLATFORM_INIT_H__

#include "stm32f7xx.h"
#include "nucleo_configs.h"
#include "uart.h"

void plat_init(void);
void plat_uart_init(void);

#endif