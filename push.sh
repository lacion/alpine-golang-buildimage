#!/usr/bin/env bash

echo "pushing $1 version: latest"
docker push $1:latest

while read LINE
do 
    data=($LINE)

    VERSION=${data[0]}
    MAJOR=${data[1]}
    MINOR=${data[2]}
    PATCH=${data[3]}
    SPECIAL=${data[4]}

    echo "pushing $1 version: $MAJOR"
    docker push $1:$MAJOR

    echo "pushing $1 version: $MAJOR.$MINOR"
    docker push $1:$MAJOR.$MINOR

    echo "pushing $1 version: $MAJOR.$MINOR.$PATCH"
    docker push $1:$MAJOR.$MINOR.$PATCH
    
    echo "pushing $1 version: $VERSION"
    docker push $1:$VERSION
done < semvers