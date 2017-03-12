all: build

build:
	gnatmake element_processing.adb -largs -lasis
clean:
	rm -rf obj/*.o obj/*.ali obj/*.adt element_processing
