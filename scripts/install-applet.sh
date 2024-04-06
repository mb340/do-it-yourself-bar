#!/bin/sh
mkdir -p build && \
cd build && \
cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_BUILD_TYPE=Release -DQT_MAJOR_VERSION=6 -DBUILD_WITH_QT6=ON .. && \
make clean && \
make && \
sudo make install
cd ..
