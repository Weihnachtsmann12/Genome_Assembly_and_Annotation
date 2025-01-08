#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=05:00:00
#SBATCH --job-name=control
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_control_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_control_%j.e
#SBATCH --partition=pibu_el8

# for the LJA assembly
WORKDIR=/data/users/mrubin/assembly_annotation_course/gene_annotation_directory

cd $WORKDIR

apptainer exec \
--bind /data \
/data/courses/assembly-annotation-course/CDS_annotation/containers/MAKER_3.01.03.sif maker -CTL

