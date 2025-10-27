#!/bin/bash

ml purge

#######################GIT#################################
#cd src
#git clone -b next_release https://github.com/NVIDIA/VisRTX.git
##################Karolina################################
cd ~/scratch

ROOT_DIR=${PWD}

# ml tbb/2021.11.0-GCCcore-12.3.0
# ml Mesa/24.1.3-GCCcore-13.3.0

# ml CMake/3.31.3-GCCcore-14.2.0
# ml OpenMPI/5.0.5-NVHPC-24.3-CUDA-12.3.0
# ml CUDA/12.8.0
# ml GCC/14.2.0

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


#export CUDA_ROOT=/usr/local/cuda
# echo $CUDA_ROOT
# export OptiX_INSTALL_DIR=$lib_dir/NVIDIA-OptiX-SDK-7.5.0-linux64-x86_64
# export LD_LIBRARY_PATH=${OptiX_INSTALL_DIR}:${CUDA_ROOT}/lib64:$LD_LIBRARY_PATH
# export PATH=${CUDA_ROOT}/bin:$PATH

rm -rf build/visrtx

#-----------blender_client--------------
mkdir ${ROOT_DIR}/build/visrtx
cd ${ROOT_DIR}/build/visrtx

make_d="${src}/VisRTX"

#make_d="${make_d} -DCMAKE_BUILD_TYPE=RelWithDebInfo"
make_d="${make_d} -DCMAKE_BUILD_TYPE=Release"
#make_d="${make_d} -DCMAKE_BUILD_TYPE=Debug"
make_d="${make_d} -DCMAKE_INSTALL_PREFIX=${output}"
make_d="${make_d} -DCMAKE_CUDA_ARCHITECTURES=90"

make_d="${make_d} -DVISRTX_BUILD_TSD=ON"
# make_d="${make_d} -Dglfw3_DIR=${lib_dir}/glfw/lib64/cmake/glfw3"

# make_d="${make_d} -DGLFW_INCLUDES=${lib_dir}/glfw/include"
# make_d="${make_d} -DGLFW_LIBRARIES=${lib_dir}/glfw/lib64/libglfw3.a"

# make_d="${make_d} -DNFD_INCLUDES=${lib_dir}/anari-sdk/deps/source/anari_viewer_nfd/src/include"
# make_d="${make_d} -DNFD_LIBRARIES=${lib_dir}/anari-sdk/lib64/libnfd.a"

make_d="${make_d} -Danari_DIR=${lib_dir}/anari-sdk/lib64/cmake/anari-0.15.0"
# make_d="${make_d} -DOptiX7_ROOT_DIR=${OptiX_INSTALL_DIR}"

cmake ${make_d}
#make clean
make -j 32 #6 #install
make install

#cp -v ${output}/lib64/*.so $lib_dir/anari-sdk/lib64/.
