
all: test

#test: clean get build dotest
test:
	mysql -e "show databases; use test; show tables;"

get:
	git clone https://github.com/kengonakajima/lua-msgpack.git
	git clone https://github.com/kengonakajima/lua-msgpack-native.git
	git clone http://repo.or.cz/r/lua.git

build:
	cd lua/src; make linux
	ln -s lua/src/lua ./luaexec

dotest: lua-msgpack-test lua-msgpack-native-test

lua-msgpack-test:
	cd lua-msgpack; ../luaexec test.lua

lua-msgpack-native-test:
	cd lua-msgpack-native; make

clean:
	rm -rf lua luaexec lua-msgpack lua-msgpack-native
