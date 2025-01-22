#!/usr/bin/env bash

#SBATCH --time=7-00:00:00
#SBATCH --mem=100G
#SBATCH --cpus-per-task=30
#SBATCH --job-name=edta
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_edta_flye_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_edta_flye_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mrubin/assembly_annotation_course
OUTDIR=$WORKDIR/output/EDTA_annotation_flye
IMAGE=/data/courses/assembly-annotation-course/containers2/EDTA_v1.9.6.sif
CDS="/data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10_cds_20110103_representative_gene_model_updated"
ASSEMBLY=$WORKDIR/flye_output_2.9.5/assembly.fasta
mkdir -p $OUTDIR

cd $OUTDIR 

apptainer exec -C -H $WORKDIR -H ${pwd}:/work \
 --writable-tmpfs -u $IMAGE EDTA.pl \
 --genome $ASSEMBLY \
 --species others \
 --step all \
 --cds $CDS \
 --anno 1 \
 --threads 30

# $WORKDIR/flye_output_2.9.5/assembly.fasta

# extract families and identities of intact full length LTR-RTs
# awk -F ';' '/ltr_identity=/ {print $4  $6}'  assembly.fasta.mod.LTR.intact.gff3 | grep 'Classification' | sed 's/Classification=/ /' | sed 's/ltr_identity=/ /' > families_identity.txt
# awk -F ';' '/ltr_identity=/ {print $4  $6}' assembly.fasta.mod.LTR.intact.gff3 | grep 'Classification' | sed 's/Classification=/ /' | sed 's/ltr_identity=/ /' | uniq > families_identity_unique.txt