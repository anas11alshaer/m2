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

#******************************************************************************
# File:     sources.mk
# Author:   Anas Alshaer
# Purpose:  Define source files and include paths for host and target platforms
#           in the embedded software project build system.
#
# Usage:    Included by the main Makefile to provide lists of source files
#           and include directories depending on the selected PLATFORM.
#
# Structure:
#   - HOST platform: Simulates embedded software on the development machine.
#   - TARGET (MSP432): Builds for the MSP432 embedded device using additional
#                      device-specific source files and includes.
#
# Note:
#   This file is located in the 'src' directory. All paths are relative to
#   the project root directory where the main Makefile resides.
#
#*****************************************************************************  

ifeq ($(PLATFORM),HOST)
SRCS = main.c memory.c
INCLUDES = -I../include/common
else
SRCS = main.c memory.c \
          interrupts_msp432p401r_gcc.c \
          startup_msp432p401r_gcc.c \
          system_msp432p401r.c
INCLUDES = -I../include/common -I../include/CMSIS -I../include/msp432
endif

