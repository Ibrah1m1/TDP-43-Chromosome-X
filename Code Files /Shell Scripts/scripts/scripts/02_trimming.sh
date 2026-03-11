#!/bin/bash
# Trimming with fastp
# TDP-43 Chromosome X Analysis

set -e

echo "========================================="
echo "  Step 2: Trimming (fastp)"
echo "========================================="

# Create directories
mkdir -p data/trimmed
mkdir -p results/qc_reports/trimmed

# Input/Output directories
RAW_DATA="data/raw"
TRIMMED_DATA="data/trimmed"

# Load samples from config
SAMPLES_FILE="config/samples.tsv"

# Process each sample
tail -n +2 ${SAMPLES_FILE} | while IFS=$'\t' read -r sample_id condition replicate fastq_1 fastq_2; do
    echo "Processing ${sample_id}..."
    
    fastp \
        -i ${RAW_DATA}/${fastq_1} \
        -I ${RAW_DATA}/${fastq_2} \
        -o ${TRIMMED_DATA}/${sample_id}_R1.trimmed.fastq.gz \
        -O ${TRIMMED_DATA}/${sample_id}_R2.trimmed.fastq.gz \
        -h results/qc_reports/trimmed/${sample_id}_fastp.html \
        -j results/qc_reports/trimmed/${sample_id}_fastp.json \
        -q 20 \
        -l 36 \
        --detect_adapter_for_pe \
        --thread 4 \
        --compression 6
    
    echo "✓ ${sample_id} complete"
done

# Generate MultiQC report for trimmed data
echo "Generating MultiQC summary for trimmed reads..."
multiqc -o results/qc_reports/trimmed -n "trimmed_reads_QC" results/qc_reports/trimmed/

echo "✓ Trimming complete!"
