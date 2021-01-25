## ---------------------------------------------------------------------
## 
## Lucid Patcher makefile
## 
## Usage:
## make [build] - Build Patcher.
## make clean   - Remove extra files.
## 
## Copyright 2021 Lisa Murray
## 
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
## MA 02110-1301, USA.
## 
## ---------------------------------------------------------------------

## ---------------------------------------------------------------------
## Set phony & default targets, and override the default suffix rules.
## ---------------------------------------------------------------------
.PHONY: build clean
.SUFFIXES:

.DEFAULT_GOAL := build

include makefile.osdetect

## ---------------------------------------------------------------------
## Setup project details.
## ---------------------------------------------------------------------

TARGET   := $(shell basename ${CURDIR})
BUILD    := 
SOURCES  := obj
DATA     := 
INCLUDES := inc

LIBS     := 
LIBDIRS  :=

OBJS     := ${TARGET}.o
OBJS     += ${SOURCES}/prompts.o

## ---------------------------------------------------------------------
## Set flags for code generation.
## ---------------------------------------------------------------------

CC       := gcc
LD       := gcc
OBJCOPY  := objcopy

CFLAGS   =  -g -Wall -O3\
	-fomit-frame-pointer -ffast-math -fno-strict-aliasing

ifdef INCLUDE
	CFLAGS += ${INCLUDE}
endif

LDFLAGS  := ${CFLAGS}

CXXFLAGS := ${CFLAGS} -fno-rtti -fno-exceptions

## ---------------------------------------------------------------------
## Compilation rules.
## ---------------------------------------------------------------------

.INTERMEDIATE: ${TARGET}.elf
.DELETE_ON_ERROR: ${OBJS} ${TARGET}.elf

build: ${TARGET}
	chmod +x $<

## Strip binaries.
${TARGET}: ${TARGET}.elf
	-@echo 'Stripping symbols from "$<"... ("$<"->"$@")'
	#${OBJCOPY} -v -O binary $< $@
	${OBJCOPY} -vgO elf64-x86-64 $< $@

## Link objects.
${TARGET}.elf: ${TARGET}.o ${OBJS}
	-@echo 'Linking objects... ("$^"->"$@")'
	${LD} $^ $(LDFLAGS) -o $@

## Compile objects.
${OBJS}: %.o : %.c
	-@echo 'Compiling object "$@"... ("$<"->"$@")'
	${CC} ${CFLAGS} -c $< -o $@

## Remove unnecessary binary files.
.IGNORE: clean
clean:
	-@echo 'Cleaning up intermediary files...'
	@rm -vf ${SOURCES}/*.o *.o *.elf

## EOF
