#!/bin/bash

for cores in 2 4 8 12 16; do
    echo "cores $cores"
    num_iterations=$(( $cores - 1 ))
    for ((write_core=0; write_core<=$num_iterations; write_core++)); do
        echo "write_core $write_core"
        ./ccbench -t3 -e8 -r1000 -f -s32768 -c$cores -y$write_core
        ./ccbench -t3 -e8 -r1000 -f -s32768 -c$cores -y$write_core
    done
done
