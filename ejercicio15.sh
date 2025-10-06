#!/bin/bash
n=$1
for i in {1..10}; do
    echo "$i x $n = $((i*n))"
done
