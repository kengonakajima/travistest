all: clean test

test:
	git clone http://repo.or.cz/r/lua.git
	cd lua/src; make linux
	lua test.lua

clean:
	rm -rf lua