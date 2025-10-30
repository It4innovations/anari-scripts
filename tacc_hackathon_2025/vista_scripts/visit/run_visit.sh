#!/bin/bash

ml purge

#######################GIT#################################
#cd src
#git clone -b develop https://github.com/visit-dav/visit.git
#cd visit; git submodule update --init --force
##################Karolina################################

export MODULEPATH=/home1/07881/jar091/scratch/easybuild/easybuild/modules/all:$MODULEPATH

cd ~/scratch/

ROOT_DIR=${PWD}

# ########################################
# ml CMake/3.29.3

# # ml Brotli/1.1.0-GCCcore-13.3.0
# ml embree/4.4.0-GCCcore-13.3.0
# # ml FFmpeg/7.0.2-GCCcore-13.3.0
# # ml fftw3/3.3.10
# # ml freetype/2.13.2-GCCcore-13.3.0
# # ml FriBidi/1.0.15-GCCcore-13.3.0
# # ml GMP/6.3.0-GCCcore-13.3.0
# # ml HarfBuzz/9.0.0-GCCcore-13.3.0
# ml libepoxy/1.5.10-GCCcore-13.3.0
# # ml libjpeg-turbo/3.0.1-GCCcore-13.3.0
# # ml libpng/1.6.43-GCCcore-13.3.0
# # ml LibTIFF/4.6.0-GCCcore-13.3.0
# # ml libwebp/1.4.0-GCCcore-13.3.0
# # ml libxml2/2.12.7-GCCcore-13.3.0
# # ml LLVM/18.1.8-GCCcore-13.3.0
# # ml Mesa/24.1.3-GCCcore-13.3.0
# # ml Python/3.12.3-GCCcore-13.3.0
# # ml SDL2/2.30.6-GCCcore-13.3.0
# # ml tbb/2021.13.0-GCCcore-13.3.0
# # ml Wayland/1.23.0-GCCcore-13.3.0
# # ml zlib/1.3.1-GCCcore-13.3.0
# # ml zstd/1.5.6-GCCcore-13.3.0
# ml OpenImageIO/2.5.15.0-GCC-13.3.0
# ml pugixml/1.15-GCCcore-13.3.0
# ml OpenJPEG/2.5.2-GCCcore-13.3.0
# ml OpenColorIO/2.4.2-GCC-13.3.0

# ml OpenVDB/11.0.0-foss-2024a
# ml ANARI-SDK/0.15.0

# ml CUDA/12.8.0
# ml GCC/13.3.0
# ########################################

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
#ml Qwt/6.3.0 # TODO: MJ
# Visit-3.4.1 needs VTK-9.2.x (not 9.3.x) - https://github.com/visit-dav/visit/issues/19547
#ml VTK/9.3.1 # TODO: MJ
#ml VTK/9.5.0
ml VTK/9.5.0-foss-2024a
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

export LD_LIBRARY_PATH=${lib_dir}/anari-sdk/lib64:${lib_dir}/barney/lib64:${lib_dir}/visrtx/lib64:${lib_dir}/cycles_anari/lib64:$LD_LIBRARY_PATH
export ANARI_LIBRARY=barney
#export ANARI_LIBRARY=cycles
#export ANARI_LIBRARY=visrtx

#ldd ${lib_dir}/cycles_anari/lib64/libanari_library_cycles.so

${output}/bin/visit