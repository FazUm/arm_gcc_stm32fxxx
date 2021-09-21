##############################################################################
############################# USER CONFIGURATIONS ############################

# PROJECT NAME
PROJECT_NAME := Blinky

# ARGUMENTS
DEBUG := y
OPTIM ?= O0

# STM
USERSTM	:= STM32F767xx

# TOOLCHAIN DIRECTORY
USER_TOOLCHAIN_DIR	:= /home/pedro/.toolchain/gcc-arm-none-eabi-10.3-2021.07/

##############################################################################
# TOOLCHAIN SET
TOOLCHAIN_DIR 	:= $(USER_TOOLCHAIN_DIR)/bin/
TOOLCHAIN 		:= arm-none-eabi-
CROSS_COMPILE 	?= $(addprefix $(TOOLCHAIN_DIR),$(TOOLCHAIN))

CC 			:= $(CROSS_COMPILE)gcc
GDB			:= $(CROSS_COMPILE)gdb
CXX			:= $(CROSS_COMPILE)g++
LD			:= $(CROSS_COMPILE)ld
SIZE		:= $(CROSS_COMPILE)size
OBJDUMP		:= $(CROSS_COMPILE)objdump
OBJCOPY 	:= $(CROSS_COMPILE)objcopy
READELF		:= $(CROSS_COMPILE)readelf
AR			:= $(CROSS_COMPILE)ar
AS			:= $(CROSS_COMPILE)gcc
STRIP 		:= $(CROSS_COMPILE)strip

#Compiler definition
COMPILER := $(CC)

##############################################################################
# MCU FLAGS
MCUFLAGS 	:= -mcpu=cortex-m7 
MCUFLAGS 	+= -mlittle-endian
MCUFLAGS	+= -mfloat-abi=hard
MCUFLAGS	+= -mfpu=fpv5-sp-d16
MCUFLAGS	+= -mthumb 

##############################################################################
# STM DEFINES
BDEFS 	:= -DSTM32 
BDEFS	+= -DSTM32F7 
BDEFS	+= -D$(USERSTM)
BDEFS	+= -DUSE_HAL_DRIVER
BDEFS	+= -DUSE_FULL_LL_DRIVERS

##############################################################################
# CC FLAG
CFLAGS		:= -c -$(OPTIM)
CFLAGS		+= -Wall -Wextra --pedantic
CFLAGS		+= -std=c11
CFLAGS		+= -fdata-sections -ffunction-sections

CFLAGS 		+= $(MCUFLAGS)
CFLAGS		+= $(BDEFS)

ifeq ($(DEBUG), y)
CFLAGS	+= -g -gdwarf-2
endif
##############################################################################
# LINKER FILE
LDSCRIPT = linkerfile.ld

##############################################################################
# LINKER FLAGS 
LDFLAGS 	:= -T$(LDSCRIPT)
LDFLAGS 	+= -static $(MCUFLAGS)
LDFLAGS 	+= -specs=nosys.specs

##############################################################################
# CODE DIRS
DRIVERSDIR	:= drivers

BASEDIR 	:= $(abspath .)
SRCDIR		:= $(BASEDIR)/src
USRDIR 		:= $(SRCDIR)/user
ARCHDIR 	:= $(SRCDIR)/arch
PLATDIR		:= $(SRCDIR)/platform
STMDIR		:= $(ARCHDIR)/$(USERSTM)
HALDIR 		:= $(PLATDIR)/$(DRIVERSDIR)
HALLEGDIR	:= $(HALDIR)/inc
CMSISDIR 	:= $(SRCDIR)/cmsis
NUCLEODIR	:= $(PLATDIR)/nucleo

CODE_DIRS := $(STMDIR) $(ARCHDIR) $(HALDIR) $(NUCLEODIR) $(PLATDIR) $(USRDIR)

export $(HALDIR) $(NUCLEODIR) $(DRIVERSDIR)

##############################################################################
#INCLUDE HEADER FILE
INC_DIRS := $(addsuffix /inc, $(CODE_DIRS))
#LEGACY SUPPORT 
INC_DIRS += $(HALLEGDIR)/Legacy
INCLUDES := $(addprefix -I, $(INC_DIRS))

##############################################################################
# OUT DIRS
OUTDIR := $(BASEDIR)
OBJDIR := $(OUTDIR)/build
BINDIR := $(OUTDIR)/bin
MKDIR 	:= $(OBJDIR) $(BINDIR)

##############################################################################
# SOURCE FILES
-include $(addsuffix /objects.mk, $(CODE_DIRS))

objs-y 	:= 	
objs-y	+= $(addprefix $(STMDIR)/,  $(stm-objs-y))
objs-y	+= $(addprefix $(ARCHDIR)/, $(arch-objs-y))
objs-y	+= $(addprefix $(PLATDIR)/, $(plat-objs-y))
objs-y	+= $(addprefix $(USRDIR)/, $(usr-objs-y))

deps   += $(patsubst %.o,%.d,$(objs-y))
objs-y	:= $(patsubst $(SRCDIR)%, $(OBJDIR)%, $(objs-y))

BUILD_DIRS := $(patsubst $(SRCDIR)%, $(OBJDIR)%, $(CODE_DIRS))
MKDIR      += $(BUILD_DIRS)

##############################################################################
# HEX FILE AND ELF
ELF := $(BINDIR)/$(PROJECT_NAME).elf
HEX := $(BINDIR)/$(PROJECT_NAME).hex

#BUILD RULES
.PHONY: all clean

all: $(HEX)

clean:
	@rm -rf $(OBJDIR)
	@rm -rf $(BINDIR) 
	@echo "Project cleaned!"

################################################################################
# Rule to create the ELF file
$(ELF): $(objs-y)
	@$(COMPILER) $(LDFLAGS) $(objs-y) -o  $@
	@echo "Linking $(patsubst $(BNDIR)/%,%, $@)"
ifneq ($(DEBUG), y)
	@echo "Stripping $@"
	@$(STRIP) -s $@
endif

################################################################################
# Rule to create the Hexadecimal file
$(HEX): $(ELF)
	@echo Generating hex $(patsubst $(BINDIR)/%,%, $@)
	@$(OBJCOPY) -O ihex $< $@
	@$(OBJDUMP) -S --wide $< > $(basename $<).asm
	@$(READELF) -a --wide $< > $(basename $<).txt
	@$(OBJDUMP) --all-headers --demangle --disassemble --file-headers --wide \
				-D $< > $(basename $<).lst
	@$(SIZE) $@
	@$(OBJDUMP) -f $<

################################################################################
# Rule to create the objects
$(objs-y):
	@echo Building $(notdir $@)
	@$(COMPILER) $(CFLAGS) $(INCLUDES) -c $< -o $@

################################################################################
# Rule to create directories
$(MKDIR):
	@echo "Creating directories	$(patsubst $(BASEDIR)/%, %, $@)"
	@mkdir -p $@ $(BINDIR)

############################## Secondary expansion ##############################
.SECONDEXPANSION:

$(deps) : | $$(@D) # Expands and creates the depedencies

################################################################################
# Rule to create the depedencies
$(OBJDIR)/%.d : $(SRCDIR)/%.[S,c]
	@echo "Creating dependency	$(patsubst $(BASEDIR)/%, %, $@)"
	@$(COMPILER) -MM -MG -MT "$(patsubst %.d, %.o, $@) $@" $(CFLAGS) $(INCLUDES) $< > $@
-include $(deps)