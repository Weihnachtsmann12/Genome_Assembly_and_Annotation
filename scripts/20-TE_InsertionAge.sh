#!/bin/bash

#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --mem=8G
#SBATCH --partition=pibu_el8
#SBATCH --job-name=Insertion_Age
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_Insertion_Age_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_Insertion_Age_%j.e

# Go to working directory
cd /data/users/$USER/assembly_annotation_course

# Define the directory for the EDTA output
DIR_EDTA=/data/users/$USER/assembly_annotation_course/output/EDTA_annotation_flye
DIR_REPEATMASKER=$DIR_EDTA/assembly.fasta.mod.EDTA.anno

# Download parseRM.pl
wget -P $DIR_REPEATMASKER https://raw.githubusercontent.com/4ureliek/Parsing-RepeatMasker-Outputs/master/parseRM.pl

# Make parseRM.pl executable
chmod +x $DIR_REPEATMASKER/parseRM.pl

# Load the BioPerl module
module load BioPerl/1.7.8-GCCcore-10.3.0

# Run parseRM.pl to process RepeatMasker
perl $DIR_REPEATMASKER/parseRM.pl -i $DIR_REPEATMASKER/assembly.fasta.mod.out -l 50,1 -v > $DIR_REPEATMASKER/parsed_TE_divergence_output.tsv
