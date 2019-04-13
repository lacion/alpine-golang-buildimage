#!/usr/bin/env bash

while read LINE
do 
    data=($LINE)

    VERSION=${data[0]}
    MAJOR=${data[1]}
    MINOR=${data[2]}
    PATCH=${data[3]}
    SPECIAL=${data[4]}

    echo "tagging $1 version: latest"
    docker tag $1:local-$VERSION $1:latest

    echo "tagging $1 version: $MAJOR"
    docker tag $1:local-$VERSION $1:$MAJOR

    echo "tagging $1 version: $MAJOR.$MINOR"
    docker tag $1:local-$VERSION $1:$MAJOR.$MINOR

    echo "tagging $1 version: $MAJOR.$MINOR.$PATCH"
    docker tag $1:local-$VERSION $1:$MAJOR.$MINOR.$PATCH

    echo "tagging $1 version: $VERSION"
    docker tag $1:local-$VERSION $1:$VERSION
done < semvers