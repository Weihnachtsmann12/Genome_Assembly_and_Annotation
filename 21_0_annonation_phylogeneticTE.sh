#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --mem=8G
#SBATCH --partition=pibu_el8
#SBATCH --job-name=Insertion_Age
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_phylogeneticTE0_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_phylogeneticTE0_%j.e

# Go to working directory
cd /data/users/$USER/assembly_annotation_course

# Directories and file paths for input and output files
DIR_EDTA=/data/users/$USER/assembly_annotation_course/output/EDTA_annotation_flye
DIR_RT_DOMAIN_COPIA=$DIR_EDTA/Copia_sequences_flye.fa.rexdb-plant.dom.faa
DIR_RT_DOMAIN_GYPSI=$DIR_EDTA/Gypsy_sequences_flye.fa.rexdb-plant.dom.faa
RT_COPIA_PROTEIN=$DIR_EDTA/Copia_sequences_flye.fa.rexdb-plant.cls.pep
RT_GYPSY_PROTEIN=$DIR_EDTA/Gypsy_sequences_flye.fa.rexdb-plant.cls.pep

# Load modules
module load SeqKit/2.6.1
module load Clustal-Omega/1.2.4-GCC-10.3.0
module load FastTree/2.1.11-GCCcore-10.3.0

# Extract RT sequences for Copia (Ty1-RT)
grep Ty1-RT $DIR_RT_DOMAIN_COPIA >$DIR_EDTA/copia_list.txt
sed -i 's/>//' $DIR_EDTA/copia_list.txt
sed -i 's/ .\+//' $DIR_EDTA/copia_list.txt
seqkit grep -f $DIR_EDTA/copia_list.txt $DIR_RT_DOMAIN_COPIA -o $DIR_EDTA/Copia_RT.fasta

# Extract RT sequences for Gypsy (Ty3-RT)
grep Ty3-RT $DIR_RT_DOMAIN_GYPSI >$DIR_EDTA/gypsy_list.txt
sed -i 's/>//' $DIR_EDTA/gypsy_list.txt
sed -i 's/ .\+//' $DIR_EDTA/gypsy_list.txt
seqkit grep -f $DIR_EDTA/gypsy_list.txt $DIR_RT_DOMAIN_GYPSI -o $DIR_EDTA/Gypsy_RT.fasta