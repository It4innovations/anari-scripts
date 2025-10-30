#!/bin/bash

#ml purge

cd /home1/07881/jar091/scratch/easybuild
export EASYBUILD_PREFIX=$PWD/easybuild
export MODULEPATH=$EASYBUILD_PREFIX/modules/all:$MODULEPATH
#######################GIT#################################
#cd src
#git clone -b devel https://github.com/ingowald/haystack.git
#cd haystack; git submodule update --init --force
##################Karolina################################
cd ~/scratch

ROOT_DIR=${PWD}
###########
# ml Brotli/1.1.0-GCCcore-13.3.0
ml embree/4.4.0-GCCcore-13.3.0
# ml FFmpeg/7.0.2-GCCcore-13.3.0
# ml fftw3/3.3.10
# ml freetype/2.13.2-GCCcore-13.3.0
# ml FriBidi/1.0.15-GCCcore-13.3.0
# ml GMP/6.3.0-GCCcore-13.3.0
# ml HarfBuzz/9.0.0-GCCcore-13.3.0
ml libepoxy/1.5.10-GCCcore-13.3.0
# ml libjpeg-turbo/3.0.1-GCCcore-13.3.0
# ml libpng/1.6.43-GCCcore-13.3.0
# ml LibTIFF/4.6.0-GCCcore-13.3.0
# ml libwebp/1.4.0-GCCcore-13.3.0
# ml libxml2/2.12.7-GCCcore-13.3.0
# ml LLVM/18.1.8-GCCcore-13.3.0
# ml Mesa/24.1.3-GCCcore-13.3.0
# ml Python/3.12.3-GCCcore-13.3.0
# ml SDL2/2.30.6-GCCcore-13.3.0
# ml tbb/2021.13.0-GCCcore-13.3.0
# ml Wayland/1.23.0-GCCcore-13.3.0
# ml zlib/1.3.1-GCCcore-13.3.0
# ml zstd/1.5.6-GCCcore-13.3.0
ml OpenImageIO/2.5.15.0-GCC-13.3.0
ml pugixml/1.15-GCCcore-13.3.0
ml OpenJPEG/2.5.2-GCCcore-13.3.0
ml OpenColorIO/2.4.2-GCC-13.3.0

ml OpenVDB/11.0.0-foss-2024a
ml ANARI-SDK/0.15.0

#ml CUDA/12.8.0
ml GCC/13.3.0
###########

#ml tbb/2021.11.0-GCCcore-12.3.0
#ml Mesa/24.1.3-GCCcore-13.3.0

#ml CMake/3.31.3-GCCcore-14.2.0
#ml OpenMPI/5.0.5-NVHPC-24.3-CUDA-12.3.0
#ml CUDA/12.8.0
#ml GCC/14.2.0
ml cuda/12.6
#ml qt5/5.14.2
ml Qt6
ml Python/3.11.5-GCCcore-13.3.0

# export CC=gcc
# export CXX=g++
##################################################

lib_dir=${ROOT_DIR}/install
output=${ROOT_DIR}/install/haystack
src=${ROOT_DIR}/src

#export ANARI_LIBRARY=barney_mpi
export ANARI_LIBRARY=cycles
#export CUDA_ROOT=/usr/local/cuda
#echo $CUDA_ROOT
#export OptiX_INSTALL_DIR=$lib_dir/NVIDIA-OptiX-SDK-7.5.0-linux64-x86_64
#export LD_LIBRARY_PATH=${OptiX_INSTALL_DIR}:${CUDA_ROOT}/lib64:$LD_LIBRARY_PATH
#export PATH=${CUDA_ROOT}/bin:$PATH

export LD_LIBRARY_PATH=/home1/07881/jar091/scratch/install/barney/lib64::$LD_LIBRARY_PATH

export LD_LIBRARY_PATH=${lib_dir}/barney/lib64:${lib_dir}/cycles_anari/lib64:$LD_LIBRARY_PATH
export ANARI_LIBRARY=cycles #barney_mpi

export CYCLES_ANARI_USE_GPU=CUDA

# rm -rf build/haystack
# rm -rf install/haystack

#srun -n 4 ${ROOT_DIR}/build/haystack/hsViewerQT spheres://4@src/spheres/spheres2.bin:format=xyz:radius=0.001 --paths-per-pixel 1 -anari -ndg 4
#srun -n 4 ${ROOT_DIR}/build/haystack/hsOffline spheres://4@src/spheres/spheres2.bin:format=xyz:radius=0.001 --paths-per-pixel 1 -anari -ndg 4 --measure

#srun -n 4 -u ${ROOT_DIR}/build/haystack/hsViewerQT raw://4@/scratch/09566/daludot/4k_data/cube_p.0:format=float:dims=1024,1024,1024:channels=4 -anari -ndg 4
${ROOT_DIR}/build/haystack/hsViewerQT raw:///scratch/09566/daludot/4k_data/cube_p.0:format=float:dims=1024,1024,1024:channels=4 -anari
