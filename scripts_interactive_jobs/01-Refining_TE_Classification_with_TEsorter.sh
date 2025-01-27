## 3. Refining TE Classification with TEsorter
# Step 1: Extract Copia and Gypsy Sequences

# Commands for interactive jobs:
srun --partition=pibu_el8 --cpus-per-task=2 --mem-per-cpu=4000 --time=03:00:00 --pty bash

# Extract Copia sequences 
seqkit grep -r -p "Copia" assembly.fasta.mod.EDTA.TElib.fa > Copia_sequences_flye.fa

# Extract Gypsy sequences 
seqkit grep -r -p "Gypsy" assembly.fasta.mod.EDTA.TElib.fa > Gypsy_sequences_flye.fa

# Step 2: Run TEsorter
apptainer exec -C -H $WORKDIR -H ${pwd}:/work --writable-tmpfs -u /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif TEsorter Copia_sequences_flye.fa -db rexdb-plant 
apptainer exec -C -H $WORKDIR -H ${pwd}:/work --writable-tmpfs -u /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif TEsorter Gypsy_sequences_flye.fa -db rexdb-plant
