#include "stm32f7xx.h"
#include "uart.h"

uint8_t UART_BUFFER[UART_BUFFER_SIZE] = {0};
volatile uint8_t UART_INDEX = 0;

void nucleo_144_uart_init()
{
    //ENABLE UART
    HAL_UART_Init(&uart3);
    //ENABLE THE UART INTERRUPT
    HAL_UART_Receive_IT(&uart3, &UART_BUFFER[UART_INDEX], 1);
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
