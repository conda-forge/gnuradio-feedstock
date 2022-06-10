#!/bin/bash

cd build
cmake -P gr-qtgui/cmake_install.cmake
cmake -P gr-utils/plot_tools/cmake_install.cmake
# install gr-filter apps to add previously-deleted gr_filter_design
cmake -P gr-filter/cmake_install.cmake
