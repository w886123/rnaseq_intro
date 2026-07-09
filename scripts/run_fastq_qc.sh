#!/bin/bash

set -e
set -o pipefail

if [ "$#" -ne 3 ]; then
    echo "usage: bash scripts/run_fastq_qc.sh <input.fastq_or_fastq.gz> <prefix> <outdir>"
    exit 1
fi

infile=$1
prefix=$2
outdir=$3

if [ ! -f "$infile" ]; then
    echo "error: input file not found: $infile"
    exit 1
fi

mkdir -p "$outdir"

length_out="${outdir}/${prefix}_length_check.tsv"
count_out="${outdir}/${prefix}_status_count.tsv"

echo "input file: $infile"
echo "length check output: $length_out"
echo "status count output: $count_out"

bash scripts/check_fastq_length.sh "$infile" "$length_out"
bash scripts/count_status.sh "$length_out" "$count_out"

echo "FASTQ QC pipeline finished"
