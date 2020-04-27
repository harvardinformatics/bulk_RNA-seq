# Introduction
Bulk RNA-seq is a widely used method for extracting information on gene and isoform-level expression levels, from tissue samples, or aggregates of cells such as those obtained using cell sorting via flow cytometry. Estimate of RNA abundance are inferred by generating cDNA libraries from RNA extracts, then sequencing theese libraries so as to generate several million reads per sample, consisting of relatively short reads in either a single or paired-end configuration. Libraries are typically sequenced on an [Illumina](https://www.illumina.com/systems/sequencing-platforms.html) instrument, which, after sample demultiplexing, produces read files in [fastq](https://en.wikipedia.org/wiki/FASTQ_format) format. 

There are a large number of algorithms and software for pre-processing raw fastq data, inferring RNA abundance, and performing the most common downstream analysis, which is to detect isoforms or genes that are differentially expressed (DE) between a set of conditions defined by the experiment in question. The goals of this repository are to:
- Document best practices for common steps:
  - QC and pre-processing of RNA-seq reads
  - Inferring RNA abundance
  - Performing tests of differential expression
- Provide scripts for executing these steps in a cluster computing environment
- Provide example [Snakemake](https://snakemake.readthedocs.io/en/stable/)  workflows for automating typical pipelines 

## Obtaining data
Analyses and workflows presented here utilize two data sets. The first consists of paired 2x100 RNA-seq reads used to investigate parallel climate adaptation in Drosophila across geographic regions, publisbed in Zhao et al (2015), PLoS Genetics. All fastq files are publicly available on NCBI's Short Read Archive (SRA). To download these data, we will use fastq-dump from the SRA Toolkit. The easiest way to do this is to create a conda environment, using an Anaconda python (version 3) distribution. Assuming you have conda accessible, one can build a conda environment called sratools as follows:

```bash
conda create -n sratools -c bioconda sra-tools
```

Then, your fastq pulldown script will simply have to load the sratools environment prior to execution. For an example script that uses the [SLURM](https://slurm.schedmd.com/overview.html) scheduler on the Harvard Cannon Cluster, see utilities/SRA_fastq_pulldown.sh. 
