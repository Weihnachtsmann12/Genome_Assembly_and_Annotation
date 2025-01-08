#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=mercury
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_mercury_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_mercury_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mrubin/assembly_annotation_course
OUTDIR=$WORKDIR/mercury_output
FLYE=$WORKDIR/flye_output_2.9.5/assembly.fasta
HIFIASM=$WORKDIR/hifiasm/Pyl-1.asm.bp.p_ctg.fa
LJA=$WORKDIR/lja_output/assembly.fasta
FLYERES=$OUTDIR/flye
HIFIRES=$OUTDIR/hifiasm
LJARES=$OUTDIR/LJA

mkdir -p $OUTDIR $FLYERES $HIFIRES $LJARES

export MERQURY="/usr/local/share/merqury"

# find best kmer size
# apptainer exec \
# --bind $WORKDIR \
# /containers/apptainer/merqury_1.3.sif \
# $MERQURY/best_k.sh 135000000
# k = 18.4864
k=19

# build kmer dbs
apptainer exec \
--bind $WORKDIR \
/containers/apptainer/merqury_1.3.sif \
meryl k=$k count /data/users/mrubin/assembly_annotation_course/Pyl-1/ERR11437347.fastq.gz output $OUTDIR/meryl
#done

#run merqury
#flye
cd /data/users/mrubin/assembly_annotation_course/mercury_output/flye
apptainer exec \
--bind $WORKDIR \
/containers/apptainer/merqury_1.3.sif \
merqury.sh /data/users/mrubin/assembly_annotation_course/mercury_output/meryl $FLYE eval_flye  

#hifiasm
cd /data/users/mrubin/assembly_annotation_course/mercury_output/hifiasm
apptainer exec \
--bind $WORKDIR \
/containers/apptainer/merqury_1.3.sif \
merqury.sh /data/users/mrubin/assembly_annotation_course/mercury_output/meryl $HIFIASM eval_hifiasm  

#lja
cd /data/users/mrubin/assembly_annotation_course/mercury_output/LJA
apptainer exec \
--bind $WORKDIR \
/containers/apptainer/merqury_1.3.sif \
merqury.sh /data/users/mrubin/assembly_annotation_course/mercury_output/meryl $LJA eval_lja