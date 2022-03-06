#!/usr/bin/env bash

for dir in ../benchmarks/*; do
    if [[ "$dir" == "../benchmarks/CompatibilityTest" ]]; then
        continue
    fi

    echo $dir
    for c_file in $dir/*.c; do
        clang -O3 $c_file -o $c_file.o3.out
        clang -O0 $c_file -o $c_file.o0.out
    done
    for opt in $dir/*.opt.s; do
        clang -m32 $opt -o $opt.out
    done
    for reg in $dir/*.opt.s; do
        clang -m32 $reg -o $reg.out
    done
    for stack in $dir/*.opt.s; do
        clang -m32 $stack -o $stack.out
    done


    for i in {1..10}; do
        for outfile in $dir/*.out; do
            v=$((time $outfile < $dir/input >/dev/null) 2>&1)
            echo $outfile ", " $v >> time.bash.csv
        done
    done
done
