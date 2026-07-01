# RNA-seq Intro FASTQ Length Check

## Project goal

This project learns basics FASTQ format and checks whether sequence length and quality length are the same for each read.

## Input files

data/example.fastq: a normal FSATQ example
data/bad_example.fastq: a FASTQ example with one wrong quality length

## Scripts

scripts/check_fastq_length.sh

## How to run

bash scripts/check_fastq_length.sh data/example.fastq data/example_check_by_scripts.tsv

bash scripts/check_fastq_length.sh data/bad_example.fastq data/bad_check_by_scripts.tsv

## Outpit columns

read_id: read name
seq_len: sequence length
qual_len: quality score length
status: OK or ERROR

## Notes

FASTQ uses 4 lines for each read.
Line 1 is read name.
Line 2 is nucleotide sequence.
Line 3 is plus sign.
Line is quality scores.
