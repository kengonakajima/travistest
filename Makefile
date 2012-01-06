
all: test

#test: clean get build dotest
test:
	mysql -e "show databases;"
	mysql -e "drop database if exists test"
	mysql -e "create database test"
	mysql test -e "create table aho( id int )"
	mysql test -e "insert into aho set id=100"
	mysql test -e "insert into aho set id=1000"
	mysql test -e "insert into aho set id=10000"
	mysql test -e "delete from aho where id = 1000"
	mysql test -e "update aho set id = 101 where id = 100"
	mysql test -e "select * from aho"

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
