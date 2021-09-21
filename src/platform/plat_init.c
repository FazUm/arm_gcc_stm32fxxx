#include "stm32f7xx_hal.h"
#include "stm32f7xx_hal_msp.h"
#include "stm32f7xx_hal_uart.h"

void plat_init(void)
{
    HAL_Init();
    SystemClock_Config();
}

void plat_uart_init(void)
{
    //chamar a hal uart init com a config da estrutura pedida

}