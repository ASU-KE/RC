#!/bin/bash

#SBATCH -N 3    
#SBATCH -n 8       
#SBATCH -c 1
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


srun -n $SLURM_NTASKS ./osu_hello
srun -n $SLURM_NTASKS ./osu_init

srun -n $SLURM_NTASKS ./osu_latency
srun -n $SLURM_NTASKS ./osu_bw
srun -n $SLURM_NTASKS ./osu_allgather
