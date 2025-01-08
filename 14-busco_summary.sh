#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --mem=8G
#SBATCH --partition=pibu_el8
#SBATCH --job-name=summary_busco
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_busco_summary_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_busco_summary_%j.e

# Go to working directory
# cd /data/users/mrubin/assembly_annotation_course

DIR_SUMMARY_BUSCO=/data/users/mrubin/assembly_annotation_course/busco_output/short_summaries_busco

# Create output directories 
# mkdir --parents $DIR_SUMMARY_BUSCO

# Run plot
apptainer exec /containers/apptainer/busco_5.7.1.sif python3 /usr/local/bin/generate_plot.py -wd $DIR_SUMMARY_BUSCO