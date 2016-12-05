# Dockerisation for bitcoin-nulldata repo

## Set up environment variables

Set `BITCOIN_NULLDATA_PATH` to path of `bitcoin-nulldata` repo. e.g.

    export BITCOIN_NULLDATA_PATH=/home/bitcoin/bitcoin-nulldata

## Building Docker image

    $ docker build .

This will produce output like:

    [...]
     ---> a1ff3e274338
    Step 24 : EXPOSE 8332 8333 18332 18333
     ---> Using cache
     ---> c1ef315bf180
    Successfully built c1ef315bf180

Remember the hash after `Successfully built`. You will need it to
build `bitcoind`

## Building `bitcoind`

There are two scripts, one to configure and one to build

- `./configure-bitcoin-nulldata-sh`
- `./build-bitcoin-nulldata.sh`

These map the repo path a _temporary_ running container and allow you to build
`bitcoin-nulldata` _inside_ the running container.  However, since it is mapped
in the results are not forgotten once you stop (or even remove) the container.

     $ ./configure-bitcoin-nulldata.sh
     $ ./build-bitcoin-nulldata.sh

*Note: If you wish to rebuild `bitcoind` at a later date and you have
a running container you will have to stop it, and remove it. See
"Stopping `bitcoind` and removing container" below*

The scripts will warn you of this anyway.

## Running `bitcoind` inside new container in background

Once you have built `bitcoin-nulldata` you can run `bitcoind` using the
`./run-bitcoind-in-container.sh` script. This will create a Docker container, running
in the background, that will run `bitcoind`.

The container will be named: `bitcoin-nulldata-bitcoind`.

You can view its logs using:

    $ docker logs -f bitcoind-nulldata-bitcoind

## Running `bitcoin-cli`

This will only work once you have run `./run-bitcoind-in-container.sh`.

It uses `docker exec` which allows you to run a process in a running container.

    $ ./run-bitcoin-cli.sh

# Running `bash` in running container

    $ ./run-bash.sh

## Stopping `bitcoind` and removing container

    $ docker stop bitcoin-nulldata-bitcoind
    $ docker rm bitcoin-nulldata-bitcoind


