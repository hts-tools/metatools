#!/bin/bash
# rmprim.sh
# Function rmprim 0.1 / Bash script
# https://github.com/hts-tools/metatools/tree/master/rmprim
# Author: Nico Salmaso, FEM, nico.salmaso@fmach.it
# usage: bash rmprim.sh [arguments]
# arguments: - f forward sequence; -r reverse sequence; -t discard untrimmed (TRUE/FALSE); -d directory
while getopts f:r:t:d: option
do
case "${option}"
in
f) FWD=${OPTARG};;
r) REV=${OPTARG};;
t) DIS=${OPTARG};;
d) DIR=${OPTARG};;
esac
done
echo "Forward: " $FWD
echo "Reverse: " $REV
echo "Discard: " $DIS
echo "Input dir: " $DIR
    if [ "$DIS" = "TRUE" ]
    then
        discard="--discard-untrimmed"
    elif [ "$DIS" = "FALSE" ]
    then
        discard=""
    else
        echo "bad -t value; -t should be TRUE or FALSE"
        exit 0
    fi
cd $DIR
ls *_R1_001.fastq.gz | cut -d"_" -f1-3  > file_names
for file_name in $(cat file_names)
    do
        echo "Reads trimmed on: $file_name"
        cutadapt -g ^$FWD -G ^$REV \
        -o ${file_name}_R1_001_trim.fastq.gz -p ${file_name}_R2_001_trim.fastq.gz \
        ${file_name}_R1_001.fastq.gz ${file_name}_R2_001.fastq.gz \
        --cores=0 $discard -e 0.1 \
        >> trimming_statistic.txt 2>&1
    done
echo ""
head trimming_statistic.txt
echo ""
echo "Open trimming_statistic.txt for complete results"
echo ""
