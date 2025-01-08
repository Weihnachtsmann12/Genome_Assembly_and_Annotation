#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=hifiasm
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_hifiasm_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_hifiasm_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mrubin/assembly_annotation_course
OUTDIR=$WORKDIR/hifiasm
mkdir -p $OUTDIR

apptainer exec \
--bind $WORKDIR \
/containers/apptainer/hifiasm_0.19.8.sif \
hifiasm -o $OUTDIR/Pyl-1.asm -t 16 $WORKDIR/Pyl-1/ERR11437347.fastq.gz

# am schluss output file noch umwandeln
# awk '/^S/{print ">"$2;print $3}' Pyl-1.asm.bp.p_ctg.gfa > Pyl-1.asm.bp.p_ctg.fa