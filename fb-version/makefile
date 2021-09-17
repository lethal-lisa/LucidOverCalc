
.PHONY: build install clean
.SUFFIXES:
.SUFFIXES: .bas

.DEFAULT_GOAL := build

TARGET := lucidoc

## TODO: Clean OS detection up.
EXE_SUFFIX =
ifdef OS_WIN
	EXE_SUFFIX = .exe
endif
ifdef OS_DOS
	EXE_SUFFIX = .exe
endif

OBJS         := $(patsubst %.bas,%.o,$(wildcard obj/*.bas))

## Set FBC flags.
FBC          := fbc
FBCFLAGS     :=
COMMON_FLAGS := -maxerr 5 -w pedantic -i 'inc'
ifdef EXOPTS
	FBCFLAGS += ${EXOPTS}
endif
ifdef FPU
	ifeq (${FPU},sse)
		FBCFLAGS += -fpu sse
		ifdef FPMODE
			ifeq (${FPMODE},fast)
				FBCFLAGS += -fpmode fast
			else
				FBCFLAGS += -fpmode precise
			endif
		endif
	else
		FBCFLAGS += -fpu x87
	endif
endif
ifdef DEBUG
	ifeq (${DEBUG},2)
		FBCFLAGS += -g
	else
		FBCFLAGS += -edebug
	endif
endif
FBCFLAGS += ${COMMON_FLAGS}

.INTERMEDIATE:
.DELETE_ON_ERROR:

build: ${TARGET}
	chmod +x $<

${OBJS}: %.o : %.bas
	-@echo 'Compiling object "$@"... ("$<"->"$@")'
	${FBC} ${FBCFLAGS} -c $<

${TARGET}: ${OBJS}
	-@echo 'Compiling binary "$@"... ("$^"->"$@")'
	${FBC} ${FBCFLAGS} lucidoc.bas $^ -x $@

.IGNORE: clean
clean: MAKE_TERMOUT = /dev/stderr
clean: MAKE_TERMERR = /dev/null
clean:
	@rm -vf obj/*.o

## EOF
