ndll:
	cd project && haxelib run hxcpp Build.xml mac

example: ndll
	cd example && openfl test cpp -debug -Ddebug

test: ndll
	haxelib run munit gen
	openfl test cpp -debug -Ddebug

all: ndll

.PHONY: ndll test all
