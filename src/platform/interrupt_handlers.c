
#include "main.h"
#include "stm32f7xx_it.h"
#include "plat.h"

void NMI_Handler(void)
{

}

void HardFault_Handler(void)
{
  while (1);
}

void MemManage_Handler(void)
{
  while (1);
}

void BusFault_Handler(void)
{
  while (1);
}

void UsageFault_Handler(void)
{
  while (1);
}

void SVC_Handler(void)
{
  while (1);
}

void DebugMon_Handler(void)
{
  while(1);
}

void PendSV_Handler(void)
{
  while(1);
}

void SysTick_Handler(void)
{
  HAL_IncTick();
}

void USART3_IRQHandler(void)
{ 
    HAL_UART_IRQHandler(&uart3);
}