#!/bin/bash
#SBATCH --account=MST114049           # (-A) iService Project ID
#SBATCH --job-name=llat_train         # (-J) Job name
#SBATCH --partition=normal2            # (-p) Slurm partition
#SBATCH --gpus-per-node=6             # Gpus per node
#SBATCH --ntasks-per-node=6           # tesks
#SBATCH --cpus-per-task=4
#SBATCH --time=2-00:00:00             # (-t) Wall time limit (days-hrs:min:sec)
#SBATCH --output=job_logs/job-%j.out           # (-o) Path to the standard output file
#SBATCH --error=job_logs/job-%j.err            # (-e) Path to the standard error file
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=xxxxx             # Where to send mail.  Set this to your email address

date
ml load miniconda3/24.11.1  
ml load gcc/11.5.0 
ml load cuda/12.4
conda activate ty
ml list


# nvidia-smi --list-gpus
# NGPU=$(nvidia-smi -L|wc -l)
# export NGPU
echo "========================================================"
# srun -n 2 bash -lc 'echo "rank=$SLURM_PROCID vis=$CUDA_VISIBLE_DEVICES host=$(hostname)"; nvidia-smi -L'
# srun -n 4 python train.py fit --config config_new.yaml
srun -n 6 python train.py fit --config config_new_relay_6GPUs.yaml

