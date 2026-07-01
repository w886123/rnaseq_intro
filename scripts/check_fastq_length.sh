#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "usage: bash scripts/check_fastq_length.sh <input.fastq> <output.tsv>"
    exit 1
fi

infile=$1
outfile=$2

awk 'BEGIN {print "read_id\tseq_len\tqual_len\tstatus"} NR%4==1 {name=$0} NR%4==2 {seq=$0} NR%4==0 {qual=$0; if (length(seq)==length(qual)) {status="OK"} else {status="ERROR"}; print name "\t" length(seq) "\t" length(qual) "\t" status}' "$infile" > "$outfile"
