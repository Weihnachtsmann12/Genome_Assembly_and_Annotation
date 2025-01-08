#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=trinity
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_trinity_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_trinity_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mrubin/assembly_annotation_course
OUTDIR=$WORKDIR/trinity_output
mkdir -p $OUTDIR

module load Trinity/2.15.1-foss-2021a
Trinity --seqType fq --left $WORKDIR/fastp_output_20/ERR754081_1_trimmed.fastq.gz \
--right $WORKDIR/fastp_output_20/ERR754081_2_trimmed.fastq.gz \
--CPU 16 --max_memory 64G \
--output $OUTDIR