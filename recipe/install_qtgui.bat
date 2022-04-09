setlocal EnableDelayedExpansion
@echo on

if not exist "%PREFIX%\Menu" mkdir "%PREFIX%\Menu"
copy "%RECIPE_DIR%\menus\menu-gr_filter_design-windows.json" "%PREFIX%\Menu"

cd build
cmake -P gr-qtgui/cmake_install.cmake
if errorlevel 1 exit 1
cmake -P gr-utils/plot_tools/cmake_install.cmake
if errorlevel 1 exit 1
:: install gr-filter apps to add previously-deleted gr_filter_design
cmake -P gr-filter/apps/cmake_install.cmake
if errorlevel 1 exit 1
