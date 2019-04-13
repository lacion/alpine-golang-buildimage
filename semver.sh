#!/usr/bin/env sh

function semverParse() {
    local RE='[^0-9]*\([0-9]*\)[.]\([0-9]*\)[.]\([0-9]*\)\([0-9A-Za-z-]*\)'
    #MAJOR
    eval $2=`echo $1 | sed -e "s#$RE#\1#"`
    #MINOR
    eval $3=`echo $1 | sed -e "s#$RE#\2#"`
    #MINOR
    eval $4=`echo $1 | sed -e "s#$RE#\3#"`
    #SPECIAL
    eval $5=`echo $1 | sed -e "s#$RE#\4#"`
}

if [ -f semvers ] ; then
    rm semvers
fi

while read LINE
do 
    data=($LINE)

    MAJOR=0
    MINOR=0
    PATCH=0
    SPECIAL=""

    semverParse ${data[0]} MAJOR MINOR PATCH SPECIAL

    echo ${data[0]} $MAJOR $MINOR $PATCH $SPECIAL >> semvers
done < versions