#!/bin/bash
for i in {5..1}; do
    for  in $(seq 1 $i); do
        echo -n "*"
    done
    echo ""
done
