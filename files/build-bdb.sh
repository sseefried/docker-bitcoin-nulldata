#!/bin/bash

mkdir -p /home/bitcoin/build
cd /home/bitcoin/build
tar -xf /home/bitcoin/db-4.8.30.NC.tar.gz
cd db-4.8.30.NC/build_unix
echo $(pwd)
mkdir -p build
export BDB_PREFIX=$(pwd)/build
../dist/configure --disable-shared --enable-cxx --with-pic --prefix=$BDB_PREFIX
make install
