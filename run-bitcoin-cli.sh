#!/bin/bash

docker exec -it bitcoin-nulldata-bitcoind \
  /home/bitcoin/bitcoin-nulldata/src/bitcoin-cli $@
