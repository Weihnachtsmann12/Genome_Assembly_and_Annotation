#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --mem=8G
#SBATCH --partition=pibu_el8
#SBATCH --job-name=Insertion_Age
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_phylogeneticTE1_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_phylogeneticTE1_%j.e

# Go to working directory
cd /data/users/$USER/assembly_annotation_course

# Directories and file paths for input and output files
DIR_EDTA=/data/users/$USER/assembly_annotation_course/output/EDTA_annotation_flye
Brassicaceae_TE_db=/data/courses/assembly-annotation-course/CDS_annotation/data/Brassicaceae_repbase_all_march2019.fasta

# Load the SeqKit module
module load SeqKit/2.6.1

seqkit grep -r -p "Copia" $Brassicaceae_TE_db > $DIR_EDTA/Copia_sequences_Brassicaceae.fa
seqkit grep -r -p "Gypsy" $Brassicaceae_TE_db > $DIR_EDTA/Gypsy_sequences_Brassicaceae.fa

# TEsorter for Copia retrotransposons
apptainer exec -C -H $DIR_EDTA \
 --writable-tmpfs -u /data/courses/assembly-annotation-course/containers2/TEsorter_1.3.0.sif TEsorter $DIR_EDTA/Copia_sequences_Brassicaceae.fa -db rexdb-plant

# TEsorter for Gypsy retrotransposons
apptainer exec -C -H $DIR_EDTA \
 --writable-tmpfs -u /data/courses/assembly-annotation-course/containers2/TEsorter_1.3.0.sif TEsorter $DIR_EDTA/Gypsy_sequences_Brassicaceae.fa -db rexdb-plant