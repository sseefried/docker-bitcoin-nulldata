if [ "$BITCOIN_NULLDATA_PATH" = "" ];then
  echo "BITCOIN_NULLDATA_PATH not defined"
  exit 1
fi

if [ $# -lt 1 ]; then
  echo "Usage: $(basename $0) <image hash>"
  exit 1
fi

HASH=$1

docker run -it --rm \
    -a STDOUT \
    -v bitcoind-data:/dot_bitcoin  \
    -v "$BITCOIN_NULLDATA_PATH":/home/bitcoin/bitcoin-nulldata \
    "$HASH" /home/bitcoin/build-bitcoin-nulldata.sh
