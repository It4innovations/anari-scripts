#!/bin/bash

#ml purge

#######################GIT#################################
#cd src
#git clone https://github.com/ingowald/paraview
#cd paraview; git submodule update --init --force --recursive
##################Karolina################################

export MODULEPATH=/home1/07881/jar091/scratch/easybuild/easybuild/modules/all:$MODULEPATH

cd ~/scratch

ROOT_DIR=${PWD}

ml CMake/3.29.3

ml foss/2024a
ml Python/3.12.3
ml SciPy-bundle/2024.05
ml Boost/1.85.0
ml XZ/5.4.5
ml HDF5/1.14.5
ml netCDF/4.9.2
ml libdrm/2.4.122
ml Mesa/24.1.3
ml Qt6/6.7.2
ml zlib/1.3.1
ml FFmpeg/7.0.2
ml Szip/2.1.1

ml OSPRay/3.2.0
ml ANARI-SDK/0.15.0

ml GCC/13.3.0

export CC=gcc
export CXX=g++
##################################################

lib_dir=${ROOT_DIR}/install
output=${ROOT_DIR}/install/paraview
src=${ROOT_DIR}/src

export ANARI_LIBRARY=helide
export CMAKE_CONFIGURATION="helide"

# rm -rf ${ROOT_DIR}/build/paraview
# rm -rf ${ROOT_DIR}/install/paraview

#-----------blender_client--------------
mkdir ${ROOT_DIR}/build/paraview
cd ${ROOT_DIR}/build/paraview

make_d="${src}/paraview"

make_d="${make_d} -DCMAKE_BUILD_TYPE=RelWithDebInfo"
make_d="${make_d} -DCMAKE_INSTALL_PREFIX=${output}"

make_d="${make_d} -DVTK_MODULE_ENABLE_VTK_RenderingAnari:STRING=YES"
make_d="${make_d} -DVTK_MODULE_ENABLE_VTK_RenderingRayTracing:STRING=YES"
make_d="${make_d} -DPARAVIEW_ENABLE_RAYTRACING=ON"
make_d="${make_d} -DPARAVIEW_ENABLE_ANARI=ON"
make_d="${make_d} -DPARAVIEW_USE_MPI=ON"
make_d="${make_d} -DVTK_ENABLE_OSPRAY=ON"
make_d="${make_d} -DVTK_ENABLE_VISRTX=OFF"

cmake ${make_d}
#make clean
make -j 64 install