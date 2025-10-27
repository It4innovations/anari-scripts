#!/bin/bash

#ml purge

#######################GIT#################################
#cd src
#git clone -b next_release https://github.com/KhronosGroup/ANARI-SDK.git
##################Karolina################################

cd ~/scratch

ROOT_DIR=${PWD}

#ml tbb/2021.11.0-GCCcore-12.3.0
#ml Mesa/24.1.3-GCCcore-13.3.0

#ml CMake/3.31.3-GCCcore-14.2.0
#ml OpenMPI/5.0.5-NVHPC-24.3-CUDA-12.3.0
#ml CUDA/12.8.0
#ml GCC/14.2.0

# ml CUDA/12.8.0
# ml GLFW/3.4-GCCcore-13.3.0
# ml Mesa/24.1.3-GCCcore-13.3.0
# ml embree/4.4.0-GCCcore-13.3.0

#export EMBREE_MAX_ISA="NEON"

ml cmake/3.31.5
ml gcc/13.2.0

export CC=gcc
export CXX=g++

##################################################

lib_dir=${ROOT_DIR}/install
output=${ROOT_DIR}/install/anari-sdk
src=${ROOT_DIR}/src

#export CUDA_ROOT=/usr/local/cuda
#echo $CUDA_ROOT
#export OptiX_INSTALL_DIR=$lib_dir/NVIDIA-OptiX-SDK-7.5.0-linux64-x86_64
#export LD_LIBRARY_PATH=${OptiX_INSTALL_DIR}:${CUDA_ROOT}/lib64:$LD_LIBRARY_PATH
#export PATH=${CUDA_ROOT}/bin:$PATH

rm -rf ${ROOT_DIR}/build/anari-sdk
rm -rf ${ROOT_DIR}/install/anari-sdk

#-----------blender_client--------------
# mkdir ${ROOT_DIR}/build/anari-sdk
# cd ${ROOT_DIR}/build/anari-sdk

make_d="${src}/ANARI-SDK"

make_d="${make_d} -DCMAKE_BUILD_TYPE=RelWithDebInfo"
#make_d="${make_d} -DCMAKE_BUILD_TYPE=Release"
#make_d="${make_d} -DCMAKE_BUILD_TYPE=Debug"
make_d="${make_d} -DCMAKE_INSTALL_PREFIX=${output}"
#make_d="${make_d} -DCMAKE_CUDA_ARCHITECTURES=80"

#make_d="${make_d} -DBUILD_TESTING=ON"
# make_d="${make_d} -DBUILD_VIEWER=OFF"
# make_d="${make_d} -DBUILD_EXAMPLES=OFF"
# make_d="${make_d} -DBUILD_HELIDE_DEVICE=OFF"

make_d="${make_d} -DEMBREE_ISA_NEON=ON"
make_d="${make_d} -DEMBREE_MAX_ISA=NEON"

cmake ${make_d}
#make clean
make -j 32 install
