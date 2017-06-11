FROM ubuntu:latest

MAINTAINER Nitrax <nitrax@lokisec.fr>

RUN apt update
RUN apt -y install bsdmainutils unzip libc6-i386 lib32stdc++6 python man gdb git radare2

USER root

WORKDIR /opt
RUN git clone https://github.com/longld/peda.git peda
RUN echo "source /opt/peda/peda.py" >> ~/.gdbinit

VOLUME /tmp/data

WORKDIR /tmp/data