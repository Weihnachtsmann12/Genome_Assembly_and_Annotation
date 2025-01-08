#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=quast
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_quast_without_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_quast_without_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mrubin/assembly_annotation_course
OUTDIR=$WORKDIR/quast_output_without
mkdir -p $OUTDIR

apptainer exec \
--bind $WORKDIR \
/containers/apptainer/quast_5.2.0.sif \
quast.py \
$WORKDIR/flye_output_2.9.5/assembly.fasta $WORKDIR/hifiasm/Pyl-1.asm.bp.p_ctg.fa $WORKDIR/lja_output/assembly.fasta \
--eukaryote \
--large \
--threads 4 \
--labels flye,hifiasm,lja \
--est-ref-size 135000000 \
-o $OUTDIR