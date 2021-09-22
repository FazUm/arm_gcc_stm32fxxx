#include "stm32f7xx_hal.h"
#include "stm32f7xx_hal_msp.h"
#include "stm32f7xx_hal_uart.h"
#include "plat_configs.h"

void plat_init(void)
{
    HAL_Init();
    SystemClock_Config();
}

void plat_uart_init(void)
{
   HAL_UART_Init(&uart3);

    __HAL_RCC_USART3_CLK_ENABLE();
  
    __HAL_RCC_GPIOD_CLK_ENABLE();
  
    HAL_GPIO_Init(GPIOD, &uart3_gpio);

}