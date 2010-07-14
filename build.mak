all: coremake corerc

coremake: coremake.c
	$(CC) coremake.c -o coremake

corerc: corerc.c
	$(CC) corerc.c -o corerc
