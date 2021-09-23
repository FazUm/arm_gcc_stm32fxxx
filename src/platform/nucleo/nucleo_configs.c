#include "nucleo_configs.h"

#define STLK_RX_Pin GPIO_PIN_8
#define STLK_TX_Pin GPIO_PIN_9


//UART3 configuration
UART_HandleTypeDef uart3 = {

    .Instance = USART3,
    .Init = {
        .BaudRate = 115200,
        .WordLength = UART_WORDLENGTH_8B,
        .StopBits = UART_STOPBITS_1,
        .Parity = UART_PARITY_NONE,
        .Mode = UART_MODE_TX_RX,
        .HwFlowCtl = UART_HWCONTROL_NONE,
        .OverSampling = UART_OVERSAMPLING_16,
        .OneBitSampling = UART_ONE_BIT_SAMPLE_DISABLE,
    },
    .AdvancedInit = {
        .AdvFeatureInit = UART_ADVFEATURE_NO_INIT,
    }
};

GPIO_InitTypeDef uart3_gpio = 
{
    .Pin = STLK_RX_Pin|STLK_TX_Pin,
    .Mode = GPIO_MODE_AF_PP,
    .Pull = GPIO_NOPULL,
    .Speed = GPIO_SPEED_FREQ_VERY_HIGH,
    .Alternate = GPIO_AF7_USART3,
};
