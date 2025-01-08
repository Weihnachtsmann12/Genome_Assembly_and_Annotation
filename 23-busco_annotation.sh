#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=busco
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_busco_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_busco_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mrubin/assembly_annotation_course/gene_annotation_directory/assembly.maker.output/final

cd $WORKDIR

module load BUSCO/5.4.2-foss-2021a
busco -i assembly.all.maker.proteins.fasta.renamed.longest.fasta -l brassicales_odb10 -o busco_output_proteins -m proteins
busco -i assembly.all.maker.transcripts.fasta.renamed.longest.fasta -l brassicales_odb10 -o busco_output_transcripts -m transcriptome