#!/bin/bash

cd build

cmake -DCMAKE_INSTALL_LOCAL_ONLY=1 -P cmake_install.cmake
cmake -P docs/cmake_install.cmake
cmake -P gnuradio-runtime/cmake_install.cmake
cmake -P gr-analog/cmake_install.cmake
cmake -P gr-audio/cmake_install.cmake
cmake -P gr-blocks/cmake_install.cmake
cmake -P gr-channels/cmake_install.cmake
cmake -P gr-digital/cmake_install.cmake
cmake -P gr-dtv/cmake_install.cmake
cmake -P gr-fec/cmake_install.cmake
cmake -P gr-fft/cmake_install.cmake
cmake -P gr-filter/cmake_install.cmake
cmake -P gr-network/cmake_install.cmake
cmake -P gr-pdu/cmake_install.cmake
cmake -P gr-trellis/cmake_install.cmake
cmake -P gr-utils/bindtool/cmake_install.cmake
cmake -P gr-utils/blocktool/cmake_install.cmake
cmake -P gr-utils/modtool/cmake_install.cmake
cmake -P gr-utils/read_file_metadata/cmake_install.cmake
cmake -P gr-vocoder/cmake_install.cmake
cmake -P gr-wavelet/cmake_install.cmake

# remove gr_filter_design script and put in qtgui because of dependencies
cmake -E rm $PREFIX/bin/gr_filter_design
