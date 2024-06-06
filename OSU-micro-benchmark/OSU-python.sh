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
module load openmpi/4.1.5 
module load osu-micro-benchmarks-7.3-openmpi-cuda-su
module load cuda-12.4.0-ld
module load mamba/latest
source activate OMB-Py


python /scratch/tianche5/osu-micro-benchmarks-7.4/python/run.py --benchmark latency
python /scratch/tianche5/osu-micro-benchmarks-7.4/python/run.py --benchmark bw
python /scratch/tianche5/osu-micro-benchmarks-7.4/python/run.py --benchmark allgather
