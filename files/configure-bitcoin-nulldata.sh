#!/bin/bash

( cd /home/bitcoin/bitcoin-nulldata && \
  ./autogen.sh && \
  export BDB_PREFIX=/home/bitcoin/build/db-4.8.30.NC/build_unix/build && \
    ./configure CPPFLAGS="-I${BDB_PREFIX}/include/ -O2" \
    LDFLAGS="-L${BDB_PREFIX}/lib/" ) || (echo "Config failed!" && exit 1)
