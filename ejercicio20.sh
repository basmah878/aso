#!/bin/bash
n=$1
if [ $n -lt 2 ]; then echo "$n no es primo"; exit; fi
for ((i=2;i<=n/2;i++)); do
    [ $((n%i)) -eq 0 ] && echo "$n no es primo" && exit
done
echo "$n es primo"
