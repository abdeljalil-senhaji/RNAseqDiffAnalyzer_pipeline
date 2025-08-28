#!/bin/bash

# Abdeljalil SENHAJI RACHIK
# Version miseajour : count unique reads par taxid

# Analyser les options de la ligne de commande
while getopts "i:o:" option; do
  case "${option}" in
    i)
      extractInfo="${OPTARG}"
      ;;
    o)
      output="${OPTARG}"
      ;;
    *)
      echo "Usage: $0 -i <extractInfo_file> -o <output_file>"
      exit 1
      ;;
  esac
done

# Vérifier si le fichier existe et n'est pas vide
if [ ! -s "$extractInfo" ]; then
  touch "$output"
  exit 0
fi

# Extraire les colonnes 1 (query_id) et 6 (taxid), puis garder les lignes uniques (pour éviter les doublons de lecture)
cut -f1,6 "$extractInfo" | sort -u > "${extractInfo%.*}.unique_queries_per_taxid.txt"

# À partir des lignes uniques, compter combien de reads uniques par taxid
cut -f2 "${extractInfo%.*}.unique_queries_per_taxid.txt" | sort | uniq -c | awk '{print $2, $1}' > "${extractInfo%.*}.temp1.txt"

# Trier par nombre décroissant (du plus fréquent au moins fréquent)
sort -k2,2nr "${extractInfo%.*}.temp1.txt" > "$output"

# Nettoyage des fichiers temporaires
rm -f "${extractInfo%.*}.unique_queries_per_taxid.txt" "${extractInfo%.*}.temp1.txt"

echo "Commande excute : $0 $*"
