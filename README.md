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

Then, your fastq pulldown script will simply have to load the sratools environment prior to execution. For an example script that uses the [SLURM](https://slurm.schedmd.com/overview.html) scheduler on the Harvard Cannon Cluster, see [utilities/SRA_fastq_pulldown.sh](https://github.com/harvardinformatics/bulk_RNA-seq/blob/master/utilities/SRA_fastq_pulldown.sh). This script uses the new multi-threaded [fasterq-dump]("https://github.com/ncbi/sra-tools/wiki/HowTo:-fasterq-dump"), the replacement for the now-deprecates single-threaded fastq-dump. 

Assuming you had a file of SRA run ids, e.g. for the 12 samples in the Zhao *Drosophila* data, e.g. [SRA_accession_list.txt]("https://github.com/harvardinformatics/bulk_RNA-seq/blob/master/data/zhao2015/SRA_accession_list.txt"), you could use the pulldown script as follows: 

```bash
for i in `seq 1 12`;do `j=head -$i SRA_accession_list.txt | tail -1`;sbatch SRA_fastq_pulldown.sh $j;done
```

## Building a kallisto/snakemake conda enviroment
We are interested in developing automated workflows for efficiently conducting analyses, and structuring those analyses with an eye towards reproducibility and minimizing conflicts between software dependency versions as packages evolve. Thus, we demonstrate how to use [snakemake]("https://snakemake.readthedocs.io/en/stable/") to automate workflows and manage scheduler (in our case, SLURM jobs on an HPC cluster, and to do this within a [conda]("https://docs.conda.io/projects/conda/en/latest/index.html") environment.

To build such an enviroment, and assuming you already have a current version 3 python in your PATH, one can build this environment as follows: 
```bash
conda create -n kallisto -c bioconda -c anaconda  snakemake kallisto pyyaml 
```
Where the -n flag indicate the name of the enviroment, -c indicates the conda channels from which you will look for software install recipes -- for other dependencies, you will need to determine the proper channels to use for installtion -- followed by the software you want to install into the enviornment at the time you create it.


To activate this environment, one simply types: 
``` bash
source activate kallisto
```
