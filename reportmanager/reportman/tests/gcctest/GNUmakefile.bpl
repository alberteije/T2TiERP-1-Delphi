all: test
	
test: test.cc libreportmanapi.so
	g++ -o test test.cc -L. libreportmanapi.so

clean:
	rm -f test
