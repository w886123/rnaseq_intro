#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "usage: bash scripts/count_status.sh <input_check.tsv> <output_count.tsv>"
    exit 1
fi

infile=$1
outfile=$2

if [ ! -f "$infile" ]; then
    echo "error: input file not found: $infile"
    exit 1
fi

echo -e "count	status" > "$outfile"
tail -n +2 "$infile" | cut -f4 | sort | uniq -c | awk '{print $1 "\t" $2}' >> "$outfile"
