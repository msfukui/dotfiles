#==========================================
#    Makefile: makefile for sl
#	Copyright 1993,1998 Toyoda Masashi 
#		(toyoda@is.titech.ac.jp)
#	Last Modified: 1998/ 7/22
#==========================================

CC = gcc

#DEBUGOPTS = -DDEBUG -g

# For Linux 2.0.x
LDFLAGS = -lncurses
CFLAGS = -Wall -O2 -DLINUX20 $(DEBUGOPTS)

# For Solaris
#LDFLAGS = -lcurses -ltermcap
#CFLAGS = -Wall -O2 $(DEBUGOPTS)

all: sl

sl: sl.c sl.h header.h Makefile
	$(CC) $(CFLAGS) -o sl sl.c $(LDFLAGS)

clean:
	-rm -f sl sl.o core
