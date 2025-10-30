#ml tacc-apptainer
#apptainer exec docker://codercom/code-server:latest code-server --host 0.0.0.0 --port 8099 

cd /home1/07881/jar091/scratch/easybuild
source env.sh

ml code-server
code-server --host 0.0.0.0 --port 8099
