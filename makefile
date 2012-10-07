EMSCRIPTEN=/data/workspace/sources/emscripten/
LLVM=~/workspace/clang+llvm-3.1-x86-linux-ubuntu-11.10/bin/

EMCC=$(EMSCRIPTEN)/emcc 
CFLAGS=
LDFLAGS=
CC=gcc
# $(LLVM)/clang

SRCS= tm.c magic.c apprentice.c softmagic.c ascmagic.c encoding.c compress.c readelf.c print.c funcs.c apptype.c fsmagic.c is_tar.c cdf.c cdf_time.c readcdf.c 
OBJS=$(SRCS:.c=.o)

run: ./tm
	./tm ./tm

clean:
	rm *.o tm -f

%.o : %.c file.h
	$(CC) -c $(CFLAGS) $< -o $@

tm: $(OBJS)
	$(CC) $(LDFLAGS) $(OBJS) -o tm
emcc:
	$(EMCC) $(CFLAGS) -lmagic tm.c