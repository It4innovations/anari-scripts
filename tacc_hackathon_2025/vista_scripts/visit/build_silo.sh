#!/bin/bash

ml purge

#######################GIT#################################
#cd src
#git clone https://github.com/LLNL/Silo
#cd silo; git submodule update --init --force
##################Karolina################################

cd ~/scratch/

ROOT_DIR=${PWD}

# ml tbb/2021.10.0-GCCcore-12.2.0
# ml VirtualGL/3.1-GCC-12.3.0

# #ml Qt5/5.15.7-GCCcore-12.2.0
# ml Qt6/6.7.2-GCCcore-13.3.0
# ml Mesa/22.2.4-GCCcore-12.2.0

# ml CMake/3.31.3-GCCcore-14.2.0
# ml OpenMPI/4.1.6-NVHPC-24.1-CUDA-12.4.0
# # ml HDF5/1.14.3-NVHPC-24.1-CUDA-12.4.0
# ml Python/3.10.8-GCCcore-12.2.0
# ml CUDA/12.8.0
# ml GCC/14.2.0

ml CMake/3.29.3-GCCcore-13.3.0
ml Python/3.12.3
ml SciPy-bundle/2024.05
ml zlib/1.3.1    
ml Python-bundle-PyPI/2024.06    
ml X11/20240607
ml Mesa/24.1.3
ml libglvnd/1.7.0
#ml Qt5/5.15.16
ml Qt6
#ml Qwt/6.3.0 # TODO: MJ
# silo-3.4.1 needs VTK-9.2.x (not 9.3.x) - https://github.com/silo-dav/silo/issues/19547
#ml VTK/9.3.1 # TODO: MJ
#ml VTK/9.5.0
ml VTK/9.5.0-foss-2024a
ml FFmpeg/7.0.2
ml HDF5/1.14.5
ml Boost/1.85.0

ml ANARI-SDK/0.15.0

ml CMake/3.29.3
ml GCC/13.3.0

export CC=gcc
export CXX=g++
##################################################

lib_dir=${ROOT_DIR}/install
output=${ROOT_DIR}/install/silo
src=${ROOT_DIR}/src

#export CUDA_ROOT=/usr/local/cuda
# echo $CUDA_ROOT
# export OptiX_INSTALL_DIR=$lib_dir/NVIDIA-OptiX-SDK-7.5.0-linux64-x86_64
# export LD_LIBRARY_PATH=${OptiX_INSTALL_DIR}:${CUDA_ROOT}/lib64:$LD_LIBRARY_PATH
# export PATH=${CUDA_ROOT}/bin:$PATH

export SILO_VERSION=4.11.1

# rm -rf ${ROOT_DIR}/build/silo
# rm -rf ${ROOT_DIR}/install/silo

#-----------silo--------------
mkdir ${ROOT_DIR}/build/silo
cd ${ROOT_DIR}/build/silo

make_d="${src}/Silo"

make_d="${make_d} -DCMAKE_BUILD_TYPE=RelWithDebInfo"
#make_d="${make_d} -DCMAKE_BUILD_TYPE=Release"
#make_d="${make_d} -DCMAKE_BUILD_TYPE=Debug"
make_d="${make_d} -DCMAKE_INSTALL_PREFIX=${output}"


cmake ${make_d}
#make clean
make -j 16 install
#make install