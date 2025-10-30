#!/bin/bash

#ml purge

cd ~/scratch

ROOT_DIR=${PWD}

export MODULEPATH=/home1/07881/jar091/scratch/easybuild/easybuild/modules/all:$MODULEPATH
# #source /home1/07881/jar091/scratch/easybuild/env.sh


########################################
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

# #ml CUDA/12.8.0
# ml GCC/13.3.0
########################################
# ml CMake/3.29.3
# #ml Ninja/1.12.1

# ml foss/2024a
# ml Python/3.12.3
# ml SciPy-bundle/2024.05
# ml Boost/1.85.0
# ml XZ/5.4.5
# ml HDF5/1.14.5
# ml netCDF/4.9.2
# ml libdrm/2.4.122
# ml Mesa/24.1.3
ml Qt6/6.7.2
# ml zlib/1.3.1
# ml FFmpeg/7.0.2
# ml Szip/2.1.1

ml OSPRay/3.2.0
#ml ParaView-ANARI-iw

# ml GCC/13.3.0

module load TACC gcc/13.2.0 cuda/12.8 python3/3.11.8 qt5/5.14.2
##################################################

lib_dir=${ROOT_DIR}/install
output=${ROOT_DIR}/install/paraview-iw
src=${ROOT_DIR}/src

#export CUDA_ROOT=/usr/local/cuda
# echo $CUDA_ROOT
# export OptiX_INSTALL_DIR=$lib_dir/NVIDIA-OptiX-SDK-7.5.0-linux64-x86_64
# export LD_LIBRARY_PATH=${OptiX_INSTALL_DIR}:${CUDA_ROOT}/lib64:$LD_LIBRARY_PATH:${lib_dir}/anari-sdk/lib64:${lib_dir}/barney/lib64:${lib_dir}/visrtx/lib64
# export PATH=${CUDA_ROOT}/bin:$PATH

export LD_LIBRARY_PATH=${lib_dir}/anari-sdk/lib64:${lib_dir}/barney/lib64:${lib_dir}/visrtx/lib64:${lib_dir}/cycles_anari/lib64:$LD_LIBRARY_PATH

#16384 .. 2 gpus .. 500^3
#16x16x16
#400k 500k 700k 1M - 3500^3
# export CHOP_SUEY_SPLIT_STRUCTURED_PRIM_THRESHOLD=1000000 #262144 #1000000 #262144 #65536 #16384
# #export CHOP_SUEY_SPLIT_TRIANGLE_PRIM_THRESHOLD=1000
# export CHOP_SUEY_MAX_SIZE_PER_SLOT=35g
# export CHOP_SUEY_COLOR_PER_SLOT=false

# export CHOP_SUEY_BACKEND=barney 
# export ANARI_LIBRARY=chop_suey

export ANARI_LIBRARY=barney_mpi
# export ANARI_LIBRARY=cycles
# export CYCLES_ANARI_USE_GPU=CUDA

#export ANARI_LIBRARY=helide
#export ANARI_LIBRARY=visionaray
#export ANARI_LIBRARY=visrtx
#export CHOP_SUEY_DEBUG_LIBRARY=barney


#export ANARI_LIBRARY=ptc
#export PTC_ANARI_LIBRARY=barney
#export PTC_ANARI_LIBRARY=helide
#export PTC_ANARI_LIBRARY=visrtx

# PARAVIEW_LOG_APPLICATION_VERBOSITY	Log messages related to the application (see vtkPVLogger::GetApplicationVerbosity())
# PARAVIEW_LOG_CATALYST_VERBOSITY	Log messages related to Catalyst (see vtkPVLogger::GetCatalystVerbosity())
# PARAVIEW_LOG_DATA_MOVEMENT_VERBOSITY	Log messages related to data movement for rendering and other tasks (see vtkPVLogger::GetDataMovementVerbosity())
# PARAVIEW_LOG_PIPELINE_VERBOSITY	Log messages related to pipeline execution (see vtkPVLogger::GetPipelineVerbosity())
# PARAVIEW_LOG_PLUGIN_VERBOSITY	Log messages related to ParaView plugins (see vtkPVLogger::GetPluginVerbosity())
# PARAVIEW_LOG_EXECUTION_VERBOSITY	Log messages related to ParaView algorithm executions (see vtkPVLogger::GetExecutionVerbosity())

#export PARAVIEW_LOG_APPLICATION_VERBOSITY=ERROR

# export BANARI_NVDB_COMPRESSION_RATE=0.2

#srun -n 63 ${ROOT_DIR}/scripts/gpu_bind.sh 
#export CUDA_VISIBLE_DEVICES=0,1 #1,2,3,4,5,6,7

#export DISPLAY=:1.0
#srun --overlap -n 1 --gpus 8 --gres=gpu:8 vglrun $output/bin/paraview --mpi
#ddt
$output/bin/paraview
#paraview

#export PATH=/home1/02062/wald/opt/bin:$PATH
#export LD_LIBRARY_PATH=/home1/02062/wald/opt/lib64:$LD_LIBRARY_PATH

#paraview
