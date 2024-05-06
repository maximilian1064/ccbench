#!/bin/bash

num_cores=16

for ((corex = 0 ; corex < $num_cores ; corex++)); do
    for ((corey = 0 ; corey < $num_cores ; corey++)); do
        if [[ $corex != $corey ]]; then
            echo "corex $corex corey $corey"
            ./ccbench -t7 -e8 -r1000 -f -s32768 -x$corex -y$corey
            ./ccbench -t7 -e8 -r1000 -f -s32768 -x$corex -y$corey
        fi
    done
done
