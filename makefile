EMSCRIPTEN=/data/workspace/sources/emscripten/
LLVM=/data/workspace/sources/clang+llvm-3.1-x86_64-linux-ubuntu_12.04/bin

EMCC=$(EMSCRIPTEN)/emcc
CFLAGS= -std=c99
LDFLAGS=
CC=$(LLVM)/clang

SRCS= magic.c apprentice.c softmagic.c ascmagic.c encoding.c readelf.c print.c funcs.c apptype.c fsmagic.c is_tar.c cdf.c cdf_time.c readcdf.c asprintf.c vasprintf.c
OBJS=$(SRCS:.c=.o)

run: ./file
	./file ./file

clean:
	rm *.o file -f

%.o : %.c file.h
	$(CC) -c $(CFLAGS) $< -o $@

file: $(OBJS) file.c
	$(CC) $(LDFLAGS) $(OBJS) file.c -o file

file.js: $(FILE_SRCS) file.h file.c
	$(EMCC) $(CFLAGS) $(SRCS) file.c -o file.js --pre-js file_pre.js

node_file: file.js
	node file.js test/a.out

webfile.js: $(SRCS) file.h webfile.c
	$(EMCC) $(CFLAGS) $(SRCS) webfile.c -o webfile.html --preload-file magic.mgc --pre-js webfile_pre.js

webfile: webfile.js
	echo "done"

# tests

test_file:
	$(EMCC) $(CFLAGS) test_file.c -o tf.js --pre-js test_file_pre.js
	node tf.js temp.data
