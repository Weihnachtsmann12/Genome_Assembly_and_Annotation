## OMArk: Orthology based gene annotation quality check

# Commands for interactive jobs:
srun --partition=pibu_el8 --cpus-per-task=2 --mem-per-cpu=4000 --time=24:00:00 --pty bash

# 1. Install OMArk You can clone OMArk from the GitHub repository:
module add Anaconda3/2022.05
conda config --add channels conda-forge
conda create -n OMArk bioconda::omark bioconda::omamer
conda init bash
conda activate OMArk

# 2. Download the OMA Database and Run OMAmer
wget https://omabrowser.org/All/LUCA.h5
omamer search --db LUCA.h5 --query assembly.all.maker.proteins.fasta.renamed.fasta --out assembly.all.maker.proteins.fasta.renamed.fasta.omamer

# 3. Prepare the Input Files
OMArk requires a list of isoforms to be provided in a specific format. It should be semi-colon separated file, listing all isoforoms of each genes, with one gene per line.

# 4. Run OMArk
omark -f assembly.all.maker.proteins.fasta.renamed.fasta.omamer -of assembly.all.maker.proteins.fasta.renamed.fasta -i isoforms_list_2.txt -d LUCA.h5 -o omark_output

# 6. Steps to improve the gene annotation

conda init bash
conda activate OMArk
pip install omadb
pip install gffutils

COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"

$COURSEDIR/softwares/OMArk-0.3.0/utils/omark_contextualize.py fragment -m /data/users/mrubin/assembly_annotation_course/gene_annotation_directory/assembly.maker.output/final/assembly.all.maker.proteins.fasta.renamed.fasta.omamer -o /data/users/mrubin/assembly_annotation_course/gene_annotation_directory/assembly.maker.output/final/omark_output -f fragment_HOGs
$COURSEDIR/softwares/OMArk-0.3.0/utils/omark_contextualize.py missing -m /data/users/mrubin/assembly_annotation_course/gene_annotation_directory/assembly.maker.output/final/assembly.all.maker.proteins.fasta.renamed.fasta.omamer -o /data/users/mrubin/assembly_annotation_course/gene_annotation_directory/assembly.maker.output/final/omark_output -f missing_HOGs

git clone https://github.com/lh3/miniprot
cd miniprot && make

# Run MiniProt to map HOGs to the genome
miniprot -I --gff --outs=0.95 /data/users/mrubin/assembly_annotation_course/flye_output_2.9.5/assembly.fasta /data/users/mrubin/assembly_annotation_course/gene_annotation_directory/assembly.maker.output/final/missing_HOGs.fa > /data/users/mrubin/assembly_annotation_course/gene_annotation_directory/assembly.maker.output/final/miniprot_output/missing.gff
miniprot -I --gff --outs=0.95 /data/users/mrubin/assembly_annotation_course/flye_output_2.9.5/assembly.fasta /data/users/mrubin/assembly_annotation_course/gene_annotation_directory/assembly.maker.output/final/fragment_HOGs > /data/users/mrubin/assembly_annotation_course/gene_annotation_directory/assembly.maker.output/final/miniprot_output/fragment.gff









