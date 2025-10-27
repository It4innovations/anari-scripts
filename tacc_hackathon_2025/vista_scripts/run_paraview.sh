#!/bin/bash

#ml purge

cd ~/scratch

ROOT_DIR=${PWD}

export MODULEPATH=/home1/07881/jar091/scratch/easybuild/easybuild/modules/all:$MODULEPATH

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
##################################################

lib_dir=${ROOT_DIR}/install
output=${ROOT_DIR}/install/paraview
src=${ROOT_DIR}/src

export LD_LIBRARY_PATH=$EBROOTANARIMINSDK/lib64:$EBROOTBARNEY/lib64:$LD_LIBRARY_PATH
export ANARI_LIBRARY=barney

#export DISPLAY=:1.0
#srun --overlap -n 1 --gpus 8 --gres=gpu:8 vglrun $output/bin/paraview --mpi
$output/bin/paraview