
.PHONY: lucid objects patcher clean
.SUFFIXES:
.SUFFIXES: .bas

.DEFAULT_GOAL := lucid

MAIN_LUCID = lucidoc
MAIN_PATCHER = patcher

## TODO: Clean OS detection up.
EXE_SUFFIX =
ifdef OS_WIN
	EXE_SUFFIX = .exe
endif
ifdef OS_DOS
	EXE_SUFFIX = .exe
endif

APP_LUCID := ${MAIN_LUCID}${EXE_SUFFIX}
APP_PATCHER := ${MAIN_PATCHER}${EXE_SUFFIX}

## HDRS := $(wildcard *.bi)
HDR_SHARED := $(wildcard inc/shared/*.bi)
HDR_OVERCALC := $(wildcard inc/overcalc/*.bi)
HDR_OVERCALC += lucidoc.bi
HDR_PATCHER := $(wildcard inc/patcher/*.bi)
## HDRS_PATCHER += patcher.bi
OBJ_SHARED := $(wildcard obj/shared/*.bas)
OBJ_OVERCALC := $(wildcard obj/overcalc/*.bas)
OBJ_PATCHER := $(wildcard obj/patcher/*.bas)

## Set FBC flags.
FBC = fbc
FBCFLAGS = 
COMMON_FLAGS = -maxerr 5 -w pedantic
INC_FLAGS = -i 'inc/shared' -i 'inc/overcalc' -i 'inc/patcher'
ifdef EXOPTS
	FBCFLAGS += ${EXOPTS}
endif
ifdef FPU
	ifeq (${FPU},sse)
		FBCFLAGS += -fpu sse
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
FBCFLAGS += ${COMMON_FLAGS} ${INC_FLAGS}

.INTERMEDIATE: obj/shared/%.o obj/overcalc/%.o obj/patcher/%.o
.DELETE_ON_ERROR: 

lucid: ${APP_LUCID}

objects: ${OBJ_SHARED} ${OBJ_OVERCALC} ${OBJ_PATCHER}

obj/shared/%.o: ${OBJ_SHARED}
	${FBC} ${FBCFLAGS} -c $(patsubst %.o,%.bas,$@)

obj/overcalc/%.o: ${OBJ_OVERCALC}
	${FBC} ${FBCFLAGS} -c $(patsubst %.o,%.bas,$@)

${APP_LUCID}: ${MAIN_LUCID}.bas ${HDR_SHARED} ${HDR_OVERCALC} $(patsubst %.bas,%.o,${OBJ_SHARED} ${OBJ_OVERCALC})
	${FBC} ${FBCFLAGS} ${MAIN_LUCID}.bas $(patsubst %.bas,%.o,${OBJ_SHARED} ${OBJ_OVERCALC}) -x ${APP_LUCID}

${APP_PATCHER}: ${SRCS} ${HDRS} ${MAIN_PATCHER}.bas
	${FBC} ${FBCFLAGS} ${MAIN_PATCHER}.bas -x ${APP_PATCHER}

.IGNORE: clean
clean: MAKE_TERMOUT = /dev/stderr
clean: MAKE_TERMERR = /dev/null
clean:
	rm -vf obj/shared/*.o
	rm -vf obj/overcalc/*.o
	rm -vf obj/patcher/*.o
	rm -vf ${APP_LUCID}
	rm -vf ${APP_PATCHER}

## EOF
