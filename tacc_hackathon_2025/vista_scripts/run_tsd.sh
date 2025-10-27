#!/bin/bash

#ml purge
export MODULEPATH=/home1/07881/jar091/scratch/easybuild/easybuild/modules/all:$MODULEPATH

cd ~/scratch

ROOT_DIR=${PWD}

ml CUDA/12.8.0
ml GLFW/3.4-GCCcore-13.3.0
ml Mesa/24.1.3-GCCcore-13.3.0

ml cmake/3.31.5
ml gcc/13.2.0

export CC=gcc
export CXX=g++
##################################################

lib_dir=${ROOT_DIR}/install
output=${ROOT_DIR}/install/visrtx
src=${ROOT_DIR}/src

export LD_LIBRARY_PATH=${lib_dir}/anari-sdk/lib64:${lib_dir}/barney/lib64:${lib_dir}/visrtx/lib64:$LD_LIBRARY_PATH

export TSD_ANARI_LIBRARIES=barney,visrtx

${ROOT_DIR}/build/visrtx/tsdViewer