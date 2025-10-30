#!/bin/bash

#ml purge

#######################GIT#################################
#cd src
#git clone -b devel https://github.com/ingowald/pynari.git
#cd pynari; git submodule update --init --force
##################Karolina################################
export MODULEPATH=/home1/07881/jar091/scratch/easybuild/easybuild/modules/all:$MODULEPATH

cd ~/scratch

ROOT_DIR=${PWD}
ml purge

#ml cmake/3.31.5
ml CMake/3.29.3-GCCcore-13.3.0
#ml cmake/4.1.1
ml OpenVDB/11.0.0-foss-2024a
ml Python/3.12.3-GCCcore-13.3.0
ml CUDA/12.8.0
ml GCC/13.3.0

export CC=gcc
export CXX=g++
##################################################

lib_dir=${ROOT_DIR}/install
output=${ROOT_DIR}/install/pynari
src=${ROOT_DIR}/src


#export CUDA_ROOT=/usr/local/cuda
#echo $CUDA_ROOT
#export OptiX_INSTALL_DIR=$lib_dir/NVIDIA-OptiX-SDK-9.0.0-linux64-aarch64
#export LD_LIBRARY_PATH=${OptiX_INSTALL_DIR}:${CUDA_ROOT}/lib64:$LD_LIBRARY_PATH
#export PATH=${CUDA_ROOT}/bin:$PATH

rm -rf build/pynari
rm -rf install/pynari

#-----------blender_client--------------
mkdir ${ROOT_DIR}/build/pynari
cd ${ROOT_DIR}/build/pynari

make_d="${src}/pynari"

make_d="${make_d} -DCMAKE_BUILD_TYPE=RelWithDebInfo"
#make_d="${make_d} -DCMAKE_BUILD_TYPE=Release"
#make_d="${make_d} -DCMAKE_BUILD_TYPE=Debug"
make_d="${make_d} -DCMAKE_INSTALL_PREFIX=${output}"
make_d="${make_d} -DCMAKE_CUDA_ARCHITECTURES=90"

#make_d="${make_d} -DPython_INCLUDE_DIRS=/scratch/07881/jar091/easybuild/easybuild/software/Python/3.12.3-GCCcore-13.3.0/include"
make_d="${make_d} -DPYTHON_EXECUTABLE=/scratch/07881/jar091/easybuild/easybuild/software/Python/3.12.3-GCCcore-13.3.0/bin/python"
make_d="${make_d} -DPYBIND11_NOPYTHON=OFF"

# make_d="${make_d} -Dpynari_BUILD_ANARI=ON"
# make_d="${make_d} -Dpynari_MPI=ON"
make_d="${make_d} -Danari_DIR=${lib_dir}/anari-sdk/lib64/cmake/anari-0.15.0"


cmake ${make_d}
#make clean
make -j 64 #install
make install

#cp -v ${output}/lib64/*.so $lib_dir/anari-sdk/lib64/.
