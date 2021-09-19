#include "stm32f7xx_hal.h"
#include "stm32f7xx_hal_msp.h"

void plat_init(void)
{
    HAL_Init();
    SystemClock_Config();
}