FROM debian:latest

MAINTAINER Nitrax <nitrax@lokisec.fr>

RUN apt update
RUN apt -y install libc-dev dpkg-dev g++ build-essential bsdmainutils unzip python man gdb git radare2 strace emacs gcc valgrind

# 32bit support
RUN apt -y install libc6-i386 lib32stdc++6 libc6-dev-i386

USER root

WORKDIR /opt
RUN git clone https://github.com/longld/peda.git peda
RUN echo "source /opt/peda/peda.py" >> ~/.gdbinit

VOLUME /tmp/data

WORKDIR /tmp/data