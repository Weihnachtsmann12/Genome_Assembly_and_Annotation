#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastp
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_jellyfish_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_jellyfish_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mrubin/assembly_annotation_course
OUTDIR=$WORKDIR/kmer_output
mkdir -p $OUTDIR

module load Jellyfish/2.3.0-GCC-10.3.0
jellyfish count \
-C -m 21 -s 5G -t 4 -o Pyl-1_reads.jf \
<(zcat $WORKDIR/Pyl-1/ERR11437347.fastq.gz)
jellyfish histo -t 10 Pyl-1_reads.jf > Pyl-1_reads.histo