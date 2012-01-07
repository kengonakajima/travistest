ifeq ($(shell uname -sm | sed -e s,x86_64,i386,),Darwin i386)
#osx
LUABUILDNAME=macosx
else
# linux
LUABUILDNAME=linux
endif


all: test

test: clean get build mysqltest dotest

mysqltest:
	mysql -u root -P "" -e "show databases; drop database if exists luajit_mysql_test; create database luajit_mysql_test"
	mysql -u root -P "" luajit_mysql_test -e "create table aho( id int ); insert into aho set id=100; insert into aho set id=1000; insert into aho set id=10000; delete from aho where id = 1000; update aho set id = 101 where id = 100; select * from aho"

get:
	git clone https://github.com/kengonakajima/lua-msgpack.git
	git clone https://github.com/kengonakajima/lua-msgpack-native.git
	git clone https://github.com/kengonakajima/luajit-mysql
	git clone http://repo.or.cz/r/lua.git

build:
	cd lua/src; make $(LUABUILDNAME)
	ln -s lua/src/lua ./luaexec

dotest: lua-msgpack-test lua-msgpack-native-test luajit-mysql-test

lua-msgpack-test:
	cd lua-msgpack; ../luaexec test.lua

lua-msgpack-native-test:
	cd lua-msgpack-native; make

luajit-mysql-test: # depends on luvit in lua-msgpack-native 
	cd luajit-mysql; ../lua-msgpack-native/deps/luvit/build/luvit test.lua

clean:
	rm -rf lua luaexec lua-msgpack lua-msgpack-native luajit-mysql
