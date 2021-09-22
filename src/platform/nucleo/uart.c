#include "nucleo_configs.h"
#include "stm32f7xx_hal.h"
#include "stm32f7xx_hal_uart.h"

#include <stdio.h>
void nucleo_144_uart_init()
{
    HAL_UART_Init(&uart3);
}

void HAL_UART_MspInit(UART_HandleTypeDef* uartHandle)
{

  if(uartHandle->Instance==USART3)
  {
    __HAL_RCC_USART3_CLK_ENABLE();
  
    __HAL_RCC_GPIOD_CLK_ENABLE();

    HAL_GPIO_Init(GPIOD, &uart3_gpio);

    HAL_NVIC_SetPriority(USART3_IRQn, 0, 0);
    HAL_NVIC_EnableIRQ(USART3_IRQn);
  }
}

//redefine putc f
int fputc(int ch, FILE *f){

	HAL_UART_Transmit(&uart3, (uint8_t*)&ch, 1, 100);
	return ch;

}