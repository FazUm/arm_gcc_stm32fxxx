//needed for _write definition
#include  <errno.h>
#include  <sys/unistd.h>
#include <stdio.h>

#include "plat_init.h"

int _write(int file, char *data, int len)
{
   if ((file != STDOUT_FILENO) && (file != STDERR_FILENO))
   {
      errno = EBADF;
      return -1;
   }
 
   // arbitrary timeout 1000
   HAL_StatusTypeDef status =
      HAL_UART_Transmit(&uart3, (uint8_t*)data, len, 1000);
 
   // return # of bytes written - as best we can tell
   return (status == HAL_OK ? len : 0);
}