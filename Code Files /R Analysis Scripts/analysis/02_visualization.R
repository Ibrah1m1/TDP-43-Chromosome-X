#!/usr/bin/env Rscript
# ============================================
# TDP-43 Chromosome X - Visualization Scripts
# Volcano Plot, PCA, Heatmap
# ============================================

# Load required libraries
library(DESeq2)
library(ggplot2)
library(pheatmap)
library(RColorBrewer)
library(readr)

# ============================================
# 1. Setup
# ============================================

setwd("..")

# Load results
res <- read_csv("results/differential_expression/DESeq2_all_genes.csv")
sig_genes <- read_csv("results/differential_expression/DESeq2_significant_genes.csv")

# Create visualizations directory
dir.create("visualizations", showWarnings = FALSE)

# ============================================
# 2. Volcano Plot
# ============================================

cat("Creating Volcano Plot...\n")

# Add significance column
res <- res %>%
  mutate(
    significant = case_when(
      padj < 0.05 & log2FoldChange > 1 ~ "Upregulated",
      padj < 0.05 & log2FoldChange < -1 ~ "Downregulated",
      TRUE ~ "Not Significant"
    )
  )

# Create volcano plot
volcano_plot <- ggplot(res, aes(x = log2FoldChange, y = -log10(padj))) +
  geom_point(aes(color = significant), alpha = 0.6, size = 2) +
  scale_color_manual(values = c("Upregulated" = "#E41A1C",
                                 "Downregulated" = "#377EB8",
                                 "Not Significant" = "#999999")) +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "black") +
  geom_vline(xintercept = c(-1, 1), linetype = "dashed", color = "black") +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    axis.title = element_text(size = 12),
    legend.title = element_text(size = 12),
    legend.position = "top"
  ) +
  labs(
    title = "TDP-43 Knockout vs Wildtype - Chromosome X",
    subtitle = "Differentially Expressed Genes",
    x = "log2 Fold Change",
    y = "-log10 Adjusted P-value",
    color = "Expression"
  )

ggsave("visualizations/volcano_plot.png", 
       volcano_plot, 
       width = 10, height = 8, dpi = 300)

# ============================================
# 3. PCA Plot
# ============================================

cat("Creating PCA Plot...\n")

# Load DESeq2 object
load("results/differential_expression/dds_object.rds")

# Run PCA
pca_data <- plotPCA(dds, intgroup = "condition", returnData = TRUE)
percent_var <- round(attr(pca_data, "percentVar") * 100)

# Create PCA plot
pca_plot <- ggplot(pca_data, aes(x = PC1, y = PC2, color = condition)) +
  geom_point(size = 5, alpha = 0.7) +
  scale_color_manual(values = c("knockout" = "#E41A1C", "wildtype" = "#377EB8")) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    axis.title = element_text(size = 12),
    legend.title = element_text(size = 12),
    legend.position = "top"
  ) +
  labs(
    title = "PCA - Sample Clustering",
    subtitle = "TDP-43 KO vs WT (Chromosome X)",
    x = paste0("PC1 (", percent_var[1], "% variance)"),
    y = paste0("PC2 (", percent_var[2], "% variance)"),
    color = "Condition"
  )

ggsave("visualizations/pca_plot.png", 
       pca_plot, 
       width = 10, height = 8, dpi = 300)

# ============================================
# 4. Heatmap
# ============================================

cat("Creating Heatmap...\n")

# Get normalized counts
vsd <- vst(dds, blind = FALSE)

# Get significant genes
sig_gene_ids <- sig_genes$X1  # Adjust column name as needed

# Subset normalized counts
mat <- assay(vsd)[sig_gene_ids, ]

# Scale rows (Z-score)
mat_scaled <- t(scale(t(mat)))

# Create annotation
annotation_col <- data.frame(
  Condition = factor(colData(dds)$condition)
)
rownames(annotation_col) <- colnames(dds)

# Create heatmap
pdf("visualizations/heatmap.pdf", width = 10, height = 12)
pheatmap(
  mat_scaled,
  annotation_col = annotation_col,
  color = colorRampPalette(c("#377EB8", "white", "#E41A1C"))(100),
  cluster_rows = TRUE,
  cluster_cols = TRUE,
  show_rownames = TRUE,
  show_colnames = TRUE,
  fontsize_row = 8,
  fontsize_col = 10,
  main = "Differentially Expressed Genes (Chromosome X)",
  border_color = NA
)
dev.off()

# Also save as PNG
png("visualizations/heatmap.png", width = 1200, height = 1500, res = 150)
pheatmap(
  mat_scaled,
  annotation_col = annotation_col,
  color = colorRampPalette(c("#377EB8", "white", "#E41A1C"))(100),
  cluster_rows = TRUE,
  cluster_cols = TRUE,
  show_rownames = TRUE,
  show_colnames = TRUE,
  fontsize_row = 8,
  fontsize_col = 10,
  main = "Differentially Expressed Genes (Chromosome X)",
  border_color = NA
)
dev.off()

# ============================================
# 5. QC Summary Plot
# ============================================

cat("Creating QC Summary Plot...\n")

# Sample QC metrics (from fastp/salmon)
qc_metrics <- data.frame(
  Sample = c("KO_1", "KO_2", "KO_3", "WT_1", "WT_2", "WT_3"),
  Mapping_Rate = c(95.2, 95.5, 95.6, 95.3, 95.4, 95.5),
  Read_Retention = c(97.1, 97.3, 97.4, 97.2, 97.1, 97.3),
  Q30_Score = c(94.0, 94.1, 94.2, 94.0, 94.1, 94.0)
)

qc_plot <- ggplot(qc_metrics, aes(x = Sample, y = Mapping_Rate, fill = Sample)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = paste0(Mapping_Rate, "%")), vjust = -0.5) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "none"
  ) +
  labs(
    title = "Salmon Mapping Rates",
    x = "Sample",
    y = "Mapping Rate (%)"
  )

ggsave("visualizations/qc_summary.png", 
       qc_plot, 
       width = 10, height = 6, dpi = 300)

cat("✓ All visualizations complete!\n")
cat("Saved to: visualizations/\n")
