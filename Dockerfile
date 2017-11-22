FROM ubuntu:trusty

RUN \
  apt-get update && \
  apt-get install -y \
    software-properties-common && \
  add-apt-repository ppa:beineri/opt-qt551-trusty && \
  apt-get update && \
  apt-get install -y \
    build-essential \
    clang \
    g++-4.8 \
    libboost-all-dev \
    libevent-dev \
    libudev-dev \
    libusb-1.0.0-dev \
    qt55base \
    qt55tools \
    qt55multimedia \
    libqrencode-dev
