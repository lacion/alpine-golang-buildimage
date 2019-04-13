#!/usr/bin/env bash

while read LINE
do 
    data=($LINE)
    echo "building $1 version: ${data[0]}"
    docker build --build-arg VERSION=${data[0]} --build-arg CHECKSUM=${data[1]} -t $1:local-${data[0]} .
done < versions