#******************************************************************************
# Copyright (C) 2017 by Alex Fosdick - University of Colorado
#
# Redistribution, modification or use of this software in source or binary
# forms is permitted as long as the files maintain this copyright. Users are 
# permitted to modify this and use it to learn about the field of embedded
# software. Alex Fosdick and the University of Colorado are not liable for any
# misuse of this material. 
#
#*****************************************************************************

#------------------------------------------------------------------------------
# Makefile for Course 1 - Final Assessment (Module 2)
#
# This Makefile builds the `c1m2.out` executable for both host (native) and 
# embedded (MSP432) platforms. It supports compilation, preprocessing, 
# assembly generation, and disassembly via objdump.
#
# Use: make [TARGET] [PLATFORM=HOST|MSP432]
#
# Build Targets:
#     build         - Compiles and links all sources into c1m2.out
#     compile-all   - Compiles all source files into object files only
#     clean         - Removes all generated files (.o, .i, .asm, .out, etc.)
#
# Platform Overrides:
#     PLATFORM=HOST     - Builds for the host system using gcc
#     PLATFORM=MSP432   - Cross-compiles for MSP432 using arm-none-eabi-gcc
#
# Notes:
#     - HOST builds are executable on your machine (e.g., ./c1m2.out)
#     - MSP432 builds generate embedded binaries, not runnable on host
#     - Assembly (.asm) and disassembly (.objdump.asm) files are supported
#------------------------------------------------------------------------------

# Include source and include directories
include sources.mk

# Build Target File
TARGET = c1m2.out

# Determine the platform
ifeq ($(PLATFORM),HOST)
    CC = gcc
    CFLAGS = -Wall -Werror -g -O0 -std=c99
    CPPFLAGS = -DHOST
    LDFLAGS =
    SIZE = size
    OBJDUMP = objdump
else
    CC = arm-none-eabi-gcc
    CFLAGS = -Wall -Werror -g -O0 -std=c99 \
        -mcpu=cortex-m4 -mthumb -march=armv7e-m -mfloat-abi=hard -mfpu=fpv4-sp-d16 --specs=nosys.specs
    CPPFLAGS = -DMSP432
    LDFLAGS = -T msp432p401r.lds
    SIZE = arm-none-eabi-size
    OBJDUMP = arm-none-eabi-objdump
endif

# Object and dependency files
OBJS := $(SRCS:.c=.o)

# Generate preprocessed output
%.i: %.c
	$(CC) $(INCLUDES) $(CPPFLAGS) -E $< -o $@

# Generate assembly output
%.asm: %.c
	$(CC) $(CFLAGS) $(INCLUDES) $(CPPFLAGS) -S $< -o $@

# Generate assembly output using objdump
%.objdump.asm: %.o
	$(OBJDUMP) -dS $< > $@

# Compile each .c to .o with dependency generation
%.o: %.c
	$(CC) $(CFLAGS) $(INCLUDES) $(CPPFLAGS) -c $< -o $@

# .PHONY Protection
.PHONY: compile-all build clean

# Compile all object files without linking
compile-all: $(OBJS)

# Default target: build everything
build: $(TARGET)
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(INCLUDES) $(CPPFLAGS) $(LDFLAGS) $^ -o $@

# Clean target: remove all generated files
clean:
	rm -f $(OBJS) $(DEPS) $(TARGET) *.map *.i *.asm
