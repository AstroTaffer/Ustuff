all: example_cpp example_c

example_cpp: example_cpp.o
	g++ example_cpp.o -o example_cpp

example_cpp.o: example.cpp
	g++ -c -o example_cpp.o example.cpp

example_c: example_c.o
	gcc example_c.o -o example_c

example_c.o: example.c
	gcc -c -o example_c.o example.c

clean:
	rm -f *.o example_cpp example_c
