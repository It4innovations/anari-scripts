#!/bin/bash

ml purge

#######################GIT#################################
#cd src
#git clone -b anari https://gitlab.kitware.com/zellmann/paraview.git
#git clone https://gitlab.kitware.com/paraview/paraview.git
#cd paraview; git submodule update --init --force
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
output=${ROOT_DIR}/install/paraview-sz
src=${ROOT_DIR}/src

#export CUDA_ROOT=/usr/local/cuda
echo $CUDA_ROOT
export OptiX_INSTALL_DIR=$lib_dir/NVIDIA-OptiX-SDK-7.5.0-linux64-x86_64
export LD_LIBRARY_PATH=${OptiX_INSTALL_DIR}:${CUDA_ROOT}/lib64:$LD_LIBRARY_PATH:${lib_dir}/anari-sdk/lib64:${lib_dir}/barney/lib64
export PATH=${CUDA_ROOT}/bin:$PATH
export ANARI_LIBRARY=helide
export CMAKE_CONFIGURATION="helide"

# rm -rf ${ROOT_DIR}/build/paraview-sz
# rm -rf ${ROOT_DIR}/install/paraview-sz

#-----------blender_client--------------
mkdir ${ROOT_DIR}/build/paraview-sz
cd ${ROOT_DIR}/build/paraview-sz

make_d="${src}/paraview-sz"

make_d="${make_d} -DCMAKE_BUILD_TYPE=RelWithDebInfo"
#make_d="${make_d} -DCMAKE_BUILD_TYPE=Release"
#make_d="${make_d} -DCMAKE_BUILD_TYPE=Debug"
make_d="${make_d} -DCMAKE_INSTALL_PREFIX=${output}"

make_d="${make_d} -DVTK_MODULE_ENABLE_VTK_RenderingAnari:STRING=YES"
make_d="${make_d} -DVTK_MODULE_ENABLE_VTK_RenderingRayTracing:STRING=YES"
make_d="${make_d} -DPARAVIEW_ENABLE_RAYTRACING=ON"
make_d="${make_d} -DPARAVIEW_ENABLE_ANARI=ON"
make_d="${make_d} -DPARAVIEW_USE_MPI=ON"
make_d="${make_d} -DVTK_ENABLE_OSPRAY=OFF"
make_d="${make_d} -DVTK_ENABLE_VISRTX=OFF"

#make_d="${make_d} -DVisRTX_DIR=${lib_dir}/visrtx/lib64/cmake/VisRTX"
make_d="${make_d} -Drkcommon_DIR=${lib_dir}/rkcommon/lib64/cmake/rkcommon-1.14.2"
make_d="${make_d} -Dembree_DIR=${lib_dir}/embree/lib64/cmake/embree-4.4.0"
make_d="${make_d} -Dospray_DIR=${lib_dir}/ospray/lib64/cmake/ospray-3.3.0"
make_d="${make_d} -Danari_DIR=${lib_dir}/anari-sdk/lib64/cmake/anari-0.15.0"

cmake ${make_d}
#make clean
make -j 120 install
