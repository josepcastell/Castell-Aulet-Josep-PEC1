# Carregar les llibreries
library(readxl)
library(tools)

# Definir el camí de l'arxiu
file_path <- "C:/Users/jca19/Desktop/metaboData-main/Datasets/2018-Phosphoproteomics/TIO2+PTYR-human-MSS+MSIvsPD.XLSX"

# Carregar el fitxer Excel
data <- read_excel(file_path, sheet = "originalData")

# Definir les columnes de metadades i de dades de mesura
metadades <- c("SequenceModifications", "Accession", "Description", "CLASS", "PHOSPHO")
dades_mesura <- setdiff(names(data), metadades)

# Extreure les dades de mesura i metadades
row_data <- data[, dades_mesura]
col_data <- data[, metadades]

# 1. Determinar el format de l'arxiu
file_format <- tools::file_ext(file_path)
cat("El format de l'arxiu és:", file_format, "\n")

# 2. Comptar el nombre de seqüències
num_sequences <- nrow(data)
cat("Nombre de seqüències disponibles:", num_sequences, "\n")

# 3. Obtenir la tecnologia de seqüenciació (si està disponible)
if ("Technology" %in% colnames(data)) {
  tech <- unique(data$Technology)
  cat("Tecnologia utilitzada:", tech, "\n")
} else {
  cat("No es troba informació directa sobre la tecnologia en les columnes disponibles.\n")
}

# 4. Determinar l'espècie seqüenciada
species <- unique(gsub(".*OS=([A-Za-z ]+) .*", "\\1", data$Description))
cat("Espècie que s'ha seqüenciat:", species, "\n")

# 5. Estructura de les dades
print(str(data))  # Estructura del dataset

# 6. Comprovació de valors NA
na_counts <- colSums(is.na(data))
print(na_counts[na_counts > 0])  # Columnes amb valors NA i la seva quantitat

# 7. Exploració de les metadades
print(head(col_data)) 

# 8. Exploració de les dades de mesura
print(summary(row_data))

