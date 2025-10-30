#!/bin/bash

#ml purge

#######################GIT#################################
#cd src
#git clone -b develop https://github.com/Alpine-DAV/ascent
#cd ascent; git submodule update --init --force
##################Karolina################################

cd ~/scratch 

ROOT_DIR=${PWD}

ml CMake/3.29.3
#ml Ninja/1.12.1

ml foss/2024a
ml Python/3.12.3
ml SciPy-bundle/2024.05
ml Boost/1.85.0
ml XZ/5.4.5
ml HDF5/1.14.5
ml netCDF/4.9.2
ml libdrm/2.4.122
ml Mesa/24.1.3
ml Qt6/6.7.2
ml zlib/1.3.1
ml FFmpeg/7.0.2
ml Szip/2.1.1

ml OSPRay/3.2.0

ml GCC/13.3.0

export CC=gcc
export CXX=g++
##################################################

lib_dir=${ROOT_DIR}/install
output=${ROOT_DIR}/install/ascent
src=${ROOT_DIR}/src

#export CUDA_ROOT=/usr/local/cuda
# echo $CUDA_ROOT
# export OptiX_INSTALL_DIR=$lib_dir/NVIDIA-OptiX-SDK-7.5.0-linux64-x86_64
# export LD_LIBRARY_PATH=${OptiX_INSTALL_DIR}:${CUDA_ROOT}/lib64:$LD_LIBRARY_PATH
# export PATH=${CUDA_ROOT}/bin:$PATH

# rm -rf ${ROOT_DIR}/build/ascent
# rm -rf ${ROOT_DIR}/install/ascent

#-----------blender_client--------------
mkdir ${ROOT_DIR}/build/ascent
cd ${ROOT_DIR}/build/ascent

make_d="${src}/ascent/src"

make_d="${make_d} -DCMAKE_BUILD_TYPE=RelWithDebInfo"
#make_d="${make_d} -DCMAKE_BUILD_TYPE=Release"
#make_d="${make_d} -DCMAKE_BUILD_TYPE=Debug"
make_d="${make_d} -DCMAKE_INSTALL_PREFIX=${output}"

make_d="${make_d} -DENABLE_FORTRAN=OFF"
make_d="${make_d} -DENABLE_PYTHON=ON"
make_d="${make_d} -DENABLE_MPI=OFF"
make_d="${make_d} -DENABLE_SPHINX=OFF"
make_d="${make_d} -DENABLE_ANARI=ON"
make_d="${make_d} -DENABLE_VTKH=ON"

make_d="${make_d} -DConduit_DIR=${lib_dir}/conduit/lib/cmake/conduit"
make_d="${make_d} -DCONDUIT_DIR=${lib_dir}/conduit"
make_d="${make_d} -DVISKORES_DIR=${lib_dir}/viskores"
make_d="${make_d} -DANARI_DIR=${lib_dir}/anari-sdk"

make_d="${make_d} -Danari_DIR=${lib_dir}/anari-sdk/lib64/cmake/anari-0.15.0"

cmake ${make_d}
#make clean
make -j 64 install
