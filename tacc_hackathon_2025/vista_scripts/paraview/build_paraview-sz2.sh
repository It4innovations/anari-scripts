#!/bin/bash

#ml purge

#######################GIT#################################
#cd src
#git clone https://gitlab.kitware.com/paraview/paraview.git
#cd paraview; git submodule update --init --force
##################Karolina################################

export MODULEPATH=/home1/07881/jar091/scratch/easybuild/easybuild/modules/all:$MODULEPATH

cd ~/scratch

ROOT_DIR=${PWD}

#ml tbb/2021.10.0-GCCcore-12.2.0
#ml VirtualGL/3.1-GCC-12.3.0

#ml Qt5/5.15.7-GCCcore-12.2.0
#ml Mesa/22.2.4-GCCcore-12.2.0

#ml CMake/3.31.3-GCCcore-14.2.0
#ml OpenMPI/4.1.6-NVHPC-24.1-CUDA-12.4.0
#ml CUDA/12.8.0
#ml GCC/14.2.0

ml CMake/3.29.3
#ml Ninja/1.12.1

ml foss/2024a
ml Python/3.12.3
ml SciPy-bundle/2024.05
ml Boost/1.85.0
ml XZ/5.4.5
ml HDF5/1.14.5
ml netCDF/4.9.2
ml libdrm/2.4.122
ml Mesa/24.1.3
#ml Qt6/6.7.2
ml Qt5
ml zlib/1.3.1
ml FFmpeg/7.0.2
ml Szip/2.1.1

ml OSPRay/3.2.0

ml GCC/13.3.0

export CC=gcc
export CXX=g++
##################################################

lib_dir=${ROOT_DIR}/install
output=${ROOT_DIR}/install/paraview-sz
src=${ROOT_DIR}/src

#export CUDA_ROOT=/usr/local/cuda
#echo $CUDA_ROOT
#export OptiX_INSTALL_DIR=$lib_dir/NVIDIA-OptiX-SDK-7.5.0-linux64-x86_64
#export LD_LIBRARY_PATH=${OptiX_INSTALL_DIR}:${CUDA_ROOT}/lib64:$LD_LIBRARY_PATH:${lib_dir}/anari-sdk/lib64:${lib_dir}/barney/lib64
#export PATH=${CUDA_ROOT}/bin:$PATH
export ANARI_LIBRARY=helide
export CMAKE_CONFIGURATION="helide"

# rm -rf ${ROOT_DIR}/build/paraview
# rm -rf ${ROOT_DIR}/install/paraview

#-----------blender_client--------------
mkdir ${ROOT_DIR}/build/paraview-sz
cd ${ROOT_DIR}/build/paraview-sz

make_d="${src}/paraview-sz"

make_d="${make_d} -DCMAKE_BUILD_TYPE=RelWithDebInfo"

make_d="${make_d} -DCMAKE_INSTALL_PREFIX=${output}"

make_d="${make_d} -DVTK_MODULE_ENABLE_VTK_RenderingAnari:STRING=YES"
make_d="${make_d} -DVTK_MODULE_ENABLE_VTK_RenderingRayTracing:STRING=YES"
make_d="${make_d} -DPARAVIEW_ENABLE_RAYTRACING=ON"
make_d="${make_d} -DPARAVIEW_ENABLE_ANARI=ON"
make_d="${make_d} -DPARAVIEW_USE_MPI=ON"
make_d="${make_d} -DVTK_ENABLE_OSPRAY=ON"
make_d="${make_d} -DVTK_ENABLE_VISRTX=OFF"

#make_d="${make_d} -DVisRTX_DIR=${lib_dir}/visrtx/lib64/cmake/VisRTX"
#make_d="${make_d} -Drkcommon_DIR=${lib_dir}/rkcommon/lib64/cmake/rkcommon-1.14.2"
#make_d="${make_d} -Dembree_DIR=${lib_dir}/embree/lib64/cmake/embree-4.4.0"
#make_d="${make_d} -Dospray_DIR=${lib_dir}/ospray/lib64/cmake/ospray-3.3.0"
make_d="${make_d} -Danari_DIR=${lib_dir}/anari-sdk/lib64/cmake/anari-0.15.0"

cmake ${make_d}
#make clean
make -j 64 install
