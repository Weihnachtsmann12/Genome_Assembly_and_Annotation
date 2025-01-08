#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=lja
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_lja_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_lja_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mrubin/assembly_annotation_course
OUTDIR=$WORKDIR/lja_output
mkdir -p $OUTDIR

apptainer exec \
--bind $WORKDIR \
/containers/apptainer/lja-0.2.sif \
lja -o $OUTDIR --reads $WORKDIR/Pyl-1/ERR11437347.fastq.gz --diploid