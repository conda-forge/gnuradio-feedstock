#!/usr/bin/env bash

mkdir build
cd build
# enable gnuradio components explicitly so we get build error when unsatisfied
# the following are disabled:
#   DOXYGEN because we don't need docs in the conda package
#   TESTING because we don't intend to run the unit tests, just import test
# the following can be disabled to speed up the build (dependencies remain in
# meta.yaml):
#   GR_CTRLPORT
#   GR_DTV
#   GR_FEC
#   GR_TRELLIS
#   GR_VIDEO_SDL
#   GR_VOCODER
#   GR_WAVELET
#   GR_ZEROMQ
cmake_config_args=(
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_PREFIX_PATH=$PREFIX
    -DCMAKE_INSTALL_PREFIX=$PREFIX
    -DLIB_SUFFIX=""
    -DPYTHON_EXECUTABLE=$PYTHON
    -DBoost_NO_BOOST_CMAKE=ON
    -DGR_PYTHON_DIR=$SP_DIR
    -DENABLE_CTRLPORT_THRIFT=ON
    -DENABLE_DOXYGEN=OFF
    -DENABLE_EXAMPLES=ON
    -DENABLE_GNURADIO_RUNTIME=ON
    -DENABLE_GR_ANALOG=ON
    -DENABLE_GR_AUDIO=ON
    -DENABLE_GR_BLOCKS=ON
    -DENABLE_GR_BLOCKTOOL=ON
    -DENABLE_GR_CHANNELS=ON
    -DENABLE_GR_CTRLPORT=ON
    -DENABLE_GR_DIGITAL=ON
    -DENABLE_GR_DTV=ON
    -DENABLE_GR_FEC=ON
    -DENABLE_GR_FFT=ON
    -DENABLE_GR_FILTER=ON
    -DENABLE_GR_MODTOOL=ON
    -DENABLE_GR_NETWORK=ON
    -DENABLE_GR_TRELLIS=ON
    -DENABLE_GR_UHD=ON
    -DENABLE_GR_UTILS=ON
    -DENABLE_GR_VIDEO_SDL=ON
    -DENABLE_GR_VOCODER=ON
    -DENABLE_GR_WAVELET=ON
    -DENABLE_GR_ZEROMQ=ON
    -DENABLE_GRC=ON
    -DENABLE_POSTINSTALL=OFF
    -DENABLE_PYTHON=ON
    -DENABLE_TESTING=OFF
)

if [[ $target_platform == linux-ppc64le ]] || [[ $target_platform == osx-arm64 ]] ; then
    cmake_config_args+=(
        -DENABLE_GR_QTGUI=OFF
    )
else
    cmake_config_args+=(
        -DENABLE_GR_QTGUI=ON
    )
fi

cmake ${CMAKE_ARGS} -G "Ninja" .. "${cmake_config_args[@]}"
cmake --build . --config Release -- -j${CPU_COUNT}
