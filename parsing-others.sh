#!/bin/bash

input=$1

grep -E "\[01\]|corex" $input | grep -E "0-10|corex" > .temp

for i in 2 4 8 12 16; do
    echo "#cores: $i"
    sum=0
    count=0
    for x in $(seq 0 $((i-1))); do
        for y in $(seq 0 $((i-1))); do
            if [ $x -eq $y ]; then
                continue
            fi

            grep -x -A 2 "corex $x corey $y" .temp | grep -o 'avg:[ ]*[0-9.]*' | grep -o '[0-9.]*' > .temp2
            temp=$(awk '{sum+=$1} END {print sum}' .temp2)
            sum=$(echo "$sum + $temp" | bc)
            count=$(( $count + 2 ))
        done
    done
    echo $(python3 -c "print($sum/$count)")
done
