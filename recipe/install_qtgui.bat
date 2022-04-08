setlocal EnableDelayedExpansion
@echo on

if not exist "%PREFIX%\Menu" mkdir "%PREFIX%\Menu"
copy "%RECIPE_DIR%\menus\menu-gr_filter_design-windows.json" "%PREFIX%\Menu"

cd build
cmake -P gr-qtgui/cmake_install.cmake
if errorlevel 1 exit 1
cmake -P gr-utils/plot_tools/cmake_install.cmake
if errorlevel 1 exit 1
