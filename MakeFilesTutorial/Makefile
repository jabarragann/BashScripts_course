
all:  helloWorld

helloWorld: main.o function1.o function2.o
	echo "Generating excutable"
	g++ main.o function1.o function2.o -o helloWorld
		

main.o: main.cpp
	g++ -c main.cpp

function1.o: function1.cpp
	g++ -c function1.cpp

function2.o: function2.cpp
	g++ -c function2.cpp

clean:
	rm -rf *o helloWorld
