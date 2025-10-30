#!/bin/bash

#ml purge

#######################GIT#################################
#cd src
#git clone -b develop https://github.com/Alpine-DAV/ascent
#cd ascent; git submodule update --init --force
##################Karolina################################

export MODULEPATH=/home1/07881/jar091/scratch/easybuild/easybuild/modules/all:$MODULEPATH

cd ~/scratch 

ROOT_DIR=${PWD}

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
ml Qt6/6.7.2
ml zlib/1.3.1
ml FFmpeg/7.0.2
ml Szip/2.1.1

ml OSPRay/3.2.0

ml GCC/13.3.0

export CC=gcc
export CXX=g++
##################################################

lib_dir=${ROOT_DIR}/install
output=${ROOT_DIR}/install/ascent
src=${ROOT_DIR}/src

export LD_LIBRARY_PATH=${lib_dir}/anari-sdk/lib64:${lib_dir}/barney/lib64:${lib_dir}/visrtx/lib64:$LD_LIBRARY_PATH
export ANARI_LIBRARY=helide
#export ANARI_DEVICE=helide

# export PYTHONPATH=${lib_dir}/conduit/python-modules:$PYTHONPATH
# export PYTHONPATH=${lib_dir}/ascent/python-modules:$PYTHONPATH

#/scratch/07881/jar091/src/ascent/scripts/build_ascent/install/
export PYTHONPATH=/scratch/07881/jar091/src/ascent/scripts/build_ascent/install/conduit-v0.9.5/python-modules:$PYTHONPATH
export PYTHONPATH=/scratch/07881/jar091/src/ascent/scripts/build_ascent/install/ascent-checkout/python-modules:$PYTHONPATH

#cd $src/ascent/data/
#python cornell_box_ascent.py
#cd ${output}/examples/ascent/proxies/lulesh/

# cd /scratch/07881/jar091/src/ascent/scripts/build_ascent/install/ascent-checkout/examples/ascent/proxies/lulesh/
# ./lulesh_ser

# cd /home1/07881/jar091/scratch/src/ascent/data/
# python cornell_box_ascent.py


cd /scratch/07881/jar091/src/ascent/scripts/build_ascent/build/ascent-checkout/tests/ascent
./t_ascent_render_3d

