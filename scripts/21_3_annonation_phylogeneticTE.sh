#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --mem=8G
#SBATCH --partition=pibu_el8
#SBATCH --job-name=Insertion_Age
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_phylogeneticTE3_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_phylogeneticTE3_%j.e

# Go to working directory
cd /data/users/$USER/assembly_annotation_course

# Directories and file paths for input and output files
DIR_EDTA=/data/users/$USER/assembly_annotation_course/output/EDTA_annotation_flye

# Load modules
module load Clustal-Omega/1.2.4-GCC-10.3.0
module load FastTree/2.1.11-GCCcore-10.3.0

# Concatenate RT Sequences from Both Brassicaceae and Arabidopsis
cat $DIR_EDTA/Copia_RT.fasta $DIR_EDTA/Copia_RT_Brassicaceae.fasta >$DIR_EDTA/Concatenated_Copia_RT.fasta
cat $DIR_EDTA/Gypsy_RT.fasta $DIR_EDTA/Gypsy_RT_Brassicaceae.fasta >$DIR_EDTA/Concatenated_Gypsy_RT.fasta

# Clustal Omega for multiple sequence alignment
clustalo -i $DIR_EDTA/Concatenated_Copia_RT.fasta -o $DIR_EDTA/Aligned_Copia_RT.fasta --outfmt=fasta
clustalo -i $DIR_EDTA/Concatenated_Gypsy_RT.fasta -o $DIR_EDTA/Aligned_Gypsy_RT.fasta --outfmt=fasta

# FastTree to build phylogenetic trees
FastTree -out $DIR_EDTA/Aligned_Copia_RT_tree.nwk $DIR_EDTA/Aligned_Copia_RT.fasta
FastTree -out $DIR_EDTA/Aligned_Gypsy_RT_tree.nwk $DIR_EDTA/Aligned_Gypsy_RT.fasta