#!/bin/bash

#ml purge

#######################GIT#################################
#cd src
#git clone https://github.com/it4innovations/cyclesphi-anari.git
##################Karolina################################

export MODULEPATH=/home1/07881/jar091/scratch/easybuild/easybuild/modules/all:$MODULEPATH

cd ~/scratch

ROOT_DIR=${PWD}

ml CMake/3.29.3

# ml Brotli/1.1.0-GCCcore-13.3.0
ml embree/4.4.0-GCCcore-13.3.0
# ml FFmpeg/7.0.2-GCCcore-13.3.0
# ml fftw3/3.3.10
# ml freetype/2.13.2-GCCcore-13.3.0
# ml FriBidi/1.0.15-GCCcore-13.3.0
# ml GMP/6.3.0-GCCcore-13.3.0
# ml HarfBuzz/9.0.0-GCCcore-13.3.0
ml libepoxy/1.5.10-GCCcore-13.3.0
# ml libjpeg-turbo/3.0.1-GCCcore-13.3.0
# ml libpng/1.6.43-GCCcore-13.3.0
# ml LibTIFF/4.6.0-GCCcore-13.3.0
# ml libwebp/1.4.0-GCCcore-13.3.0
# ml libxml2/2.12.7-GCCcore-13.3.0
# ml LLVM/18.1.8-GCCcore-13.3.0
# ml Mesa/24.1.3-GCCcore-13.3.0
# ml Python/3.12.3-GCCcore-13.3.0
# ml SDL2/2.30.6-GCCcore-13.3.0
# ml tbb/2021.13.0-GCCcore-13.3.0
# ml Wayland/1.23.0-GCCcore-13.3.0
# ml zlib/1.3.1-GCCcore-13.3.0
# ml zstd/1.5.6-GCCcore-13.3.0
ml OpenImageIO/2.5.15.0-GCC-13.3.0
ml pugixml/1.15-GCCcore-13.3.0
ml OpenJPEG/2.5.2-GCCcore-13.3.0
ml OpenColorIO/2.4.2-GCC-13.3.0

ml OpenVDB/11.0.0-foss-2024a
ml ANARI-SDK/0.15.0

ml CUDA/12.8.0
ml GCC/13.3.0

export CC=gcc
export CXX=g++
##################################################

lib_dir=${ROOT_DIR}/install
output=${ROOT_DIR}/install/cycles_anari
src=${ROOT_DIR}/src

#export CUDA_ROOT=/usr/local/cuda
#echo $CUDA_ROOT
export OptiX_INSTALL_DIR=$lib_dir/NVIDIA-OptiX-SDK-9.0.0-linux64-aarch64
#export LD_LIBRARY_PATH=${OptiX_INSTALL_DIR}:${CUDA_ROOT}/lib64:$LD_LIBRARY_PATH:${lib_dir}/anari-sdk/lib64:${lib_dir}/barney/lib64
#export PATH=${CUDA_ROOT}/bin:$PATH
# export ANARI_LIBRARY=helide
# export CMAKE_CONFIGURATION="helide"

# rm -rf ${ROOT_DIR}/build/cycles_anari
# rm -rf ${ROOT_DIR}/install/cycles_anari

#-----------blender_client--------------
mkdir ${ROOT_DIR}/build/cycles_anari
cd ${ROOT_DIR}/build/cycles_anari

make_d="${src}/cyclesphi-anari"

make_d="${make_d} -DCMAKE_BUILD_TYPE=RelWithDebInfo"

make_d="${make_d} -DCMAKE_INSTALL_PREFIX=${output}"

make_d="${make_d} -DWITH_CYCLES_CUDA_BINARIES=ON"
make_d="${make_d} -DCYCLES_CUDA_BINARIES_ARCH=sm_90"

make_d="${make_d} -DOPTIX_ROOT_DIR=${OptiX_INSTALL_DIR}"

make_d="${make_d} -DPYTHON_VERSION=3.12"
make_d="${make_d} -DPYTHON_EXECUTABLE=/scratch/07881/jar091/easybuild/easybuild/software/Python/3.12.3-GCCcore-13.3.0/bin/python"

make_d="${make_d} -DWITH_CYCLES_OSL=OFF"
make_d="${make_d} -DWITH_CYCLES_OPENSUBDIV=OFF"
make_d="${make_d} -DWITH_CYCLES_OPENVDB=ON"
make_d="${make_d} -DWITH_CYCLES_USD=OFF"
make_d="${make_d} -DWITH_CYCLES_NANOVDB=ON"
make_d="${make_d} -DWITH_CYCLES_OPENIMAGEDENOISE=OFF"
make_d="${make_d} -DWITH_CYCLES_ALEMBIC=OFF"


cmake ${make_d}
#make clean
make -j 64 install
