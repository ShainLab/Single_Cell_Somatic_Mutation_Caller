# Indel Caller Testing

To verify that the user could use alternative approaches to come up with an initial candidate list of indels, we tested our pipeline using Mutect2 as an alternative to the default Pindel on a representative sample.

## Files
- `Pindel_Indel_MML.xlsx` -  Indel_MML.xlsx output from Single_Cell_Somatic_MutationCaller using Pindel
- `Mutect2_Indel_MML.xlsx` - Indel_MML.xlsx output from Single_Cell_Somatic_MutationCaller using Mutect2
- `PindelvMutect2.xlsx` - Summary of indel calls with comparison of output from both indel callers

## Notes

- Both output Indel_MML.xlsx were generated using the same input dataset processed through these different indel callers
- The same methods and filters as decribed in our publications were applied to generate final indel calls;
  1. Indels from the sample are cross-referenced with the normal, then any indels present in the normal are removed from the sample indel list
  2. Remaining indels undergo further filtering whereby the indels that pass filtering have 0 mutant reads in the normal, are not considered ONPs (Other Nucleotide Polymorphisms), and either have at least 1 mutant read in the sample or is a single base indel.  

## Results Summary

| **Pindel** | **Mutect2** |
|--------------|--------------|
| 638 total indels from initial vcf | 10091 total indels from initial vcf |
| 2 total indels after filtering | 1418 total indels after filtering |
| 0 inferred artifacts | 1416 inferred artifacts |
| **2 real indels** | **2 real indels** |
| **100% real indels** | **0.14% real indels** |

In summary, , both callers identified the same 2 genuine somatic indels, however Mutect2 produced 1,418 total candidate calls post-filtering. Upon manual inspection of the top indels rank ordered by their allele frequency, there was a clear pattern whereby MuTect2 was calling indels in homopolymers. Pindel's vastly superior specificity (100% vs 0.14% precision) significantly reduces downstream analytical burden and potential for false discoveries.
  
See `PindelvMutect2.xlsx` for detailed metrics.

