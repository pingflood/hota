all: hota/alien.dge

CHAINPREFIX := /opt/mipsel-linux-uclibc
CROSS_COMPILE := $(CHAINPREFIX)/usr/bin/mipsel-linux-

CC = $(CROSS_COMPILE)gcc

SYSROOT     := $(shell $(CC) --print-sysroot)
SDL_CFLAGS  := $(shell $(SYSROOT)/usr/bin/sdl-config --cflags)
SDL_LIBS    := $(shell $(SYSROOT)/usr/bin/sdl-config --libs)

CFLAGS= -DDINGUX $(SDL_CFLAGS) #-DENABLE_DEBUG
OBJS=\
	src/common.o src/vm.o src/sprites.o src/decode.o src/animation.o src/rooms.o \
	src/render.o src/main.o src/music.o src/debug.o src/lzss.o src/cd_iso.o src/sound.o \
	src/screen.o src/scale2x.o src/scale3x.o src/game2bin.o

LIBS=$(SDL_LIBS) -lSDLmain -lSDL_mixer

hota/alien.dge: $(OBJS)
	$(CC) -o $@ $(OBJS) $(LIBS)

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm $(OBJS) hota/alien.dge
