-include $(HALDIR)/objects.mk 
-include $(NUCLEODIR)/objects.mk 

plat-objs-y		:= $(hal-objs-y)
plat-objs-y		+= $(nucleo-objs-y)
plat-objs-y		+= interrupt_handlers.o
plat-objs-y		+= stm32f7xx_hal_msp.o
plat-objs-y		+= plat_init.o