
### Pipeline Steps:

1. **Quality Control (FastQC)** - Assess raw sequencing data quality
2. **Trimming (fastp)** - Remove adapters and low-quality reads (Q>20, length>36bp)
3. **Quantification (Salmon)** - Quasi-mapping to Chromosome X transcriptome
4. **Aggregation (tximport)** - Summarize transcript counts to gene level
5. **Differential Expression (DESeq2)** - Identify significant gene changes
6. **Visualization** - Volcano plots, heatmaps, PCA

---

## 📈 Visualizations

### Volcano Plot - Differentially Expressed Genes

![Volcano Plot](visualizations/volcano_plot.png)

*Red: Upregulated (16 genes) | Blue: Downregulated (7 genes) | Grey: Not significant*

### PCA Plot - Sample Clustering

![PCA Plot](visualizations/pca_plot.png)

*PC1 (49.7% variance) separates KO from WT samples*

### Heatmap - Gene Expression Patterns

![Heatmap](visualizations/heatmap.png)

*Z-score scaled expression for 23 significant genes*

---

## 👥 Team

| Name | Role |
|------|------|
| **Haitham Alahmadi** | Bioinformatics Analysis |
| **Ibrahim Eissa** | Pipeline Development & QC |
| **Ahmed Mawlawi** | Data Visualization |

---

## 📜 License

This project is for educational and research purposes.

---

## 📧 Contact

**Ibrahim Eissa Abu Alghayth**  
📧 ibrahim.abualg@gmail.com  
🔗 [LinkedIn](https://linkedin.com/in/yourname)  
🐙 [GitHub](https://github.com/Ibrah1m1)

---

## 🔗 Related Links

- [KAUST Academy](https://kaust.edu.sa)
- [DESeq2 Documentation](https://bioconductor.org/packages/DESeq2)
- [Salmon Documentation](https://salmon.readthedocs.io)
- [GEO Dataset (GSE136366)](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE136366)
