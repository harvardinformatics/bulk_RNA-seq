# Introduction
Bulk RNA-seq is a widely used method for extracting information on gene and isoform-level expression levels, from tissue samples, or aggregates of cells such as those obtained using cell sorting via flow cytometry. Estimate of RNA abundance are inferred by generating cDNA libraries from RNA extracts, then sequencing theese libraries so as to generate several million reads per sample, consisting of relatively short reads in either a single or paired-end configuration. Libraries are typically sequenced on an Illumina instrument, which, after sample demultiplexing, produces read files in fastq format. 

There are a large number of algorithms and software for pre-processing raw fastq data, inferring RNA abundance, and performing the most common downstream analysis, which is to detect isoforms or genes that are differentially expressed (DE) between a set of conditions defined by the experiment in question. The goals of this repository are to:
- Document best practices for common steps:
  - QC and pre-processing of RNA-seq reads
  - Inferring RNA abundance
  - Performing tests of differential expression
- Provide scripts for executing these steps in a cluster computing environment
- Provide example Snakemake workflows for automating typical pipelines
