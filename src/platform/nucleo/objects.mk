nucleo-objs-y 	:= stm32f7xx_nucleo_144.o
nucleo-objs-y	+= nucleo_configs.o
nucleo-objs-y	+= uart.o

nucleo-objs-y := $(addprefix nucleo/, $(nucleo-objs-y))