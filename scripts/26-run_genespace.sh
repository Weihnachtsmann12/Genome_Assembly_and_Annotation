#!/bin/bash

#SBATCH --time=05:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=25
#SBATCH --job-name=genespace
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/gene_annotation_directory/assembly.maker.output/final/genespace_%j.out
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/gene_annotation_directory/assembly.maker.output/final/genespace_%j.err

COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
WORKDIR="/data/users/mrubin/assembly_annotation_course"
GENESPACE=/data/users/mrubin/assembly_annotation_course/gene_annotation_directory/assembly.maker.output/final/genespace

apptainer exec --bind $COURSEDIR --bind "$WORKDIR" --bind "$SCRATCH:/temp" "$COURSEDIR/containers/genespace_latest.sif" Rscript "$WORKDIR/scripts/25-genespace.R" $GENESPACE