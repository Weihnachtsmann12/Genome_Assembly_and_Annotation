#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=05:00:00
#SBATCH --job-name=fai
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_get_fai_flye_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_get_fai_flye_%j.e
#SBATCH --partition=pibu_el8

# for the LJA assembly
# WORKDIR=/data/users/mrubin/assembly_annotation_course
# OUTDIR=$WORKDIR/lja_output
# MODULE=SAMtools/1.13-GCC-10.3.0
# ASSEMBLY=$WORKDIR/lja_output/assembly.fasta

# cd $OUTDIR

# module load $MODULE
# samtools faidx $ASSEMBLY --fai-idx LJA.fai


# for the flye assembly
WORKDIR=/data/users/mrubin/assembly_annotation_course
OUTDIR=$WORKDIR/flye_output_2.9.5
MODULE=SAMtools/1.13-GCC-10.3.0
ASSEMBLY=$WORKDIR/flye_output_2.9.5/assembly.fasta

cd $OUTDIR

module load $MODULE
samtools faidx $ASSEMBLY --fai-idx Flye.fai