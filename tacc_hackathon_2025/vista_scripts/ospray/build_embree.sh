#!/bin/bash

ml purge

#######################GIT#################################
#cd src
#git clone https://github.com/embree/embree.git
##################Karolina################################

cd /scratch/project/open-30-28/milanjaros/TACC/projects

ROOT_DIR=${PWD}

ml tbb/2021.10.0-GCCcore-12.2.0
ml VirtualGL/3.1-GCC-12.3.0

ml Qt5/5.15.7-GCCcore-12.2.0
ml Mesa/22.2.4-GCCcore-12.2.0

ml CMake/3.31.3-GCCcore-14.2.0
ml OpenMPI/4.1.6-NVHPC-24.1-CUDA-12.4.0
ml CUDA/12.8.0
ml GCC/14.2.0

export CC=gcc
export CXX=g++

##################################################

lib_dir=${ROOT_DIR}/install
output=${ROOT_DIR}/install/embree
src=${ROOT_DIR}/src

#export CUDA_ROOT=/usr/local/cuda
echo $CUDA_ROOT
export OptiX_INSTALL_DIR=$lib_dir/NVIDIA-OptiX-SDK-7.5.0-linux64-x86_64
export LD_LIBRARY_PATH=${OptiX_INSTALL_DIR}:${CUDA_ROOT}/lib64:$LD_LIBRARY_PATH
export PATH=${CUDA_ROOT}/bin:$PATH

#rm -rf build/embree

#-----------blender_client--------------
mkdir ${ROOT_DIR}/build/embree
cd ${ROOT_DIR}/build/embree

make_d="${src}/embree"

make_d="${make_d} -DCMAKE_BUILD_TYPE=RelWithDebInfo"
#make_d="${make_d} -DCMAKE_BUILD_TYPE=Release"
#make_d="${make_d} -DCMAKE_BUILD_TYPE=Debug"
make_d="${make_d} -DCMAKE_INSTALL_PREFIX=${output}"

make_d="${make_d} -DEMBREE_ISPC_SUPPORT=ON"
make_d="${make_d} -DEMBREE_ISPC_EXECUTABLE=${lib_dir}/ispc/bin/ispc"

make_d="${make_d} -DEMBREE_TUTORIALS:BOOL=OFF"
make_d="${make_d} -DEMBREE_TUTORIALS_GLFW:BOOL=OFF"
make_d="${make_d} -DEMBREE_TASKING_SYSTEM=INTERNAL"

cmake ${make_d}
#make clean
make -j 64 #6 #install
make install
