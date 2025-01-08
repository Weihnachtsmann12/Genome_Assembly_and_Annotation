#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=flye
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_flye_2.9.5_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_flye_2.9.5_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mrubin/assembly_annotation_course
OUTDIR=$WORKDIR/flye_output_2.9.5
mkdir -p $OUTDIR

apptainer exec \
--bind $WORKDIR \
/containers/apptainer/flye_2.9.5.sif \
flye --pacbio-hifi $WORKDIR/Pyl-1/* --out-dir $OUTDIR