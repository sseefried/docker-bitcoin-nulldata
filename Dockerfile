FROM ubuntu:16.04
MAINTAINER Max Kaye <m@xk.io>

ARG USER_ID
ARG GROUP_ID

# Required for bsdmainutils which contains hexdump
RUN dpkg --add-architecture i386

RUN apt-get update && \
    apt-get install -y \
      wget git \
      build-essential libtool autotools-dev autoconf pkg-config libssl-dev \
      libboost-all-dev libqt4-dev libprotobuf-dev protobuf-compiler libqrencode-dev \
      libminiupnpc-dev bsdmainutils libevent-dev sudo nano

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}
RUN groupadd -g ${GROUP_ID} bitcoin
RUN useradd -u ${USER_ID} -g bitcoin -s /bin/bash -m -d /home/bitcoin bitcoin

ENV HOME /home/bitcoin

RUN chown bitcoin:bitcoin -R /home/bitcoin

RUN echo "bitcoin:bitcoin" | chpasswd && adduser bitcoin sudo

USER bitcoin
WORKDIR /home/bitcoin

RUN wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz

ADD files/build-bdb.sh /home/bitcoin
RUN ./build-bdb.sh

# These are to use once you've started an interactive session
ADD files/configure-bitcoin-nulldata.sh /home/bitcoin
ADD files/build-bitcoin-nulldata.sh /home/bitcoin
ADD files/run-bitcoind.sh /home/bitcoin

VOLUME ["/dot_bitcoin"]

RUN ln -s /dot_bitcoin /home/bitcoin/.bitcoin

EXPOSE 8332 8333 18332 18333