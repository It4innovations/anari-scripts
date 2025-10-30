#!/bin/bash

#ml purge

#######################GIT#################################
#cd src
#git clone -b devel https://github.com/ingowald/barney.git
#cd barney; git submodule update --init --force
##################Karolina################################
cd ~/scratch

ROOT_DIR=${PWD}

#ml tbb/2021.11.0-GCCcore-12.3.0
#ml Mesa/24.1.3-GCCcore-13.3.0

#ml CMake/3.31.3-GCCcore-14.2.0
#ml OpenMPI/5.0.5-NVHPC-24.3-CUDA-12.3.0
#ml CUDA/12.8.0
#ml GCC/14.2.0
#ml cuda/12.6

# export CC=gcc
# export CXX=g++
module load TACC gcc/13.2.0 cuda/12.8 python3/3.11.8 qt5/5.14.2

##################################################

lib_dir=${ROOT_DIR}/install
output=${ROOT_DIR}/install/barney
src=${ROOT_DIR}/src


#export CUDA_ROOT=/usr/local/cuda
#echo $CUDA_ROOT
#export OptiX_INSTALL_DIR=$lib_dir/NVIDIA-OptiX-SDK-9.0.0-linux64-aarch64
#export LD_LIBRARY_PATH=${OptiX_INSTALL_DIR}:${CUDA_ROOT}/lib64:$LD_LIBRARY_PATH
#export PATH=${CUDA_ROOT}/bin:$PATH

rm -rf build/barney
rm -rf install/barney

#-----------blender_client--------------
mkdir ${ROOT_DIR}/build/barney
cd ${ROOT_DIR}/build/barney

make_d="${src}/barney"

make_d="${make_d} -DCMAKE_BUILD_TYPE=RelWithDebInfo"
#make_d="${make_d} -DCMAKE_BUILD_TYPE=Release"
#make_d="${make_d} -DCMAKE_BUILD_TYPE=Debug"
make_d="${make_d} -DCMAKE_INSTALL_PREFIX=${output}"
make_d="${make_d} -DCMAKE_CUDA_ARCHITECTURES=90"

make_d="${make_d} -DBARNEY_BUILD_ANARI=ON"
make_d="${make_d} -DBARNEY_MPI=ON"
make_d="${make_d} -Danari_DIR=${lib_dir}/anari-sdk/lib64/cmake/anari-0.15.0"


cmake ${make_d}
#make clean
make -j 64 #install
make install

#cp -v ${output}/lib64/*.so $lib_dir/anari-sdk/lib64/.
