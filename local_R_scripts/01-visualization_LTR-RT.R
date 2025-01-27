## 1. TE Annotation using EDTA 
## making histograms with the identity and familys of LTRs

## make the visuals for the LTRs from the Flye assembly
# Load the data
data <- read.table("families_identity_unique_flye.txt", header = FALSE, stringsAsFactors = FALSE)

# Rename columns
colnames(data) <- c("Classification", "Identity")

# Load ggplot2
library(ggplot2)

# Plot histograms side by side for each classification
ggplot(data, aes(x = Identity, fill = Classification)) +
  geom_histogram(binwidth = 0.01, color = "black", alpha = 0.7) +
  facet_wrap(~ Classification) +  # Facet by Classification to create separate histograms
  theme_minimal() +               # Use a minimal theme
  labs(title = "Histograms of LTR Identity by Classification", x = "LTR Identity", y = "Count")


## making the histrograms for the clades of the LTRs
library(dplyr)
library(tidyr)
library(ggplot2)

TEoutput <- "flye_assembly.fasta.mod.LTR.intact.fa.ori.dusted.rexdb-plant.cls.tsv"
LTRgff <- "flye_assembly.fasta.mod.LTR.intact.gff3"

tesorter_data <- read.csv2(TEoutput, header=T, sep = "\t")
clade_data <- tesorter_data[, c("X.TE", "Clade", "Superfamily")]
colnames(clade_data) <- c("ID", "Clade", "Superfamily")
clade_data$ID <- sub("#.*$", "", clade_data$ID)

gff_data <- read.table(LTRgff, header = FALSE, comment.char = "#", stringsAsFactors = FALSE)
gff_relevant <- gff_data %>%
  filter(V3 == "repeat_region") %>%  # Filter for repeat_region entries
  mutate(
    # Extract the ID from the attributes column (V9)
    ID = sub(".*?Name=([^;]+);.*", "\\1", V9),  # Extract Name for ID
    Classification = sub(".*?Classification=([^;]+);.*", "\\1", V9),  # Extract Classification
    ltr_identity = sub(".*?ltr_identity=([^;]+);.*", "\\1", V9)  # Extract ltr_identity
  ) %>%
  # Select only the columns we need
  select(ID, Classification, ltr_identity)

combined_data <- merge(clade_data, gff_relevant, by = "ID", all.x = TRUE)
combined_data$ltr_identity <- as.numeric(combined_data$ltr_identity)

ggplot(combined_data, aes(x = ltr_identity, fill = Superfamily)) +
  geom_histogram(binwidth = 0.005, color = "black", alpha = 0.7) +
  facet_wrap(~ Clade) +  # Facet by clade, allowing each plot to have its own y-axis scale
  labs(title = "Distribution of LTR Identity by Clade",
       x = "LTR Identity",
       y = "Count") +
  theme_minimal()