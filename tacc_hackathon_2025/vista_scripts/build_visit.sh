#!/bin/bash

ml purge

#######################GIT#################################
#cd src
#git clone -b mj/develop https://github.com/jar091/visit.git
#cd visit; git submodule update --init --force --recursive
##################Karolina################################
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
ml Qt6/6.7.2
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

#export QT_PLUGINS_PATH=$EBROOTQT6/plugins/plaforms
export VISIT_QT_DIR=$EBROOTQT6

# rm -rf ${ROOT_DIR}/build/visit
# rm -rf ${ROOT_DIR}/install/visit

#-----------visit--------------
mkdir ${ROOT_DIR}/build/visit
cd ${ROOT_DIR}/build/visit

make_d="${src}/visit/src"

make_d="${make_d} -DCMAKE_BUILD_TYPE=RelWithDebInfo"
#make_d="${make_d} -DCMAKE_BUILD_TYPE=Release"
#make_d="${make_d} -DCMAKE_BUILD_TYPE=Debug"
make_d="${make_d} -DCMAKE_INSTALL_PREFIX=${output}"

make_d="${make_d} -DVISIT_CONFIG_SITE=NONE" #${src}/visit/src/config-site/karolina.cmake"

make_d="${make_d} -DVISIT_ZLIB_DIR=$EBROOTZLIB"
make_d="${make_d} -DVISIT_ANARI_DIR=$EBROOTANARIMINSDK"
# make_d="${make_d} -DVISIT_HDF5_DIR=" #$EBROOTHDF5
make_d="${make_d} -DVISIT_VTK_DIR=$EBROOTVTK"

make_d="${make_d} -DCMAKE_PREFIX_PATH=$EBROOTQT6"
make_d="${make_d} -DQt6_DIR=$EBROOTQT6/lib/cmake/Qt6"
make_d="${make_d} -DQT_PLUGINS_DIR=$EBROOTQT6/plugins"

cmake ${make_d}
#make clean
make -j 64 install
