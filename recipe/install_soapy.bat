setlocal EnableDelayedExpansion
@echo on

cd build
cmake -P gr-soapy/cmake_install.cmake
if %ERRORLEVEL% NEQ 0 exit 1
