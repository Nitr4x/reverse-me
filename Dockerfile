FROM debian:latest

MAINTAINER Nitrax <nitrax@lokisec.fr>

RUN echo 'deb  http://deb.debian.org/debian stretch main contrib non-free' > /etc/apt/sources.list
RUN echo 'deb-src  http://deb.debian.org/debian stretch main contrib non-free' >> /etc/apt/sources.list

RUN echo 'deb  http://deb.debian.org/debian stretch-updates main contrib non-free' >> /etc/apt/sources.list
RUN echo 'deb-src  http://deb.debian.org/debian stretch-updates main contrib non-free' >> /etc/apt/sources.list

RUN echo 'deb http://security.debian.org/ stretch/updates main contrib non-free' >> /etc/apt/sources.list
RUN echo 'deb-src http://security.debian.org/ stretch/updates main contrib non-free' >> /etc/apt/sources.list

RUN apt update

# Installing tools and dependancies
RUN apt -y install libc-dev dpkg-dev g++ build-essential bsdmainutils unzip python man gdb git radare2 strace emacs gcc valgrind wget curl python-pip python3 libssl-dev libffi-dev qemu binfmt-support qemu-user-static htop tmux vim locales

# 32bit support
RUN apt -y install libc6-i386 lib32stdc++6 libc6-dev-i386

USER root

# Setting fish shell
RUN echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/2/Debian_8.0/ /' >> /etc/apt/sources.list.d/fish.list
RUN wget -qO - http://download.opensuse.org/repositories/shells:fish:release:2/Debian_8.0/Release.key | apt-key add -
RUN apt update
RUN apt -y install fish
ADD conf/conf.fish /root/.config/fish/conf.d/

WORKDIR /opt

# Install oh-my-fish
RUN git clone https://github.com/oh-my-fish/oh-my-fish omf
RUN /opt/omf/bin/install --offline --noninteractive
RUN echo "omf install godfather" | fish

# Installing peda
RUN git clone https://github.com/longld/peda.git peda
RUN echo "source /opt/peda/peda.py" >> ~/.gdbinit

# Install uncompyle6
RUN git clone https://github.com/rocky/python-uncompyle6.git uncompyle
WORKDIR /opt/uncompyle
RUN pip install -e .
RUN pip install -r requirements-dev.txt
RUN python setup.py install

# Install pwntools
RUN pip install pwntools

# Setting tmux
ADD conf/locale.gen /etc/
ADD conf/.tmux.conf /root/
RUN locale-gen

VOLUME /tmp/data

WORKDIR /tmp/data