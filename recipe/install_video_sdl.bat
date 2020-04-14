setlocal EnableDelayedExpansion

cd build
cmake -P gr-video-sdl/cmake_install.cmake
if errorlevel 1 exit 1
