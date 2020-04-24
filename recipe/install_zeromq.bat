setlocal EnableDelayedExpansion
@echo on

cd build
cmake -P gr-zeromq/cmake_install.cmake
if errorlevel 1 exit 1
