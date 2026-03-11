#!/usr/bin/env Rscript
# ============================================
# TDP-43 Chromosome X - Differential Expression Analysis
# Using tximport + DESeq2
# ============================================

# Load required libraries
library(tximport)
library(DESeq2)
library(readr)
library(dplyr)

# ============================================
# 1. Setup & Configuration
# ============================================

setwd("..")  # Go to project root

# Sample information
samples <- read_tsv("config/samples.tsv")

# Get paths to salmon quantification files
quant_dirs <- file.path("results/quantification", samples$sample_id, "quant.sf")
names(quant_dirs) <- samples$sample_id

# ============================================
# 2. Import Salmon Quantifications with tximport
# ============================================

cat("Importing Salmon quantifications with tximport...\n")

txi <- tximport(
  files = quant_dirs,
  type = "salmon",
  txOut = FALSE,  # Summarize to gene level
  ignoreTxVersion = TRUE
)

cat("✓ Imported", nrow(txi$counts), "genes\n")

# ============================================
# 3. Create DESeq2 Dataset
# ============================================

cat("Creating DESeq2 dataset...\n")

# Design matrix
col_data <- data.frame(
  row.names = samples$sample_id,
  condition = factor(samples$condition),
  replicate = factor(samples$replicate)
)

# Create DESeq2 object
dds <- DESeqDataSetFromTximport(
  txi = txi,
  colData = col_data,
  design = ~ condition
)

# ============================================
# 4. Run DESeq2 Analysis
# ============================================

cat("Running DESeq2 differential expression analysis...\n")

dds <- DESeq(dds)

# Get results
res <- results(dds, 
               contrast = c("condition", "knockout", "wildtype"),
               alpha = 0.05,
               lfcThreshold = 1,
               altHypothesis = "greaterAbs")

# Shrink log2 fold changes
res_shrunk <- lfcShrink(dds, 
                        coef = "condition_knockout_vs_wildtype", 
                        type = "apeglm")

# ============================================
# 5. Save Results
# ============================================

cat("Saving results...\n")

# Create output directory
dir.create("results/differential_expression", showWarnings = FALSE)

# Save all results
write.csv(as.data.frame(res), 
          "results/differential_expression/DESeq2_all_genes.csv",
          row.names = TRUE)

# Save significant genes
sig_genes <- res %>%
  as.data.frame() %>%
  filter(padj < 0.05 & abs(log2FoldChange) > 1) %>%
  arrange(padj)

write.csv(sig_genes,
          "results/differential_expression/DESeq2_significant_genes.csv",
          row.names = TRUE)

# Save shrinked results
write.csv(as.data.frame(res_shrunk),
          "results/differential_expression/DESeq2_shrunk_results.csv",
          row.names = TRUE)

# ============================================
# 6. Summary Statistics
# ============================================

cat("\n========== DESeq2 Summary ==========\n")
cat("Total genes analyzed:", nrow(res), "\n")
cat("Upregulated (log2FC > 1, padj < 0.05):", 
    sum(res$log2FoldChange > 1 & res$padj < 0.05, na.rm = TRUE), "\n")
cat("Downregulated (log2FC < -1, padj < 0.05):", 
    sum(res$log2FoldChange < -1 & res$padj < 0.05, na.rm = TRUE), "\n")
cat("Total significant DEGs:", nrow(sig_genes), "\n")
cat("=====================================\n\n")

# Save summary
summary_stats <- data.frame(
  metric = c("Total Genes", "Upregulated", "Downregulated", "Total DEGs"),
  count = c(nrow(res), 
            sum(res$log2FoldChange > 1 & res$padj < 0.05, na.rm = TRUE),
            sum(res$log2FoldChange < -1 & res$padj < 0.05, na.rm = TRUE),
            nrow(sig_genes))
)
write.csv(summary_stats,
          "results/differential_expression/summary_statistics.csv",
          row.names = FALSE)

cat("✓ Analysis complete!\n")
cat("Results saved to: results/differential_expression/\n")
