UNDER DEVELOPMENT

rmprim \
 \
The bash script "rmprim.sh" is a wrapper for cutadapt (https://cutadapt.readthedocs.io/) allowing to trim primers in forward and reverse paired reads in FASTQ files ("Trimming paired-end reads").
#
The script works on gzipped files from Illumina MiSeq, with names ending in _R1_001.fastq.gz and _R2_001.fastq.gz, e.g.: \
B0115D1-PL1-C5_S35_L001_R1_001.fastq.gz \
B0115D1-PL1-C5_S35_L001_R2_001.fastq.gz \
 \
Usage: bash rmprim.sh [parameters] \
parameters: - f forward sequence; -r reverse sequence; -t discard untrimmed (TRUE/FALSE); -d directory
#
Example: \
bash rmprim.sh -f CCTACGGGNGGCWGCAG -r GACTACNVGGGTWTCTAATCC -t TRUE -d /FASTQ
#
If the fastq file are not zipped, move to the FASTQ dir, and use:
for file in *; do gzip -k "$file"; done
