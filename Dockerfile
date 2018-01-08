FROM ubuntu:trusty

RUN \
  apt-get update && \
  apt-get install -y \
    software-properties-common && \
  add-apt-repository ppa:beineri/opt-qt551-trusty && \
  apt-get update && \
  apt-get install -y \
    autotools-dev \
    automake \
    build-essential \
    clang \
    libcurl4-openssl-dev \
    gcc-4.8 \
    g++-4.8 \
    libboost-all-dev \
    libevent-dev \
    libudev-dev \
    libtool \
    libusb-1.0.0-dev \
    pkg-config \
    qtbase5-dev \
    qttools5-dev-tools \
    qt5-qmake \
    qt55base \
    qt55tools \
    qt55multimedia \
    libqrencode-dev \
    strace

COPY src /usr/src
WORKDIR /usr/src

RUN ./autogen.sh && ./configure --enable-debug --enable-libusb && make
