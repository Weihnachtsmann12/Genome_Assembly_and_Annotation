## Comparative Genomics with OrthoFinder and GENESPACE

# Step 1: Prepare the GENESPACE files and scripts
# Sample Input Preparation:
module add Anaconda3/2022.05
conda config --add channels conda-forge
conda create -n my_r_env r-essentials
srun --partition=pibu_el8 --cpus-per-task=10 --mem-per-cpu=40000 --time=12:00:00 --pty bash
conda init bash
conda activate my_r_env
Rscript /data/users/mrubin/assembly_annotation_course/scripts/24-genespace_folder.R

# Step 2: Prepare GENESPACE in R
/data/users/mrubin/assembly_annotation_course/scripts/25-genespace.R

# Step 3: Run GENESPACE
COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
WORKDIR="/data/users/mrubin/assembly_annotation_course"
GENESPACE=/data/users/mrubin/assembly_annotation_course/gene_annotation_directory/assembly.maker.output/final/genespace

apptainer exec --bind $COURSEDIR --bind "$WORKDIR" --bind "$SCRATCH:/temp" "$COURSEDIR/containers/genespace_latest.sif" Rscript "$WORKDIR/scripts/25-genespace.R" $GENESPACE

# Step 4: Explore and Visualize Results
Rscript /data/users/mrubin/assembly_annotation_course/scripts/27-parse_Orthofinder.R















