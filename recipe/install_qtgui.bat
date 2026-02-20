setlocal EnableDelayedExpansion
@echo on

if not exist "%PREFIX%\Menu" mkdir "%PREFIX%\Menu"
copy "%RECIPE_DIR%\menus\gnuradio-qtgui.json" "%PREFIX%\Menu"

cd build
cmake -P gr-qtgui/cmake_install.cmake
if %ERRORLEVEL% NEQ 0 exit 1
cmake -P gr-utils/plot_tools/cmake_install.cmake
if %ERRORLEVEL% NEQ 0 exit 1
:: install gr-filter apps to add previously-deleted gr_filter_design
cmake -P gr-filter/apps/cmake_install.cmake
if %ERRORLEVEL% NEQ 0 exit 1

:: Add workaround for PyQt5 bug that causes directories on PATH with Qt5Core.dll
:: to be preferred in the DLL search order, breaking library loading when a user
:: has an externally-bundled Qt on their path and that directory contains other
:: libraries that qtgui tries to load.
:: See https://github.com/ryanvolz/radioconda/issues/78
:: See https://github.com/conda-forge/pyqt-feedstock/issues/138
cmake -E touch "%PREFIX%\Library\bin\Qt5Core.dll"
