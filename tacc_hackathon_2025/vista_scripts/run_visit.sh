#!/bin/bash

ml purge

export MODULEPATH=/home1/07881/jar091/scratch/easybuild/easybuild/modules/all:$MODULEPATH

cd ~/scratch/

ROOT_DIR=${PWD}

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
ml VTK/9.5.0-foss-2024a #patched from VisIt
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
output=${ROOT_DIR}/install/visit
src=${ROOT_DIR}/src

export LD_LIBRARY_PATH=$EBROOTANARIMINSDK/lib64:$EBROOTBARNEY/lib64:$LD_LIBRARY_PATH
export ANARI_LIBRARY=barney

$output/bin/visit
