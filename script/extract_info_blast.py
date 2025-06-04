#!/usr/bin/env python3
# coding: utf-8

import sys
import argparse

def main():
    parser = argparse.ArgumentParser(description='Extract info from BLAST output for further analysis')
    parser.add_argument('-i', '--inputFile', type=str, required=True, help='BLAST output file (.txt)')
    parser.add_argument('-o', '--outputFile', type=str, required=True, help='Output TSV file with extracted info')
    args = parser.parse_args()

    with open(args.inputFile, 'r') as blast_file, open(args.outputFile, 'w') as out_file:
        for line in blast_file:
            # Ignorer les commentaires et lignes vides
            if line.startswith('#') or not line.strip():
                continue

            cols = line.strip().split('\t')

            if len(cols) >= 8:
                query_id = cols[0]
                subject_id = cols[1]
                evalue = cols[4]
                bit_score = cols[5]
                subject_length = cols[6]
                taxid = cols[7]

                #erire dans le fichier de sortie
                out_file.write(f"{query_id}\t{subject_id}\t{evalue}\t{bit_score}\t{subject_length}\t{taxid}\n")

if __name__ == "__main__":
    main()
