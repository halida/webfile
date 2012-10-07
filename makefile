EMSCRIPTEN=~/workspace/emscripten/
LLVM=~/workspace/clang+llvm-3.1-x86-linux-ubuntu-11.10/bin/

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
	$(EMCC) $(CFLAGS) $(SRCS) webfile.c -o webfile.js --pre-js webfile_pre.js --preload-file magic.mgc -s EXPORTED_FUNCTIONS="['_webfile_check']"

webfile: webfile.js
	echo "done"

# tests

test_file:
	$(EMCC) $(CFLAGS) test_file.c -o tf.js --pre-js test_file_pre.js
	node tf.js temp.data
