
#!/bin/bash
# Quality Control with FastQC
# TDP-43 Chromosome X Analysis

set -e

echo "========================================="
echo "  Step 1: Quality Control (FastQC)"
echo "========================================="

# Create output directory
mkdir -p results/qc_reports/raw

# Input directory
RAW_DATA="data/raw"

# Run FastQC on all raw FASTQ files
echo "Running FastQC on raw reads..."
fastqc -t 4 -o results/qc_reports/raw ${RAW_DATA}/*.fastq.gz

# Generate MultiQC report
echo "Generating MultiQC summary..."
multiqc -o results/qc_reports/raw -n "raw_reads_QC" results/qc_reports/raw/

echo "✓ Quality control complete!"
echo "Reports saved to: results/qc_reports/raw/"
