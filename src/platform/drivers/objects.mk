hal-objs-y	:= stm32f7xx_hal.o
hal-objs-y	+= stm32f7xx_hal_gpio.o
hal-objs-y	+= stm32f7xx_hal_cortex.o
hal-objs-y	+= stm32f7xx_hal_pwr.o
hal-objs-y	+= stm32f7xx_hal_pwr_ex.o
hal-objs-y	+= stm32f7xx_hal_rcc.o
hal-objs-y	+= stm32f7xx_hal_rcc_ex.o

hal-objs-y := $(addprefix $(DRIVERSDIR)/, $(hal-objs-y))