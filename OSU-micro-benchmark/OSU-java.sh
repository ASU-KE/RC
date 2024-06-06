#!/bin/bash

#SBATCH -N 3            # number of nodes (3 in this example)
#SBATCH -n 8            # number of tasks (8 tasks in this example)
#SBATCH -c 1            # number of cores-per-task (defaults to 1 if not specified)
#SBATCH -G 20
#SBATCH -t 0-01:00:00
#SBATCH -p general
#SBATCH -q public
#SBATCH -o /scratch/%u/osu/slurm.%j.out
#SBATCH -e /scratch/%u/osu/slurm.%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user="%u@asu.edu"
#SBATCH --export=NONE


module purge
module load openjdk-17.0.3_7-4s
module load openmpi/4.1.5 
module load osu-micro-benchmarks-7.3-openmpi-cuda-su
module load cuda-12.4.0-ld


mpirun_rsh -np 2 -hostfile hosts \
            LD_PRELOAD=${MPILIB}/lib/libmpi.so java -cp $MV2J_HOME/lib/mvapich2-j.jar:. \
            -Djava.library.path=$MV2J_HOME/lib mpi.pt2pt.OSULatency

mpirun_rsh -np 2 -hostfile hosts \
            LD_PRELOAD=${MPILIB}/lib/libmpi.so java -cp $MV2J_HOME/lib/mvapich2-j.jar:. \
            -Djava.library.path=$MV2J_HOME/lib mpi.pt2pt.OSUBandwidth

mpirun_rsh -np 8 -hostfile hosts \
            LD_PRELOAD=$MPILIB/lib/libmpi.so java -cp $MV2J_HOME/lib/mvapich2-j.jar:. \
            -Djava.library.path=$MV2J_HOME/lib mpi.collective.OSUAllgather
