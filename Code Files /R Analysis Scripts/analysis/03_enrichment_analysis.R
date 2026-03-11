#!/usr/bin/env Rscript
# ============================================
# TDP-43 Chromosome X - Enrichment Analysis
# GO Terms & KEGG Pathways
# ============================================

# Load required libraries
library(clusterProfiler)
library(org.Hs.eg.db)
library(enrichplot)
library(ggplot2)
library(readr)

# ============================================
# 1. Setup
# ============================================

setwd("..")

# Load significant genes
sig_genes <- read_csv("results/differential_expression/DESeq2_significant_genes.csv")

# Create output directory
dir.create("results/enrichment", showWarnings = FALSE)

# ============================================
# 2. Convert Gene IDs to Entrez
# ============================================

cat("Converting gene IDs to Entrez...\n")

# Get gene symbols from Ensembl IDs
gene_list <- sig_genes$X1  # Adjust column name

# Map Ensembl to Entrez
gene_symbols <- bitr(gene_list, 
                     fromType = "ENSEMBL", 
                     toType = "ENTREZID",
                     OrgDb = org.Hs.eg.db)

# ============================================
# 3. GO Enrichment Analysis
# ============================================

cat("Running GO Enrichment Analysis...\n")

# Biological Process
go_bp <- enrichGO(gene = gene_symbols$ENTREZID,
                  OrgDb = org.Hs.eg.db,
                  ont = "BP",
                  pAdjustMethod = "BH",
                  pvalueCutoff = 0.05,
                  qvalueCutoff = 0.05,
                  readable = TRUE)

# Molecular Function
go_mf <- enrichGO(gene = gene_symbols$ENTREZID,
                  OrgDb = org.Hs.eg.db,
                  ont = "MF",
                  pAdjustMethod = "BH",
                  pvalueCutoff = 0.05,
                  qvalueCutoff = 0.05,
                  readable = TRUE)

# Cellular Component
go_cc <- enrichGO(gene = gene_symbols$ENTREZID,
                  OrgDb = org.Hs.eg.db,
                  ont = "CC",
                  pAdjustMethod = "BH",
                  pvalueCutoff = 0.05,
                  qvalueCutoff = 0.05,
                  readable = TRUE)

# Save GO results
write.csv(as.data.frame(go_bp), "results/enrichment/GO_Biological_Process.csv", row.names = FALSE)
write.csv(as.data.frame(go_mf), "results/enrichment/GO_Molecular_Function.csv", row.names = FALSE)
write.csv(as.data.frame(go_cc), "results/enrichment/GO_Cellular_Component.csv", row.names = FALSE)

# ============================================
# 4. KEGG Pathway Analysis
# ============================================

cat("Running KEGG Pathway Analysis...\n")

kegg <- enrichKEGG(gene = gene_symbols$ENTREZID,
                   organism = "hsa",
                   pAdjustMethod = "BH",
                   pvalueCutoff = 0.05,
                   qvalueCutoff = 0.05)

# Save KEGG results
write.csv(as.data.frame(kegg), "results/enrichment/KEGG_Pathways.csv", row.names = FALSE)

# ============================================
# 5. Visualization
# ============================================

cat("Creating enrichment plots...\n")

# GO Dot Plot
pdf("visualizations/go_enrichment.pdf", width = 10, height = 8)
dotplot(go_bp, showCategory = 15) + 
  ggtitle("GO Biological Process Enrichment")
dev.off()

# KEGG Dot Plot
pdf("visualizations/kegg_enrichment.pdf", width = 10, height = 6)
dotplot(kegg, showCategory = 10) + 
  ggtitle("KEGG Pathway Enrichment")
dev.off()

# Enrichment Map
pdf("visualizations/enrichment_map.pdf", width = 10, height = 10)
emapplot(go_bp, showCategory = 20)
dev.off()

cat("✓ Enrichment analysis complete!\n")
cat("Results saved to: results/enrichment/\n")
