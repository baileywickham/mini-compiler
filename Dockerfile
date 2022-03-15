FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install -qqq software-properties-common
RUN add-apt-repository ppa:plt/racket
RUN apt-get update
RUN apt-get install -qqq racket gcc-arm-linux-gnueabihf gcc-arm-linux-gnueabi qemu-user
RUN apt-get install -qqq default-jre
RUN raco pkg install --auto graph
RUN raco pkg install --auto threading-lib
COPY . /home/user
WORKDIR /home/user/mini-compiler
RUN raco make benchmarks.rkt

ENTRYPOINT ./run_benchmarks.sh

