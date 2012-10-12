# set your emscripten and llvm path
EMSCRIPTEN=/data/workspace/sources/emscripten/
LLVM=/data/workspace/sources/clang+llvm-3.1-x86_64-linux-ubuntu_12.04/bin

WEB_PAGE_URL=web/

EMCC=$(EMSCRIPTEN)/emcc
CFLAGS=
LDFLAGS=
CC=$(LLVM)/clang

REG_SRCS= regexp/regcomp.c \
	regexp/regerror.c \
	regexp/regexec.c \
	regexp/regfree.c \
	regexp/regstrlcpy.c
FILE_SRCS= file/magic.c \
	file/apprentice.c \
	file/softmagic.c \
	file/ascmagic.c \
	file/encoding.c \
	file/readelf.c \
	file/print.c \
	file/funcs.c \
	file/apptype.c \
	file/fsmagic.c \
	file/is_tar.c \
	file/cdf.c \
	file/cdf_time.c \
	file/readcdf.c \
	file/asprintf.c \
	file/vasprintf.c
SRCS= $(FILE_SRCS) $(REG_SRCS)
OBJS=$(SRCS:.c=.o)

# compile and run a libmagic executable program
run: file.bin init_test_file
	./file.bin

init_test_file:
	cp data/a.out testfile
	cp data/magic.mgc ./

clean:
	rm *.o *.bin *.js testfile magic.mgc *.html *.data -f

%.o : %.c file.h
	$(CC) -c $(CFLAGS) $< -o $@

file.bin: $(OBJS) file/file.c
	$(CC) $(LDFLAGS) $(OBJS) file/file.c -o $@


# compile and run a nodejs libmagic executable program
node_run: file.js init_test_file
	node file.js testfile

file.js: $(FILE_SRCS) file/file.h file/file.c
	$(EMCC) $(CFLAGS) $(SRCS) file/file.c -o file.js --pre-js srcs/file_pre.js


# compile and run webfile web page
webfile: webfile.html
	ruby srcs/pre_process_webfile.rb > $(WEB_PAGE_URL)/javascripts/webfile.js
	cp webfile.data $(WEB_PAGE_URL)

webfile.html: $(SRCS) file/file.h file/webfile.c
	$(EMCC) $(CFLAGS) $(SRCS) file/webfile.c -o webfile.html --preload-file magic.mgc --pre-js srcs/webfile_pre.js

# tests
test_all: run node_run webfile

test_file:
	$(EMCC) $(CFLAGS) test_file.c -o tf.js --pre-js test_file_pre.js
	node tf.js temp.data
