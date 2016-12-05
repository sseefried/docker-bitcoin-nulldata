#!/bin/bash

if [ "$BITCOIN_NULLDATA_PATH" = "" ];then
  echo "BITCOIN_NULLDATA_PATH not defined"
  exit 1
fi

if [ $# -lt 1 ]; then
  echo "Usage: $(basename $0) <image hash> [bitcoind args...]"
  exit 1
fi

HASH=$1
shift
# Rest of args are now bitcoind args

docker run -d \
    --name bitcoin-nulldata-bitcoind \
    -v bitcoind-data:/dot_bitcoin  \
    -v "$BITCOIN_NULLDATA_PATH":/home/bitcoin/bitcoin-nulldata \
    "$HASH" \
    ./run-bitcoind.sh $@