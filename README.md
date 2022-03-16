# CSC431 Mini Compiler
Alex MacLean and Bailey Wickham

## Running the compiler
```
cd mini-compiler
racket main.rkt <mini file>
```
```
usage: mini-compiler [ <option> ... ] <filename>

<option> is one of

  --stack
     Compile with stack allocation
  --llvm
     Compile with LLVM output
  --debug
     Compile with debugging on
  --optimize
     Compile with optimizations on
  --skip-assemble
     Skip assembly step
  --help, -h
     Show this help
```

## Testing with benchmarks
This tests each of the benchmarks, diffing the output with the expected output.

```
cd mini-compiler
racket benchmarks.rkt
```
```
usage: benchmark [ <option> ... ]

<option> is one of

  -l, --list
     List tests, but do not run
  -r <pat>, --regexp <pat>
     Regexp pattern to use for test selection
  -e, --error
     Throw errors and stop on failed tests
  -s, --stack
     Compile in stack mode
  --llvm
     Execute LLVM-ir with clang
  --build
     Build benchmark for timing
  --help, -h
     Show this help
```

## Running benchmarks with times
### On the Raspberry Pi
On an x86 computer, generate the `.s` files with `racket benchmarks.rkt --build`.
```
cd metrics
./pi_benchmarks.sh
cat times.bash.csv
```

### With Docker
```
./docker_run.sh
```
