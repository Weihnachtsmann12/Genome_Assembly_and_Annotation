#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=nucmer_mummer
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_nucmer_mummer_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_nucmer_mummer_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mrubin/assembly_annotation_course
REF=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
OUTDIR=$WORKDIR/nucmer_mummer_output
FLYE=$WORKDIR/flye_output_2.9.5/assembly.fasta
HIFIASM=$WORKDIR/hifiasm/Pyl-1.asm.bp.p_ctg.fa
LJA=$WORKDIR/lja_output/assembly.fasta

mkdir -p $OUTDIR


# run nucmer
#flye
#apptainer exec \
#--bind $WORKDIR \
#/containers/apptainer/mummer4_gnuplot.sif \
#nucmer --prefix genome_flye --breaklen 1000 --mincluster 1000 --threads 16 $REF $FLYE 

# hifiasm
#apptainer exec \
#--bind $WORKDIR \
#/containers/apptainer/mummer4_gnuplot.sif \
#nucmer --prefix genome_hifiasm --breaklen 1000 --mincluster 1000 --threads 16 $REF $HIFIASM 

# lja
#apptainer exec \
#--bind $WORKDIR \
#/containers/apptainer/mummer4_gnuplot.sif \
#nucmer --prefix genome_LJA --breaklen 1000 --mincluster 1000 --threads 16 $REF $LJA 


# run mummer
# flye
apptainer exec \
--bind $WORKDIR \
/containers/apptainer/mummer4_gnuplot.sif \
mummerplot -R $REF -Q $FLYE -breaklen 1000 --filter -t png --large --layout --fat -p $OUTDIR/flye  genome_flye.delta

# hifiasm
apptainer exec \
--bind $WORKDIR \
/containers/apptainer/mummer4_gnuplot.sif \
mummerplot -R $REF -Q $HIFIASM -breaklen 1000 --filter -t png --large --layout --fat -p $OUTDIR/hifiasm  genome_hifiasm.delta

# lja
apptainer exec \
--bind $WORKDIR \
/containers/apptainer/mummer4_gnuplot.sif \
mummerplot -R $REF -Q $LJA -breaklen 1000 --filter -t png --large --layout --fat -p $OUTDIR/LJA  genome_LJA.delta