setlocal EnableDelayedExpansion
@echo on

:: Make a build folder and change to it
mkdir build
if errorlevel 1 exit 1
cd build
if errorlevel 1 exit 1

:: configure
:: enable gnuradio components explicitly so we get build error when unsatisfied
:: the following are disabled:
::   DOXYGEN because we don't need docs in the conda package
::   TESTING because we don't intend to run the unit tests, just import test
:: the following can be disabled to speed up the build (dependencies remain in
:: meta.yaml):
::   GR_CTRLPORT
::   GR_DTV
::   GR_FEC
::   GR_TRELLIS
::   GR_VIDEO_SDL
::   GR_VOCODER
::   GR_WAVELET
::   GR_ZEROMQ
::   GRC
cmake -G "Ninja" ^
    -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_BUILD_TYPE:STRING=Release ^
    -DPYTHON_EXECUTABLE:PATH="%PYTHON%" ^
    -DBoost_NO_BOOST_CMAKE=ON ^
    -DGR_PYTHON_DIR:PATH="%SP_DIR%" ^
    -DENABLE_CTRLPORT_THRIFT=OFF ^
    -DENABLE_DOXYGEN=OFF ^
    -DENABLE_EXAMPLES=ON ^
    -DENABLE_GNURADIO_RUNTIME=ON ^
    -DENABLE_GR_ANALOG=ON ^
    -DENABLE_GR_AUDIO=ON ^
    -DENABLE_GR_BLOCKS=ON ^
    -DENABLE_GR_BLOCKTOOL=ON ^
    -DENABLE_GR_CHANNELS=ON ^
    -DENABLE_GR_CTRLPORT=ON ^
    -DENABLE_GR_DIGITAL=ON ^
    -DENABLE_GR_DTV=ON ^
    -DENABLE_GR_FEC=ON ^
    -DENABLE_GR_FFT=ON ^
    -DENABLE_GR_FILTER=ON ^
    -DENABLE_GR_MODTOOL=ON ^
    -DENABLE_GR_NETWORK=ON ^
    -DENABLE_GR_QTGUI=ON ^
    -DENABLE_GR_SOAPY=ON ^
    -DENABLE_GR_TRELLIS=ON ^
    -DENABLE_GR_UHD=ON ^
    -DENABLE_GR_UTILS=ON ^
    -DENABLE_GR_VIDEO_SDL=ON ^
    -DENABLE_GR_VOCODER=ON ^
    -DENABLE_GR_WAVELET=ON ^
    -DENABLE_GR_ZEROMQ=ON ^
    -DENABLE_GRC=ON ^
    -DENABLE_POSTINSTALL=OFF ^
    -DENABLE_PYTHON=ON ^
    -DENABLE_TESTING=OFF ^
    ..
if errorlevel 1 exit 1

:: build
cmake --build . --config Release -- -j%CPU_COUNT%
if errorlevel 1 exit 1

:: remove intermediate build outputs to save disk space
del /s /q "*.obj"
if errorlevel 1 exit 1
