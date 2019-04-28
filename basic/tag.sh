#!/usr/bin/env bash

while read LINE
do 
    data=($LINE)
    echo "tagging $1 version: ${data[0]}"
    docker tag $1:local-${data[0]} $1:${data[0]}
done < versions