#!/bin/bash

set -e
set -u
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
read_summary_out="${outdir}/${prefix}_read_summary.tsv"
logfile="${outdir}/${prefix}_pipeline.log"

rm -f "$length_out" "$count_out" "$read_summary_out" "$logfile"
echo "input file: $infile" | tee "$logfile"
echo "length check output: $length_out" | tee -a "$logfile"
echo "status count output: $count_out" | tee -a "$logfile"
echo "read summary output: $read_summary_out" | tee -a "$logfile"

echo "check FASTQ structure" | tee -a "$logfile"
bash scripts/check_fastq_structure.sh "$infile" 2>&1 | tee -a "$logfile"
bash scripts/check_fastq_length.sh "$infile" "$length_out" 2>&1 | tee -a "$logfile"
bash scripts/count_status.sh "$length_out" "$count_out" 2>&1 | tee -a "$logfile"
bash scripts/count_fastq_reads.sh "$infile" "$read_summary_out" 2>&1 | tee -a "$logfile"

echo "check output files" | tee -a "$logfile"
bash scripts/check_fastq_qc_outputs.sh "$prefix" "$outdir" 2>&1 | tee -a "$logfile"

echo "FASTQ QC pipeline finished" | tee -a "$logfile"
