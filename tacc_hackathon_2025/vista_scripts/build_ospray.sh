#!/bin/bash

ml purge

#######################GIT#################################
#cd src
#git clone https://github.com/ospray/ospray.git
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
output=${ROOT_DIR}/install/ospray
src=${ROOT_DIR}/src

#export CUDA_ROOT=/usr/local/cuda
echo $CUDA_ROOT
export OptiX_INSTALL_DIR=$lib_dir/NVIDIA-OptiX-SDK-7.5.0-linux64-x86_64
export LD_LIBRARY_PATH=${OptiX_INSTALL_DIR}:${CUDA_ROOT}/lib64:$LD_LIBRARY_PATH
export PATH=${CUDA_ROOT}/bin:$PATH

# rm -rf ${ROOT_DIR}/build/ospray
# rm -rf ${ROOT_DIR}/install/ospray

#-----------blender_client--------------
mkdir ${ROOT_DIR}/build/ospray
cd ${ROOT_DIR}/build/ospray

make_d="${src}/ospray"

make_d="${make_d} -DCMAKE_BUILD_TYPE=RelWithDebInfo"
#make_d="${make_d} -DCMAKE_BUILD_TYPE=Release"
#make_d="${make_d} -DCMAKE_BUILD_TYPE=Debug"
make_d="${make_d} -DCMAKE_INSTALL_PREFIX=${output}"

make_d="${make_d} -Danari_DIR=${lib_dir}/anari-sdk/lib64/cmake/anari-0.15.0"

# make_d="${make_d} -Danari_DIR=/mnt/proj3/open-28-64/blender/salomon/projects/ingo/install/anari-sdk/lib64/cmake/anari-0.8.0"
make_d="${make_d} -Drkcommon_DIR=${lib_dir}/rkcommon/lib64/cmake/rkcommon-1.14.2"
make_d="${make_d} -Dembree_DIR=${lib_dir}/embree/lib64/cmake/embree-4.4.0"
# make_d="${make_d} -Dglfw3_DIR=/mnt/proj3/open-28-64/blender/salomon/projects/ingo/install/glfw/lib64/cmake/glfw3"
make_d="${make_d} -DBUILD_GPU_SUPPORT=OFF"
make_d="${make_d} -DOSPRAY_ENABLE_VOLUMES=OFF"

make_d="${make_d} -Dglfw3_DIR=${lib_dir}/glfw/lib64/cmake/glfw3"
# make_d="${make_d} -DGLFW_INCLUDES=${lib_dir}/glfw/include"
# make_d="${make_d} -DGLFW_LIBRARIES=${lib_dir}/glfw/lib64/libglfw3.a"
make_d="${make_d} -DISPC_EXECUTABLE=${lib_dir}/ispc/bin/ispc"

make_d="${make_d} -DOSPRAY_ENABLE_APPS_BENCHMARK:BOOL=OFF"
make_d="${make_d} -DOSPRAY_ENABLE_APPS_EXAMPLES:BOOL=OFF"
make_d="${make_d} -DOSPRAY_ENABLE_APPS_TESTING:BOOL=OFF"
make_d="${make_d} -DOSPRAY_ENABLE_APPS_TUTORIALS:BOOL=OFF"


cmake ${make_d}
#make clean
make -j 64 #6 #install
make install
