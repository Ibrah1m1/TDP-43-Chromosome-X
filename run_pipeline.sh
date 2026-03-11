#!/bin/bash
# ============================================
# TDP-43 Chromosome X - Pipeline Runner
# Usage: bash run_pipeline.sh
# ============================================

set -e  # Exit on error
set -u  # Exit on undefined variable

echo "=============================================="
echo "  TDP-43 Chromosome X Analysis Pipeline"
echo "  KAUST Academy - Bioinformatics Stage 3"
echo "=============================================="
echo ""

# Check conda environment
if ! conda env list | grep -q "tdp43-chrX"; then
    echo "⚠️  Environment 'tdp43-chrX' not found."
    echo "Creating it now..."
    conda env create -f environment.yml
fi

echo "✅ Activating conda environment..."
conda activate tdp43-chrX

# Run pipeline steps
echo ""
echo "🔍 Step 1: Quality Control"
bash scripts/quality_control.sh

echo ""
echo "✂️  Step 2: Trimming"
bash scripts/trimming.sh

echo ""
echo "📊 Step 3: Salmon Quantification"
bash scripts/salmon_quant.sh

echo ""
echo "🧬 Step 4: Differential Expression (DESeq2)"
Rscript scripts/deseq2_analysis.R

echo ""
echo "🎨 Step 5: Visualization"
Rscript scripts/visualization.R

echo ""
echo "=============================================="
echo "  ✅ Pipeline Complete!"
echo "=============================================="
echo ""
echo "📁 Results: results/"
echo "📈 Figures: visualizations/"
echo "📄 Report: docs/Final_Report.pdf"
echo ""
