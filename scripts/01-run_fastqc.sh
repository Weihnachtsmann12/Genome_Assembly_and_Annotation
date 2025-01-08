#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_fastqc_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_fastqc_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mrubin/assembly_annotation_course
OUTDIR=$WORKDIR/fastqc_output
mkdir -p $OUTDIR

module load FastQC/0.11.9-Java-11
fastqc --extract $WORKDIR/Pyl-1/* $WORKDIR/RNAseq_Sha/* -o $OUTDIR