#  TDP-43 Loss: Chromosome X Transcriptomic Analysis

> **KAUST Academy - Bioinformatics Advanced Program (Stage 3)**  
> **Contributing to ALS Research through Computational Biology**

<div align="center">

![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![KAUST](https://img.shields.io/badge/KAUST-Academy-005DAA?style=for-the-badge&logo=google-scholar&logoColor=white)
![Bioinformatics](https://img.shields.io/badge/Bioinformatics-Pipeline-4CAF50?style=for-the-badge)

</div>

---

##  Overview

This project analyzes the transcriptomic impact of **TDP-43 protein loss** on **Human Chromosome X**, contributing to **ALS (Amyotrophic Lateral Sclerosis)** research. TDP-43 mislocalization is present in **>97% of ALS cases**, making it a critical target for understanding disease mechanisms.

**Completed with Distinction** at KAUST Academy Bioinformatics Advanced Program (Stage 3).

---

##  Objectives

- Analyze differential gene expression between **TDP-43 knockout (KD)** vs. **wild-type (WT)** samples.
- Build a reproducible **RNA-seq analysis pipeline** using Linux-based tools.
- Identify potential **X-linked biomarkers** for ALS.
- Achieve high-quality mapping and quantification metrics.

---

##  Technologies & Tools

| Tool | Purpose |
|------|---------|
| **FastQC** | Quality control of raw sequencing data |
| **fastp** | Adapter trimming and quality filtering |
| **Salmon** | Transcript quantification (quasi-mapping) |
| **DESeq2** | Differential expression analysis |
| **tximport** | Gene-level aggregation |
| **R/Python** | Data analysis and visualization |
| **Linux/WSL** | Computational environment |

---

##  Key Results

| Metric | Value |
|--------|-------|
| **Dataset** | GSE136366 (HeLa Cells, WT vs. KD) |
| **Mapping Rate** | **95.42%** (Salmon quasi-mapping) |
| **Read Retention** | **97.25%** (after fastp filtering) |
| **Q30 Score** | **94.07%** (post-filtering quality) |
| **Genes Quantified** | **1,734** (Chromosome X) |
| **Differentially Expressed Genes** | **23** (16 upregulated, 7 downregulated) |
| **Statistical Threshold** | padj < 0.05, \|log2FC\| > 1 |
| **Top Candidate** | ENSG00000169891 (log2FC = 2.85) |

---

##  Project Structure
```text
TDP-43-Chromosome-X/
├── data/
│   ├── raw/           # Raw FASTQ files (GSE136366)
│   ├── trimmed/       # Processed FASTQ files
│   └── reference/     # Reference genome (GRCh38, Chromosome X)
├── scripts/
│   ├── quality_control.sh
│   ├── salmon_quant.sh
│   └── deseq2_analysis.R
├── results/
│   ├── qc_reports/
│   ├── quantification/
│   └── differential_expression/
├── visualizations/
│   ├── volcano_plot.png
│   ├── heatmap.png
│   └── pca_plot.png
├── docs/
│   └── Final_Report.pdf
└── README.md
```




---

##  Pipeline Workflow
Raw FASTQ → FastQC → fastp Trimming → Salmon Quantification → tximport → DESeq2 → Visualization





### Pipeline Steps:

1.  **Quality Control (FastQC)** - Assess raw sequencing data quality.
2.  **Trimming (fastp)** - Remove adapters and low-quality reads (Q>20, length>36bp).
3.  **Quantification (Salmon)** - Quasi-mapping to Chromosome X transcriptome.
4.  **Aggregation (tximport)** - Summarize transcript counts to gene level.
5.  **Differential Expression (DESeq2)** - Identify significant gene changes.
6.  **Visualization** - Volcano plots, heatmaps, PCA.

---

## 📈 Visualizations

### Volcano Plot - Differentially Expressed Genes

<img width="791" height="499" alt="Screenshot 2026-03-10 at 2 51 31 AM" src="https://github.com/user-attachments/assets/1516b25f-b5f5-4f75-a700-15899a20d41c" />

*🔴 Red: Upregulated (16 genes) | 🔵 Blue: Downregulated (7 genes) | ⚪ Grey: Not significant*

### PCA Plot - Sample Clustering

<img width="775" height="619" alt="Screenshot 1447-08-18 at 2 17 04 PM" src="https://github.com/user-attachments/assets/63836f5e-a922-4856-826d-707ebda3210b" />


*PC1 (49.7% variance) separates KO from WT samples*

### Heatmap - Gene Expression Patterns

<img width="509" height="634" alt="Screenshot 1447-08-18 at 2 19 14 PM" src="https://github.com/user-attachments/assets/a948279a-982f-4f2a-82bf-409593e70203" />


*Z-score scaled expression for 23 significant genes*

---

##  Biological Insights

| Finding | Implication |
|---------|-------------|
| **Upregulated Genes** | Enriched in systemic physiological regulation (e.g., blood pressure regulation). |
| **Downregulated Genes** | Enriched in chromatin remodeling and DNA repair pathways (e.g., ISWI-type complex). |
| **Top Candidate** | ENSG00000169891 showed strongest upregulation (log2FC = 2.85, padj < 1×10^-50). |
| **KEGG Pathway** | ATP-dependent chromatin remodeling identified as disrupted pathway. |

---
##  Setup & Reproducibility

This project uses conda for environment management. To reproduce the analysis:

```bash
# 1. Clone the repository
git clone https://github.com/Ibrah1m1/TDP-43-Chromosome-X.git
cd TDP-43-Chromosome-X

# 2. Create and activate the conda environment
conda env create -f environment.yml
conda activate tdp43-chrX

# 3. Run the complete pipeline
bash run_pipeline.sh

# Or run steps individually:
bash scripts/quality_control.sh
bash scripts/salmon_quant.sh
Rscript scripts/deseq2_analysis.R
```
 Raw data files are not included in this repository due to size.  Download from GEO accession GSE136366 and place in data/raw/ following the structure in config/samples.tsv.


---

##  Final Checklist: What to Do Now

```bash
# 1. Create the missing files
touch .gitignore environment.yml LICENSE
mkdir -p config
# Then paste the content provided above into each file

# 2. Create config/samples.tsv with your actual sample info

# 3. Create run_pipeline.sh and make executable
chmod +x run_pipeline.sh

# 4. Update README.md: Add the "Setup & Reproducibility" section above

# 5. Test the environment creation (optional but recommended)
conda env create -f environment.yml --dry-run

# 6. Commit and push
git add .gitignore environment.yml LICENSE config/ run_pipeline.sh README.md
git commit -m "Add reproducibility files: environment, config, pipeline runner"
git push origin main
```
---

##  Team

| Name | Role |
|------|------|
| **Haitham Alahmadi** | Bioinformatics Analysis |
| **Ibrahim Eissa** | Pipeline Development & QC |
| **Ahmed Mawlawi** | Data Visualization |

---

##  License

This project is for educational and research purposes.

---

##  Contact

**Ibrahim Eissa Abu Alghayth**  
 ibrahim.abualg@gmail.com  
 [LinkedIn](https://linkedin.com/in/yourname)  
 [GitHub](https://github.com/Ibrah1m1)

---

##  Related Links

- [KAUST Academy](https://kaust.edu.sa)
- [DESeq2 Documentation](https://bioconductor.org/packages/DESeq2)
- [Salmon Documentation](https://salmon.readthedocs.io)
- [GEO Dataset (GSE136366)](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE136366)
- [Full Project Report](https://github.com/user-attachments/files/25855567/TDP-43.Loss.The.Chromosome.X.Impact.pdf)
- [project Chromosome X.pptx](https://github.com/user-attachments/files/25921069/project.Chromosome.X.pptx)



---

