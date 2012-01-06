
all: test

#test: clean get build dotest
test: clean get build dotest
	mysql -e "show databases; use test; show tables;"

get:
	git submodule init
	git submodule update
	git clone http://repo.or.cz/r/lua.git

build:
	cd lua/src; make linux
	ln -s lua/src/lua ./luaexec

dotest:
	cd deps/lua-msgpack; ../../luaexec test.lua

clean:
	rm -rf lua luaexec
