#!/usr/bin/bash

dir=$1

if [[ -f build.sh ]]; then
    ./build.sh $dir
    exit 0
fi

if [[ -f Makefile ]]; then
    make build
    exit 0
fi

if [[ -f beet.json ]]; then
    rye run beet build
    exit 0
fi

if [[ -f ../beet.json ]]; then
    cd ..
    rye run beet build
    exit 0
fi

echo "build: Skipping..."
