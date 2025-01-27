## 5. Output Preparation after MAKER

# Commands for interactive jobs:
srun --partition=pibu_el8 --cpus-per-task=2 --mem-per-cpu=4000 --time=03:00:00 --pty bash

MAKERBIN="/data/courses/assembly-annotation-course/CDS_annotation/softwares/Maker_v3.01.03/src/bin"
$MAKERBIN/gff3_merge -s -d /data/users/mrubin/assembly_annotation_course/gene_annotation_directory/assembly.maker.output/assembly_master_datastore_index.log > assembly.all.maker.gff
$MAKERBIN/gff3_merge -n -s -d /data/users/mrubin/assembly_annotation_course/gene_annotation_directory/assembly.maker.output/assembly_master_datastore_index.log > assembly.all.maker.noseq.gff
$MAKERBIN/fasta_merge -d /data/users/mrubin/assembly_annotation_course/gene_annotation_directory/assembly.maker.output/assembly_master_datastore_index.log -o assembly
