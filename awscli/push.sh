#!/usr/bin/env bash

while read LINE
do 
    data=($LINE)
    echo "pushing $1 version: ${data[0]}"
    docker push $1:${data[0]}-awscli
done < versions