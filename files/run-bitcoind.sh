#!/bin/bash

cat <<END > /home/bitcoin/.bitcoin/bitcoin.conf
disablewallet=1
printtoconsole=1
rpcuser=bitcoinrpc
rpcpassword=YwdRRcTVR7auH0xWukWUd5qk77t2rxP6FKJlk1YL0YIM
dbcache=2048
par=2
checklevel=0
END

BITCOIND=/home/bitcoin/bitcoin-nulldata/src/bitcoind

if [ ! -f $BITCOIND ]; then
  echo "Could not find '$BITCOIND'"
  exit 1
fi

$BITCOIND $@


