#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "usage: bash scripts/check_fastq_structure.sh <input.fastq_or_fastq.gz>"
    exit 1
fi

infile=$1

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

echo "line count: $line_count"
echo "remainder: $remainder"

if [ "$remainder" -ne 0 ]; then
    echo  "error: FASTQ line count is not divisible by 4"
    exit 1
fi

echo "FASTQ structure: OK"
