import os

#=============== CONFIG FILES AND GENERAL PATHS ==================#

rulePath = config["general_path"]["RULE_PATH"]
workdir:  config["general_path"]["OUTPUT_PATH"]
output_path = config["general_path"]["OUTPUT_PATH"]

#======================== RULES ==============================# 
include: rulePath+"/iget_samples_rule"

#include: rulePath+"/repair_rule"
include: rulePath+"/dedupe_rule"
include: rulePath+"/trimmomatic_rule"
include: rulePath+"/fastqc_rule"
#include: rulePath+"/bwa_mem_rule"
#include: rulePath+"/samtools_sam_to_bam_rule"
#include: rulePath+"/samtools_flagstat_rule"
#include: rulePath+"/samtools_view_rule"
#include: rulePath+"/samtools_sort_rule"
#include: rulePath+"/samtools_get_unmapped_rule"
#include: rulePath+"/spades_rule"
include: rulePath+"/star_rule"
#include: rulePath+"/seqkit_rule"
#include: rulePath+"/blast_rule"
#include: rulePath+"/blast_fungi_rule"
#include: rulePath+"/extract_info_rule"
#include: rulePath+"/count_info_rule"
#include: rulePath+"/getnames_rule"
#============================= RECUP SAMPLES INFORMATIOS =================================#

mate_ids = ["R1","R2"]
fungi_parasite_ids = ["fungi", "parasite"]
#fungi_parasite_ids = ["Fungi"]

sample_ids = []
directory = '/scratch/recherche/asenhaji/v1_pipe_delete_hg38/data'
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
#samtools_flagstat = expand(output_path+"/{sample_id}/{sample_id}.txt", sample_id=sample_ids),
#samtools_get_unmapped = expand((output_path+"/{sample_id}/{sample_id}_not_hg38.R1.fastq.gz", output_path+"/{sample_id}/{sample_id}_not_hg38.R2.fastq.gz") ,sample_id = sample_ids)
#spades = expand((output_path+"/{sample_id}/{sample_id}_contigs.fasta"),sample_id=sample_ids)
star = expand((output_path+"/{sample_id}/{sample_id}_Aligned.sortedByCoord.out.bam"),sample_id=sample_ids)
#seqkit = expand(output_path + "/{sample_id}/{sample_id}_not_hg38.all.fasta", sample_id = sample_ids)
#blast = expand(output_path + "/{sample_id}/{sample_id}_blast_parasite.txt", sample_id = sample_ids)
#blast_fungi = expand(output_path + "/{sample_id}/{sample_id}_blast_fungi.txt", sample_id = sample_ids)
#extract_info = expand((output_path + "/{sample_id}/{sample_id}_{fungi_parasite_id}_extractInfo_fun_par.txt"), sample_id = sample_ids, fungi_parasite_id = fungi_parasite_ids)
#count_info = expand(output_path + "/{sample_id}/{sample_id}_{fungi_parasite_id}_count.txt", sample_id = sample_ids, fungi_parasite_id = fungi_parasite_ids)
#getnames = expand(output_path + "/{sample_id}/{sample_id}_{fungi_parasite_id}_NameVirFunPar.txt", sample_id = sample_ids, fungi_parasite_id = fungi_parasite_ids)
#=================================================== Rule all ==================================================#

rule all:
    input:
#        samtools_flagstat,
#        samtools_get_unmapped
#        spades
         fastqc,
         star
#        trimmomatic
#         seqkit
#        blast
#        blast_fungi
#        extract_info
#        count_info
#        getnames
    shell:
        "touch "+output_path+"/done"
