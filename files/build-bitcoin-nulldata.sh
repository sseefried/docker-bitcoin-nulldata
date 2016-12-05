#!/bin/bash

( cd /home/bitcoin/bitcoin-nulldata && make -j 4) || (echo "Build failed!" && exit 1)
