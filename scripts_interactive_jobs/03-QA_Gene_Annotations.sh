## Quality Assessment of Gene Annotations with BUSCO

# Commands for interactive jobs:
srun --partition=pibu_el8 --cpus-per-task=2 --mem-per-cpu=4000 --time=24:00:00 --pty bash

# 1. BUSCO: Quality Assessment of Gene Annotations

# 1. Run BUSCO on MAKER Annotations
module load BUSCO/5.4.2-foss-2021a
busco -i assembly.all.maker.proteins.fasta.renamed.longest.fasta -l brassicales_odb10 -o busco_output -m proteins
busco -i assembly.all.maker.transcripts.fasta.renamed.longest.fasta -l brassicales_odb10 -o busco_output -m transcriptome

# 2. Sequence homology to functionally validated proteins (UniProt database)
module load BLAST+/2.15.0-gompi-2021a
blastp -query assembly.all.maker.proteins.fasta.renamed.longest.fasta -db /data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa -num_threads 10 -outfmt 6 -evalue 1e-10 -out blast_output_proteins

# You can also map the protein putative functions to the MAKER produced GFF3 and FASTA files:
COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"

cp assembly.all.maker.proteins.fasta.renamed.filtered.fasta assembly.all.maker.proteins.fasta.renamed.filtered.fasta.Uniprot
cp filtered.genes.renamed.final.gff3 filtered.genes.renamed.final.gff3.Uniprot

$MAKERBIN/maker_functional_fasta /data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa blast_output_proteins assembly.all.maker.proteins.fasta.renamed.filtered.fasta > assembly.all.maker.proteins.fasta.renamed.filtered.fasta.Uniprot
$MAKERBIN/maker_functional_gff /data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa blast_output_proteins filtered.genes.renamed.final.gff3 > filtered.genes.renamed.final.gff3.Uniprot

