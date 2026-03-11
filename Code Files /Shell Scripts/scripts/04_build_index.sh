#!/bin/bash
# Build Salmon Index for Chromosome X
# TDP-43 Chromosome X Analysis

set -e

echo "========================================="
echo "  Step 0: Build Salmon Index (Chromosome X)"
echo "========================================="

# Create directories
mkdir -p data/reference

# Download Ensembl transcriptome (Chromosome X only)
echo "Downloading Ensembl transcriptome..."

# Option 1: Download full transcriptome and filter
wget -O data/reference/Homo_sapiens.GRCh38.cdna.all.fa.gz \
    "ftp://ftp.ensembl.org/pub/release-104/fasta/homo_sapiens/cdna/Homo_sapiens.GRCh38.cdna.all.fa.gz"

# Extract and filter for Chromosome X transcripts
echo "Filtering for Chromosome X transcripts..."
gunzip -c data/reference/Homo_sapiens.GRCh38.cdna.all.fa.gz | \
    awk '/^>/ {if ($0 ~ /chromosome_X|chrX/) {p=1} else {p=0}} p' \
    > data/reference/chrX_transcripts.fa

# Build Salmon index
echo "Building Salmon index..."
salmon index \
    -t data/reference/chrX_transcripts.fa \
    -i data/reference/salmon_index_chrX \
    -k 31 \
    --type quasi \
    --threads 8

echo "✓ Salmon index built successfully!"
echo "Index saved to: data/reference/salmon_index_chrX/"
