#!/usr/bin/env bash

function compile() {
    arm-linux-gnueabi-as -o $1.o $1
    arm-linux-gnueabi-gcc -o $1.out $1.o
}



rm -f time.bash.csv
for dir in ../benchmarks/*; do
    if [[ "$dir" == "../benchmarks/CompatibilityTest" ]]; then
        continue
    fi

    for opt in $dir/*.opt.s; do
        compile $opt
    done
    for reg in $dir/*.reg.s; do
        compile $reg
    done
    for stack in $dir/*.stack.s; do
        compile $stack
    done


    for i in {1..10}; do
        for outfile in $dir/*.out; do
            echo -n $outfile ", "
            v=$((time qemu-arm -L /usr/arm-linux-gnueabi $outfile < $dir/input > /dev/null) 2>&1)
            echo $v
        done
    done
done


