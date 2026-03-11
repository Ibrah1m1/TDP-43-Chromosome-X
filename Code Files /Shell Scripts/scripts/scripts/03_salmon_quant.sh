#!/bin/bash
# Salmon Quantification
# TDP-43 Chromosome X Analysis

set -e

echo "========================================="
echo "  Step 3: Salmon Quantification"
echo "========================================="

# Create output directory
mkdir -p results/quantification

# Reference index
INDEX="data/reference/salmon_index_chrX"

# Trimmed data directory
TRIMMED_DATA="data/trimmed"

# Load samples from config
SAMPLES_FILE="config/samples.tsv"

# Process each sample
tail -n +2 ${SAMPLES_FILE} | while IFS=$'\t' read -r sample_id condition replicate fastq_1 fastq_2; do
    echo "Quantifying ${sample_id}..."
    
    salmon quant \
        -i ${INDEX} \
        -l A \
        -1 ${TRIMMED_DATA}/${sample_id}_R1.trimmed.fastq.gz \
        -2 ${TRIMMED_DATA}/${sample_id}_R2.trimmed.fastq.gz \
        -p 4 \
        --validateMappings \
        -o results/quantification/${sample_id}
    
    echo "✓ ${sample_id} quantification complete"
done

# Generate MultiQC report for Salmon
echo "Generating MultiQC summary for Salmon quantification..."
multiqc -o results/quantification -n "salmon_quantification" results/quantification/

echo "✓ Salmon quantification complete!"
