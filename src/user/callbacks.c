#include "plat.h"

void HAL_UART_RxCpltCallback(UART_HandleTypeDef* huart){
	if (huart->Instance == USART3){ //current UART?
		//increment the index in the array
		UART_INDEX++;
		//make sure the array is cirular
		UART_INDEX &= (UART_BUFFER_SIZE - 1);
		//enable it again
		HAL_UART_Receive_IT(&uart3, &UART_BUFFER[UART_INDEX], 1);
	}
}