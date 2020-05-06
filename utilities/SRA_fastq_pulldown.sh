#!/bin/sh
#SBATCH -e fqdmp_%A.e
#SBATCH -o fqdmp_%A.o
#SBATCH -J fqdmp
#SBATCH -p shared
#SBATCH -n 1
#SBATCH -t 02:00:00
#SBATCH --mem=4000

module purge
# the below cmd loads the latest Anaconda distribution of python3
# and makes conda accessible
module load python
# loads the sratools conda environment
source activate sratools
# useful book-keeping so if a job fails, you know what accession didn't finish downloading

echo "sra run id = $1"

# the -M 0 flag keeps reads of zero length so that
# read pairing between R1 and R2 doesn't get disrupted
# due to un-even numbers of right and left reads,
# while split-files puts right and left reads into separate files

fasterq-dump --threads 6 --min-read-len 0 --split-files $1



