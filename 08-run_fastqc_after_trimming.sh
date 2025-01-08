#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc_after_trimming
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_fastqc_output_after_trimming_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_fastqc_output_after_trimming_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mrubin/assembly_annotation_course
OUTDIR=$WORKDIR/fastqc_output_after_trimming
mkdir -p $OUTDIR

module load FastQC/0.11.9-Java-11
fastqc --extract $WORKDIR/fastp_output_20/*.gz -o $OUTDIR