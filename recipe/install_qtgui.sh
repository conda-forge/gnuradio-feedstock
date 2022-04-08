#!/bin/bash

cd build
cmake -P gr-qtgui/cmake_install.cmake
cmake -P gr-utils/plot_tools/cmake_install.cmake
