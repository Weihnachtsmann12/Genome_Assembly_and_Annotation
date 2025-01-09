#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=05:00:00
#SBATCH --job-name=clades
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_get_clades_LJA_3_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_get_clades_LJA_3_%j.e
#SBATCH --partition=pibu_el8

# for the LJA assembly
# WORKDIR=/data/users/mrubin/assembly_annotation_course
# OUTDIR=$WORKDIR/output/EDTA_annotation_LJA_3/assembly.fasta.mod.EDTA.raw/LTR
# IMAGE=/data/courses/assembly-annotation-course/containers2/TEsorter_1.3.0.sif
# ASSEMBLY=$WORKDIR/lja_output/assembly.fasta
# DUSTED=$OUTDIR/assembly.fasta.mod.LTR.intact.fa

# cd $OUTDIR

# apptainer exec -C -H $WORKDIR -H ${pwd}:/work \
#  --writable-tmpfs -u $IMAGE TEsorter $DUSTED -db rexdb-plant

# for the flye assembly
WORKDIR=/data/users/mrubin/assembly_annotation_course
OUTDIR=$WORKDIR/output/EDTA_annotation_flye/assembly.fasta.mod.EDTA.raw/LTR
IMAGE=/data/courses/assembly-annotation-course/containers2/TEsorter_1.3.0.sif
ASSEMBLY=$WORKDIR/flye_output_2.9.5/assembly.fasta
DUSTED=$OUTDIR/assembly.fasta.mod.LTR.intact.fa.ori.dusted

cd $OUTDIR

apptainer exec -C -H $WORKDIR -H ${pwd}:/work \
 --writable-tmpfs -u $IMAGE TEsorter $DUSTED -db rexdb-plant