#!/bin/bash

ml purge

#######################GIT#################################
#cd src
#git clone -b develop https://github.com/visit-dav/visit.git
#cd visit; git submodule update --init --force
##################Karolina################################

cd /scratch/project/open-30-28/milanjaros/TACC/projects

ROOT_DIR=${PWD}

ml tbb/2021.10.0-GCCcore-12.2.0
ml VirtualGL/3.1-GCC-12.3.0

#ml Qt5/5.15.7-GCCcore-12.2.0
ml Qt6/6.7.2-GCCcore-13.3.0
ml Mesa/22.2.4-GCCcore-12.2.0

ml CMake/3.31.3-GCCcore-14.2.0
ml OpenMPI/4.1.6-NVHPC-24.1-CUDA-12.4.0
# ml HDF5/1.14.3-NVHPC-24.1-CUDA-12.4.0
ml Cython/3.0.10-GCCcore-13.3.0
ml Python/3.10.8-GCCcore-12.2.0
ml CUDA/12.8.0
ml GCC/14.2.0

export CC=gcc
export CXX=g++
##################################################

lib_dir=${ROOT_DIR}/install
output=${ROOT_DIR}/install/visit
src=${ROOT_DIR}/src

#export CUDA_ROOT=/usr/local/cuda
echo $CUDA_ROOT
export OptiX_INSTALL_DIR=$lib_dir/NVIDIA-OptiX-SDK-7.5.0-linux64-x86_64
export LD_LIBRARY_PATH=${OptiX_INSTALL_DIR}:${CUDA_ROOT}/lib64:$LD_LIBRARY_PATH
export PATH=${CUDA_ROOT}/bin:$PATH

# rm -rf ${ROOT_DIR}/build/visit
# rm -rf ${ROOT_DIR}/install/visit

#-----------blender_client--------------
# mkdir ${ROOT_DIR}/build/visit
# cd ${ROOT_DIR}/build/visit

# make_d="${src}/visit/src"

# make_d="${make_d} -DCMAKE_BUILD_TYPE=RelWithDebInfo"
# #make_d="${make_d} -DCMAKE_BUILD_TYPE=Release"
# #make_d="${make_d} -DCMAKE_BUILD_TYPE=Debug"
# make_d="${make_d} -DCMAKE_INSTALL_PREFIX=${output}"

# #make_d="${make_d} -Danari_DIR=${lib_dir}/anari-sdk/lib64/cmake/anari-0.15.0"
# make_d="${make_d} -DVISIT_CONFIG_SITE=NONE" #${src}/visit/src/config-site/karolina.cmake"

# make_d="${make_d} -DVISIT_ZLIB_DIR=$EBROOTZLIB"
# make_d="${make_d} -DVISIT_ANARI_DIR=${lib_dir}/anari-sdk"
# # make_d="${make_d} -DVISIT_HDF5_DIR=" #$EBROOTHDF5
# make_d="${make_d} -DVISIT_VTK_DIR=${lib_dir}/vtk"


# cmake ${make_d}
# #make clean
# make -j 120
# make install

## SuperBuild way to build visit
# choose your locations
export VISIT_BUILD_DIR=${ROOT_DIR}/build/visit
export VISIT_INSTALL_DIR=${output}

# (optional: also set config-site dir explicitly)
export VISIT_CONFIG_SITE=$VISIT_BUILD_DIR/config-site

# use system MPI
export PAR_COMPILER=mpicc
export PAR_COMPILER_CXX=mpicxx

# run the helper
${src}/visit/src/tools/dev/scripts/build_visit \
    --mesagl \
    --anari \
    --optional --parallel \
    --makeflags -j120
