#!/bin/bash

ml purge

cd /mnt/proj3/open-28-64/blender/salomon/projects/ingo

ROOT_DIR=${PWD}

# ml tbb/2020.3-GCCcore-10.3.0
# ml VirtualGL/2.6.5-GCC-10.3.0

# ml Qt5/5.15.5-GCCcore-11.3.0
# ml CMake/3.24.3-GCCcore-12.2.0
# ml GCC/12.2.0
# #ml Mesa #/22.0.3-GCCcore-11.3.0
# ml Mesa/22.0.3-GCCcore-11.3.0

# ml OpenMPI/4.1.5-NVHPC-23.5-CUDA-12.2.0

ml tbb/2021.10.0-GCCcore-12.2.0
ml VirtualGL/3.1-GCC-12.3.0

ml Qt5/5.15.7-GCCcore-12.2.0
#ml CMake/3.24.3-GCCcore-12.2.0
#ml Mesa #/22.0.3-GCCcore-11.3.0
ml Mesa/22.2.4-GCCcore-12.2.0

ml CMake/3.31.3-GCCcore-14.2.0
ml OpenMPI/4.1.6-NVHPC-24.1-CUDA-12.4.0
ml CUDA/12.8.0
ml GCC/14.2.0

##################################################

lib_dir=${ROOT_DIR}/install
output=${ROOT_DIR}/install/paraview
src=${ROOT_DIR}/src

#export CUDA_ROOT=/usr/local/cuda
echo $CUDA_ROOT
export OptiX_INSTALL_DIR=$lib_dir/NVIDIA-OptiX-SDK-7.5.0-linux64-x86_64
export LD_LIBRARY_PATH=${OptiX_INSTALL_DIR}:${CUDA_ROOT}/lib64:${lib_dir}/barney_kar/lib64:$LD_LIBRARY_PATH
export PATH=${CUDA_ROOT}/bin:$PATH

#make_d="${make_d} -Dbarney_DIR=${lib_dir}/barney_kar/lib64/cmake/barney-0.9.4"

#16384 .. 2 gpus .. 500^3
#16x16x16
#400k 500k 700k 1M - 3500^3
export CHOP_SUEY_SPLIT_STRUCTURED_PRIM_THRESHOLD=1000000 #262144 #1000000 #262144 #65536 #16384
#export CHOP_SUEY_SPLIT_TRIANGLE_PRIM_THRESHOLD=1000
export CHOP_SUEY_MAX_SIZE_PER_SLOT=1g
export CHOP_SUEY_COLOR_PER_SLOT=false

export CHOP_SUEY_BACKEND=barney 
export ANARI_LIBRARY=chop_suey

#export ANARI_LIBRARY=barney

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

#srun -n 63 ${ROOT_DIR}/scripts/gpu_bind.sh 
#export CUDA_VISIBLE_DEVICES=0,1 #1,2,3,4,5,6,7

# export DISPLAY=:10.0
# srun -n 1 -c 128 vglrun $output/bin/paraview


#export DISPLAY=:1.0
srun --overlap -n 1 --gpus 8 --gres=gpu:8 vglrun $output/bin/paraview #--mpi