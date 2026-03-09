# 🧬 TDP-43 Loss: Chromosome X Transcriptomic Analysis

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

## 📌 Overview

This project analyzes the transcriptomic impact of **TDP-43 protein loss** on **Human Chromosome X**, contributing to **ALS (Amyotrophic Lateral Sclerosis)** research. TDP-43 mislocalization is present in **>97% of ALS cases**, making it a critical target for understanding disease mechanisms.

**Completed with Distinction** at KAUST Academy Bioinformatics Advanced Program (Stage 3).

---

## 🎯 Objectives

- Analyze differential gene expression between **TDP-43 knockout (KD)** vs. **wild-type (WT)** samples.
- Build a reproducible **RNA-seq analysis pipeline** using Linux-based tools.
- Identify potential **X-linked biomarkers** for ALS.
- Achieve high-quality mapping and quantification metrics.

---

## 🛠️ Technologies & Tools

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

## 📊 Key Results

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

## 📁 Project Structure
