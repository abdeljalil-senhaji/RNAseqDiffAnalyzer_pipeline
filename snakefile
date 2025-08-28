import os

#=============== CONFIG FILES AND GENERAL PATHS ==================#

rulePath = config["general_path"]["RULE_PATH"]
workdir:  config["general_path"]["OUTPUT_PATH"]
output_path = config["general_path"]["OUTPUT_PATH"]

#======================== RULES ==============================# 
include: rulePath+"/iget_samples_rule"

#include: rulePath+"/repair_rule"
#include: rulePath+"/dedupe_rule"
#include: rulePath+"/trimmomatic_rule"
#include: rulePath+"/fastqc_rule"
include: rulePath+"/star_rule"
#include: rulePath+"/spades_rule"
#============================= RECUP SAMPLES INFORMATIOS =================================#

mate_ids = ["R1","R2"]


sample_ids = []
directory = '/scratch/recherche/asenhaji/v1_RNAseqDiffAnalyzer/data'
for sample_id in os.listdir(directory) :
        sample = os.path.basename(sample_id)
        for r in (('_R2_001.fastq.gz', ''), ('_R1_001.fastq.gz', ''), ('_R2.fastq.gz', ''), ('_R1.fastq.gz', '')):
              sample = sample.replace(*r)
        sample_ids.append(sample)


#=================================================== Output name ==================================================#

#iget_samples = expand((output_path+"/{sample_id}/{sample_id}.R1.fastq.gz", output_path+"/{sample_id}/{sample_id}.R2.fastq.gz"), sample_id=sample_ids)
#dedupe = expand((output_path + "/{sample_id}/{sample_id}.R1_dedupe.fastq.gz",output_path + "/{sample_id}/{sample_id}.R2_dedupe.fastq.gz"),sample_id = sample_ids)
#trimmomatic = expand((output_path + "/{sample_id}/{sample_id}.R1_paired.fq.gz",output_path + "/{sample_id}/{sample_id}.R2_paired.fq.gz",output_path + "/{sample_id}/{sample_id}.R1_unpaired.fq.gz",output_path + "/{sample_id}/{sample_id}.R2_unpaired.fq.gz"),sample_id = sample_ids)
fastqc = expand((output_path+"/{sample_id}/fastqc/{sample_id}{mate_id}_paired.fq.html", output_path+"/{sample_id}/fastqc/{sample_id}{mate_id}_paired.fq.zip"), sample_id = sample_ids, mate_id = mate_ids),
#fastqc = expand((output_path+"/{sample_id}/fastqc/{sample_id}{mate_id}_paired_fastqc.html"), sample_id = sample_ids, mate_id = mate_ids),
#spades = expand((output_path+"/{sample_id}/{sample_id}_contigs.fasta"),sample_id=sample_ids)

star = expand((output_path+"/{sample_id}/{sample_id}_Aligned.sortedByCoord.out.bam"),sample_id=sample_ids)
#=================================================== Rule all ==================================================#

rule all:
    input:
         fastqc,
          star
    shell:
        "touch "+output_path+"/done"
