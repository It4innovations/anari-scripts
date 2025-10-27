#!/bin/bash

ml purge

#######################GIT#################################
#cd src
#git clone https://github.com/ospray/rkcommon.git 
##################Karolina################################

cd /scratch/project/open-30-28/milanjaros/TACC/projects

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

ml GCC/13.3.0

export CC=gcc
export CXX=g++

export CC=gcc
export CXX=g++

##################################################

lib_dir=${ROOT_DIR}/install
output=${ROOT_DIR}/install/rkcommon
src=${ROOT_DIR}/src

#export CUDA_ROOT=/usr/local/cuda
echo $CUDA_ROOT
export OptiX_INSTALL_DIR=$lib_dir/NVIDIA-OptiX-SDK-7.5.0-linux64-x86_64
export LD_LIBRARY_PATH=${OptiX_INSTALL_DIR}:${CUDA_ROOT}/lib64:$LD_LIBRARY_PATH
export PATH=${CUDA_ROOT}/bin:$PATH

#rm -rf build/rkcommon

#-----------blender_client--------------
mkdir ${ROOT_DIR}/build/rkcommon
cd ${ROOT_DIR}/build/rkcommon

make_d="${src}/rkcommon"

make_d="${make_d} -DCMAKE_BUILD_TYPE=RelWithDebInfo"
#make_d="${make_d} -DCMAKE_BUILD_TYPE=Release"
#make_d="${make_d} -DCMAKE_BUILD_TYPE=Debug"
make_d="${make_d} -DCMAKE_INSTALL_PREFIX=${output}"


cmake ${make_d}
#make clean
make -j 16 #6 #install
make install
