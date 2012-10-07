EMSCRIPTEN=/data/workspace/sources/emscripten/
EMCC=$(EMSCRIPTEN)/emcc 
CFLAGS=

run: ./tm
	./tm ./tm
tm: tm.c
	gcc tm.c -lmagic -o tm
emcc:
	$(EMCC) $(CFLAGS) -lmagic tm.c