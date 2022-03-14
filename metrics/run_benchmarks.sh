#!/usr/bin/env bash

rm -f time.bash.csv
for dir in ../benchmarks/*; do
    if [[ "$dir" == "../benchmarks/CompatibilityTest" ]]; then
        continue
    fi

    echo $dir
    for c_file in $dir/*.c; do
        clang -O3 $c_file -o $c_file.o3.out &>/dev/null
        clang -O0 $c_file -o $c_file.o0.out &>/dev/null
    done
    for opt in $dir/*.opt.s; do
        clang -m32 $opt -o $opt.out &>/dev/null
    done
    for reg in $dir/*.reg.s; do
        clang -m32 $reg -o $reg.out &>/dev/null
    done
    for stack in $dir/*.stack.s; do
        clang -m32 $stack -o $stack.out &>/dev/null
    done


    for i in {1..10}; do
        echo $i
        for outfile in $dir/*.out; do
            v=$((time $outfile < $dir/input.longer >/dev/null) 2>&1)
            echo $outfile ", " $v >> time.bash.csv
        done
    done
done

