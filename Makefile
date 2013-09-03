ndll:
	cd project && haxelib run hxcpp Build.xml mac

test: ndll
	cd MenuTest && openfl test cpp -debug -Ddebug

all: test

.PHONY: ndll test all
