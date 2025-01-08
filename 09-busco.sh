#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=busco
#SBATCH --output=/data/users/mrubin/assembly_annotation_course/output_busco_%j.o
#SBATCH --error=/data/users/mrubin/assembly_annotation_course/error_busco_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mrubin/assembly_annotation_course
OUTDIR=$WORKDIR/busco_output
mkdir -p $OUTDIR
mkdir -p $WORKDIR/busco_downloads

module load BUSCO/5.4.2-foss-2021a
busco -i $WORKDIR/flye_output_2.9.5/assembly.fasta --mode genome --lineage brassicales_odb10 --cpu 16 -o $OUTDIR/flye_assembly --download_path $WORKDIR/busco_downloads --force
busco -i $WORKDIR/hifiasm/Pyl-1.asm.bp.p_ctg.fa --mode genome --lineage brassicales_odb10 --cpu 16 -o $OUTDIR/hifiasm_assembly --download_path $WORKDIR/busco_downloads --force
busco -i $WORKDIR/lja_output/assembly.fasta --mode genome --lineage brassicales_odb10 --cpu 16 -o $OUTDIR/lja_assembly --download_path $WORKDIR/busco_downloads --force
busco -i $WORKDIR/trinity_output/trinity_output.Trinity.fasta --mode transcriptome --lineage brassicales_odb10 --cpu 16 -o $OUTDIR/trinity_assembly --download_path $WORKDIR/busco_downloads --force