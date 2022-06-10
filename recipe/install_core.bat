setlocal EnableDelayedExpansion
@echo on

cd build

cmake -DCMAKE_INSTALL_LOCAL_ONLY=1 -P cmake_install.cmake
if errorlevel 1 exit 1
cmake -P docs/cmake_install.cmake
if errorlevel 1 exit 1
cmake -P gnuradio-runtime/cmake_install.cmake
if errorlevel 1 exit 1
cmake -P gr-analog/cmake_install.cmake
if errorlevel 1 exit 1
cmake -P gr-audio/cmake_install.cmake
if errorlevel 1 exit 1
cmake -P gr-blocks/cmake_install.cmake
if errorlevel 1 exit 1
cmake -P gr-channels/cmake_install.cmake
if errorlevel 1 exit 1
cmake -P gr-digital/cmake_install.cmake
if errorlevel 1 exit 1
cmake -P gr-dtv/cmake_install.cmake
if errorlevel 1 exit 1
cmake -P gr-fec/cmake_install.cmake
if errorlevel 1 exit 1
cmake -P gr-fft/cmake_install.cmake
if errorlevel 1 exit 1
cmake -P gr-filter/cmake_install.cmake
if errorlevel 1 exit 1
cmake -P gr-network/cmake_install.cmake
if errorlevel 1 exit 1
cmake -P gr-pdu/cmake_install.cmake
if errorlevel 1 exit 1
cmake -P gr-trellis/cmake_install.cmake
if errorlevel 1 exit 1
cmake -P gr-utils/bindtool/cmake_install.cmake
if errorlevel 1 exit 1
cmake -P gr-utils/blocktool/cmake_install.cmake
if errorlevel 1 exit 1
cmake -P gr-utils/modtool/cmake_install.cmake
if errorlevel 1 exit 1
cmake -P gr-utils/read_file_metadata/cmake_install.cmake
if errorlevel 1 exit 1
cmake -P gr-vocoder/cmake_install.cmake
if errorlevel 1 exit 1
cmake -P gr-wavelet/cmake_install.cmake
if errorlevel 1 exit 1

:: remove gr_filter_design script and put in qtgui because of dependencies
cmake -E rm -f %LIBRARY_BIN%/gr_filter_design.py %LIBRARY_BIN%/gr_filter_design.exe
if errorlevel 1 exit 1
