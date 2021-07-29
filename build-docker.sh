#!/usr/bin/env bash

set -eu

tag=minisat-$RANDOM

docker build -t $tag .
cnt=$(docker create $tag)
docker cp $cnt:/src/build/minisat minisat.wasm
docker rm $cnt
docker rmi --no-prune $tag
