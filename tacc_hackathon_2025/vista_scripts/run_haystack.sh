#!/bin/bash

#ml purge

cd /home1/07881/jar091/scratch/easybuild
export EASYBUILD_PREFIX=$PWD/easybuild
export MODULEPATH=$EASYBUILD_PREFIX/modules/all:$MODULEPATH
#######################GIT#################################
#cd src
#git clone -b devel https://github.com/ingowald/haystack.git
#cd haystack; git submodule update --init --force
##################Karolina################################
cd ~/scratch

ROOT_DIR=${PWD}

#ml tbb/2021.11.0-GCCcore-12.3.0
#ml Mesa/24.1.3-GCCcore-13.3.0

#ml CMake/3.31.3-GCCcore-14.2.0
#ml OpenMPI/5.0.5-NVHPC-24.3-CUDA-12.3.0
ml CUDA/12.8.0
#ml GCC/14.2.0
#ml cuda/12.4
#ml qt5/5.14.2
ml Qt6

# export CC=gcc
# export CXX=g++
##################################################

lib_dir=${ROOT_DIR}/install
output=${ROOT_DIR}/install/haystack
src=${ROOT_DIR}/src

export ANARI_LIBRARY=barney_mpi
#export CUDA_ROOT=/usr/local/cuda
#echo $CUDA_ROOT
#export OptiX_INSTALL_DIR=$lib_dir/NVIDIA-OptiX-SDK-7.5.0-linux64-x86_64
#export LD_LIBRARY_PATH=${OptiX_INSTALL_DIR}:${CUDA_ROOT}/lib64:$LD_LIBRARY_PATH
#export PATH=${CUDA_ROOT}/bin:$PATH

export LD_LIBRARY_PATH=/home1/07881/jar091/scratch/install/barney/lib64::$LD_LIBRARY_PATH

# rm -rf build/haystack
# rm -rf install/haystack

#${ROOT_DIR}/build/haystack/hsViewerQT spheres://src/spheres/spheres2.bin:format=xyz:radius=0.001 --paths-per-pixel 1 -anari
${ROOT_DIR}/build/haystack/hsOffline spheres://2@src/spheres/spheres2.bin:format=xyz:radius=0.001 --paths-per-pixel 1 -anari -ndg 2 --measure
