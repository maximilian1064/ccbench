#!/bin/bash

input=$1

grep -E "\[01\]" $input | grep -E "0-10" > .temp

start=1
for i in 2 4 8 12 16; do
    echo "#cores: $i"

    end=$(echo "$start + $i * 2 - 1" | bc)

    sed -n "$start,$end p" .temp > .temp2
    grep -o 'avg:[ ]*[0-9.]*' .temp2 | grep -o '[0-9.]*' > .temp3
    sum=$(awk '{sum+=$1} END {print sum}' .temp3)
    count=$(echo "$i * 2" | bc)
    echo $(python3 -c "print($sum/$count)")

    start=$(echo "$end + 1" | bc)
done
