all: clean get build test

get:
	git clone http://repo.or.cz/r/lua.git

build:
	cd lua/src; make linux

test:
	lua test.lua

clean:
	rm -rf lua