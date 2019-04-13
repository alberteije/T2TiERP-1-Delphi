all: test testqtlin
	
test: test.cc 
	g++ -o test test.cc ../libreportmanapi.so ../../libborunwind.so.6.0

testqtlin: testqtlin.cc
	g++ -o testqtlin testqtlin.cc ../libreportmanapiqt.so ../../libborqt-6.9-qt2.3.so ../../libborunwind.so.6.0

clean:
	rm -f test
	rm -f testqt pp.pdf
