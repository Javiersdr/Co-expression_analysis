# First, change this if you want your matrices unfiltered or a different threshold
# For now, this threshold works for both positive and negative correlations
FILTER_MAT <- TRUE
FILTER_THRESHOLD <- 0.8

WD <- ("/data1/datos_javi/IHSM/Co-expression_analysis/example/")
setwd(WD)
if (!file.exists("cors"))
  dir.create("cors")
# Read the genes and module file
genes_in_modules <- read.table("gene_cluster.txt", header = T, sep = "\t")
# Read also your normalized matrix
data <- read.table("CTFnormalisedCPMs-2024-11-26_09.36.30.tsv", header = T)
# And keep only the genes that passed the WGCNA filter
data <- data[rownames(data) %in% genes_in_modules$gene_id,]
for (col in unique(genes_in_modules$colors)) {
  mat <- cor(t(data[genes_in_modules$colors == col,]))
  mat <- as.data.frame(mat)
  mat[lower.tri(mat)] <- NA # We only need 1 diagonal
  # We will replace correlations lower than threshold with NA for storage optimization
  if (FILTER_MAT) {
    mat[upper.tri(mat)] <- ifelse(
      abs(mat[upper.tri(mat)]) < FILTER_THRESHOLD,
      NA,
      mat[upper.tri(mat)]
    )
  }
  mat <- format(mat, digits = 4, nsmall = 4) # Keep 4 digits
  output_file <- paste0("cors/", col, "_cor.tsv")
  write.table(mat, output_file, sep = "\t", quote = F, col.names = NA)
  print(paste0(col, " matrix finished!"))
}