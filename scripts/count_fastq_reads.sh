#!/bin/bash

set -e
set -u
set -o pipefail

if [ "$#" -ne 2 ]; then
    echo "usage: ./scripts/count_fastq_reads.sh <input.fastq_or_fastq.gz> <output.tsv>"
    exit 1
fi

infile=$1
outfile=$2
outdir=$(dirname "$outfile")
mkdir -p "$outdir"
rm -f "$outfile"

if [ ! -f "$infile" ]; then
    echo "error: input file not found: $infile"
    exit 1
fi

if [[ "$infile" == *.gz ]]; then
    line_count=$(zcat "$infile" | awk 'END {print NR}')
else
    line_count=$(awk 'END {print NR}' "$infile")
fi

remainder=$((line_count % 4))

if [ "$remainder" -ne 0 ]; then
    echo "error: FASTQ line count is not divisible by 4"
    exit 1
fi

read_count=$((line_count / 4))

echo -e "file\tline_count\tread_count" > "$outfile"
echo -e "${infile}\t${line_count}\t${read_count}" >> "$outfile"

echo "read summary saved: $outfile"
