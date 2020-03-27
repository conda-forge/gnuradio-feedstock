setlocal EnableDelayedExpansion

cd build
cmake -P grc/cmake_install.cmake
if errorlevel 1 exit 1
