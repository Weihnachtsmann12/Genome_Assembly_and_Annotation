#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastp
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_fastp_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_fastp_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mrubin/assembly_annotation_course
OUTDIR=$WORKDIR/fastp_output_20
mkdir -p $OUTDIR

module load fastp/0.23.4-GCC-10.3.0
# fastp -i $WORKDIR/Pyl-1/ERR11437347.fastq.gz -o $OUTDIR/ERR11437347_trimmed.fastq.gz
fastp -q 20 -i $WORKDIR/RNAseq_Sha/ERR754081_1.fastq.gz -I $WORKDIR/RNAseq_Sha/ERR754081_2.fastq.gz -o $OUTDIR/ERR754081_1_trimmed.fastq.gz -O $OUTDIR/ERR754081_2_trimmed.fastq.gz