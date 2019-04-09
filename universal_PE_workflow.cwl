#! /usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

inputs: 
  fastq_forward: File
  fastq_reverse: File
  adapter_clip: File
  reference_genome_fasta: File 
  reference_genome_index: File 
  reference_genome_fai: File 
  reference_genome_amb: File 
  reference_genome_ann: File 
  reference_genome_bwt: File 
  reference_genome_pac: File 
  reference_genome_sa: File 


outputs:

# FASTQC outputs 

  fastqc_forward_html_report:
    type: File
    outputSource: fastqc_report/forward_html_file
  fastqc_reverse_html_report:
    type: File
    outputSource: fastqc_report/reverse_html_file
  fastqc_forward_zip_file:
    type: File
    outputSource: fastqc_report/forward_zip_file
  fastqc_reverse_zip_file:
    type: File
    outputSource: fastqc_report/reverse_zip_file
  fastqc_std_out:
    type: File
    outputSource: fastqc_report/log_file_stdout
  fastqc_std_err:
    type: File
    outputSource: fastqc_report/log_file_stderr

# Trimmomatic outputs 

  trimmomatic_forward_unpaired:
    type: File
    outputSource: trim_adapters/forward_u_filter_file
  trimmomatic_forward_q_filter:
    type: File
    outputSource: trim_adapters/forward_q_filter_file
  trimmomatic_reverse_unpaired:
    type: File
    outputSource: trim_adapters/reverse_u_filter_file
  trimmomatic_reverse_q_filter:
    outputSource: trim_adapters/reverse_q_filter_file
    type: File
  trimmomaitc_std_out:
    type: File
    outputSource: trim_adapters/log_file_stdout
  trimmomatic_std_err:
    type: File
    outputSource: trim_adapters/log_file_stderr

# BWA outputs 

  bwa_aligned_bam_file:
    type: File
    outputSource: align/aligned_bam
  bwa_std_out:
    type: File
    outputSource: align/log_file_stdout
  bwa_srd_err:
    type: File
    outputSource: align/log_file_stderr


steps:
  fastqc_report:
    run: fastqc.cwl
    in:
      fastq_forward:
        source: fastq_forward
      fastq_reverse:
        source: fastq_reverse
    out: [forward_html_file, reverse_html_file, forward_zip_file, reverse_zip_file, log_file_stdout, log_file_stderr]
  trim_adapters:
    run: trimmomatic_PE.cwl
    in:
      fastq_forward:
        source: fastq_forward
      fastq_reverse:
        source: fastq_reverse
      adapter_clip:
        source: adapter_clip
    out: [forward_u_filter_file, forward_q_filter_file, reverse_u_filter_file, reverse_q_filter_file, log_file_stdout, log_file_stderr]

  align:
    run: bwa.cwl
    in:
      forward_fastq_q_filter:
        source: trim_adapters/forward_q_filter_file
      reverse_fastq_q_filter:
        source: trim_adapters/reverse_q_filter_file
      reference_genome_fasta:
        source: reference_genome_fasta
      reference_genome_index:
        source: reference_genome_index
      reference_genome_fai:
        source: reference_genome_fai
      reference_genome_amb:
        source: reference_genome_amb
      reference_genome_ann:
        source: reference_genome_ann
      reference_genome_bwt:
        source: reference_genome_bwt
      reference_genome_pac:
        source: reference_genome_pac
      reference_genome_sa:
        source: reference_genome_sa
    out: [aligned_bam, log_file_stdout, log_file_stderr]
