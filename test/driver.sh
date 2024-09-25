#!/bin/bash
tmp=`mktemp -d /tmp/chibicc-test-XXXXXX`
echo "tmp declared is $tmp"
trap 'rm -rf $tmp' INT TERM HUP EXIT 
echo > $tmp/empty.c
check(){
    if [ $? -eq 0 ];then
        echo "testing $1 ... passed"
    else
        echo "testing $2 ... failed"
        exit 1
    fi
}

rm -f $tmp/out

./chibicc -o $tmp/out $tmp/empty.c
[ -f $tmp/out ]
check -o

./chibicc --help 2>&1 | grep -q chibicc
check --help

echo OK