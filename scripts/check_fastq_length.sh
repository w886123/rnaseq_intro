#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "usage: bash scripts/check_fastq_length.sh <input.fastq_or_fastq.gz> <output.tsv>"
    exit 1
fi

infile=$1
outfile=$2

if [ ! -f "$infile" ]; then
    echo "error: input file not found: $infile"
    exit 1
fi

if [[ "$infile" == *.gz ]]; then
    zcat "$infile" | awk 'BEGIN {print "read_id\tseq_len\tqual_len\tstatus"} NR%4==1 {name=$0} NR%4==2 {seq=$0} NR%4==0 {qual=$0; if (length(seq)==length(qual)) {status="OK"} else {status="ERROR"}; print name "\t" length(seq) "\t" length(qual) "\t" status}' > "$outfile"
else
    awk 'BEGIN {print "read_id\tseq_len\tqual_len\tstatus"} NR%4==1 {name=$0} NR%4==2 {seq=$0} NR%4==0 {qual=$0; if (length(seq)==length(qual)) {status="OK"} else {status="ERROR"}; print name "\t" length(seq) "\t" length(qual) "\t" status}' "$infile" > "$outfile"
fi
