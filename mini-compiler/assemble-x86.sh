#!/bin/bash

arm-linux-gnueabi-as -o $1.o $1.s
arm-linux-gnueabi-gcc -o $1 $1.o
qemu-arm -L /usr/arm-linux-gnueabi/ ./$1
echo $?
