all: build

build:
	gnatmake element_processing.adb -largs -lasis
clean:
	rm -rf *.o *.ali *.adt element_processing