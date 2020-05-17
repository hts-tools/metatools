rmprim \
 \
The bash script "rmprim.sh" is a wrapper for cutadapt (https://cutadapt.readthedocs.io/) allowing to trim primers in forward and reverse paired reads in FASTQ files ("Trimming paired-end reads"). \
\
The script assumes that cutadapt is installed on the system in use. For installation, follow instructions in https://cutadapt.readthedocs.io/en/stable/installation.html \
On Debian-based Linux distribution (e.g. Ubuntu), cutadapt can be installed with the following commands: \
sudo apt install cutadapt \
or \
sudo apt install python3-cutadapt \
In this case, be sure to have installed the very last version of the distribution
#
The rmprim script works on gzipped files from Illumina MiSeq, with names ending in _R1_001.fastq.gz and _R2_001.fastq.gz, e.g.: \
B0115D1-PL1-C5_S35_L001_R1_001.fastq.gz \
B0115D1-PL1-C5_S35_L001_R2_001.fastq.gz \
 \
Usage: bash rmprim.sh [arguments] \
arguments: - f forward sequence; -r reverse sequence; -t discard untrimmed (TRUE/FALSE); -d directory
#
Example: \
bash rmprim.sh -f CCTACGGGNGGCWGCAG -r GACTACNVGGGTWTCTAATCC -t TRUE -d /FASTQ
#
NOTE \
If the fastq file are not zipped, move to the FASTQ dir, and use: \
for file in *; do gzip -k "$file"; done
