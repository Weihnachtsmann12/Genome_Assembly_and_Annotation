#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --mem=8G
#SBATCH --partition=pibu_el8
#SBATCH --job-name=Insertion_Age
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_phylogeneticTE2_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_phylogeneticTE2_%j.e

# Go to working directory
cd /data/users/$USER/assembly_annotation_course

# Directories and file paths for input and output files
DIR_EDTA=/data/users/$USER/assembly_annotation_course/output/EDTA_annotation_flye
DIR_RT_DOMAIN_COPIA_BRA=$DIR_EDTA/Copia_sequences_Brassicaceae.fa.rexdb-plant.dom.faa
DIR_RT_DOMAIN_GYPSI_BRA=$DIR_EDTA/Gypsy_sequences_Brassicaceae.fa.rexdb-plant.dom.faa

# Load modules
module load SeqKit/2.6.1

# Extract RT sequences for Copia (Ty1-RT) from Brassicaceae
grep Ty1-RT $DIR_RT_DOMAIN_COPIA_BRA >$DIR_EDTA/Copia_list_Brassicaceae.txt
sed -i 's/>//' $DIR_EDTA/Copia_list_Brassicaceae.txt
sed -i 's/ .\+//' $DIR_EDTA/Copia_list_Brassicaceae.txt
seqkit grep -f $DIR_EDTA/Copia_list_Brassicaceae.txt $DIR_RT_DOMAIN_COPIA_BRA -o $DIR_EDTA/Copia_RT_Brassicaceae.fasta

# Extract RT sequences for Gypsy (Ty3-RT) from Brassicaceae
grep Ty3-RT $DIR_RT_DOMAIN_GYPSI_BRA >$DIR_EDTA/Gypsy_list_Brassicaceae.txt
sed -i 's/>//' $DIR_EDTA/Gypsy_list_Brassicaceae.txt
sed -i 's/ .\+//' $DIR_EDTA/Gypsy_list_Brassicaceae.txt
seqkit grep -f $DIR_EDTA/Gypsy_list_Brassicaceae.txt $DIR_RT_DOMAIN_GYPSI_BRA -o $DIR_EDTA/Gypsy_RT_Brassicaceae.fasta