# Single_Cell_Somatic_Mutation_Caller
This app integrates RNA expression and haplotype information for each variant detected by Mutect2 to infer somatic mutations while distinguishing them from sequencing and amplification artifacts. It achieves this by leveraging additional data from matched DNA/RNA sequencing and haplotype information. Somatic mutations are expected to be present in both the genome and transcriptome, whereas artifacts typically do not exhibit this pattern. An exception to this occurs with truncating mutations. Additionally, somatic mutations often appear in cis with nearby germline polymorphisms, and this pattern remains consistent during amplification. This app also labels CC>TT or (C/T)C>T variants to indicate mutations with the canonical UV-radiation-induced mutational signature.

**This repository is for an app that runs on the DNAnexus Platform.**
For more information about how to run or modify it, see
https://documentation.dnanexus.com/.

## What does this app do?
This app integrates RNA expression and haplotype information for each variant detected by Mutect2 to infer somatic mutations while distinguishing them from sequencing and amplification artifacts. It achieves this by leveraging additional data from matched DNA/RNA sequencing and haplotype information. Somatic mutations are expected to be present in both the genome and transcriptome, whereas artifacts typically do not exhibit this pattern. An exception to this occurs with truncating mutations. Additionally, somatic mutations often appear in cis with nearby germline polymorphisms, and this pattern remains consistent during amplification. This app also labels CC>TT or (C/T)C>T variants to indicate mutations with the canonical UV-radiation-induced mutational signature.

## What are typical use cases for this app?
This app is designed for use with whole-genome, whole-exome and custom target panels.

Please refer to the following publication and preprints for use cases:
1. Tang J, Fewing, Chang D, Zeng H, Liu S, Jorapur A, Belote RL, McNeal AS, Tan T, Yeh I, Arron ST, Judson-Torres RL, Bastian BC, Shain AH. The genomic landscapes of individual melanocytes from human skin. Nature. October 2020. https://doi.org/10.1038/s41586-020-2785-8.
2. Tandukar B\*, Deivendran D\*, Chen L, Cruz-Pacheco N, Sharma H, Xu A, Bandari AK, Chen DB, George C, Marty A, Cho RJ, Cheng J, Saylor D, Gerami P, Arron ST, Bastian BC, Shain AH. Genetic evolution of keratinocytes to cutaneous squamous cell carcinoma. bioRxiv. July 2024. https://doi.org/10.1101/2024.07.23.604673.
3. Tandukar B, Deivendran D, Chen L, Bahrani N, Weier B, Sharma H, Cruz-Pacheco N, Hu M, Marks K, Zitnay RG, Bandari AK, Nekoonam R, Yeh I, Judson-Torres R, Shain AH. Somatic mutations distinguish melanocyte subpopulations in human skin. bioRxiv. February 2025. https://doi.org/10.1101/2025.02.07.637114.

_*jointly led the project. #co-senior author._

## What data is required for this app to run?
This app requires the following input files:
- Sample DNA BAM file - DNA sequencing data from a single cell or clone of cells
- Sample RNA BAM file - RNA sequencing data from a single cell or clone of cells
- Patient Bulk/Normal BAM file - Sequencing data from normal tissue for comparison
- Pindel Normal and Sample VCF files - Indel variant calls
- Mpileup Informative SNP txt file - For variant validation
- Input Variants for phasing txt file - To determine variant phase information
- Funcotator txt file - For functional annotation of variants
- Reference genome in FASTA format - For alignment and variant calling

_Please refer to the example inputs in test-dataset to test this app on DNANexus._

## What does this app output?
This app generates multiple output files including:
- Master Mutation List (MML.xlsx) - An Excel file containing all somatic variants with associated RNA and haplotype information, with the additional column labelling CC>TT or (C/T)C>T variants to indicate mutations with the canonical UV-radiation-induced mutational signature
- Indel mutation list and filtering results
- Mpileup analysis files for DNA, RNA, and Normal samples
- Sorted BAM files and their indices - phased haplotype reads
