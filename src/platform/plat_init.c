#include "stm32f7xx_hal.h"
#include "stm32f7xx_hal_msp.h"
#include "uart.h"

void plat_init(void)
{
    HAL_Init();
    SystemClock_Config();
}

void plat_uart_init(void)
{
    nucleo_144_uart_init();
}
