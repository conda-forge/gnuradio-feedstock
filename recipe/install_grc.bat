setlocal EnableDelayedExpansion
@echo on

if not exist "%PREFIX%\Menu" mkdir "%PREFIX%\Menu"
copy "%RECIPE_DIR%\menus\gnuradio-grc.json" "%PREFIX%\Menu"
copy "%RECIPE_DIR%\menus\grc.ico" "%PREFIX%\Menu"
if errorlevel 1 exit 1

cd build
cmake -P grc/cmake_install.cmake
if errorlevel 1 exit 1
