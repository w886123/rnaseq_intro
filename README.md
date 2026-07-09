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

## GitHub repository

https://github.com/w886123/rnaseq_intro

## Support gzipped FASTQ

This script supports both normal FASTQ files and gzipped FASTQ files.

Example for gzipped FASTQ:

bash scripts/check_fastq_length.sh data/example.fastq.gz data/example_gz_check_v3.tsv
bash scripts/check_fastq_length.sh data/bad_example.fastq.gz data/bad_gz_check_v2.tsv

## Count OK and ERROR status

This script counts OK and ERROR status from a FASTQ length check result.

Example:

bash scripts/count_status.sh data/bad_gz_check_v2.tsv data/bad_gz_status_count_by_script.tsv

## Run full FASTQ QC pipeline

This script runs FASTQ length check and status counting together.

Example:

bash scripts/run_fastq_qc.sh data/bad_example.fastq.gz bad_gz results

Output files:

results/bad_gz_length_check.tsv
results/bad_gz_status_count.tsv

## Check output files

This script checks whether FASTQ QC output files exist and are not empty.

Example:

bash scripts/check_fastq_qc_outputs.sh bad_gz results

Checked files:

results/bad_gz_length_check.tsv
results/bad_gz_status_count.tsv
results/bad_gz_pipeline.log
