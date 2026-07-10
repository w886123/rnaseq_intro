#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "usage: bash scripts/check_fastq_qc_outputs.sh <prefix> <outdir>"
    exit 1
fi

prefix=$1
outdir=$2

length_out="${outdir}/${prefix}_length_check.tsv"
count_out="${outdir}/${prefix}_status_count.tsv"
logfile="${outdir}/${prefix}_pipeline.log"

for file in "$length_out" "$count_out" "$logfile"; do
    if [ ! -s "$file" ]; then
        echo "error: output file missing or empty: $file"
        exit 1
    else
        echo "ok: $file"
    fi
done

echo "all output files are ok"
