# GATK version Testing

To verify that the user could use different versions of GATK with our software, we tested our pipeline on a representative sample by replacing GATK 4.2.0.0 with GATK 4.5.0.0 throughout our bioinformatic pipeline.

## Files
- `GATK4.2_MasterMutationList.xlsx` -  post-analysis MasterMutationList output from Single_Cell_Somatic_MutationCaller using GATK 4.2
- `GATK4.5_MasterMutationList.xlsx` - post-analysis MasterMutationList output from Single_Cell_Somatic_MutationCaller using GATK 4.5  
- `GATKversioncomparison.xlsx` - Summary of variant calls with comparison of output from both GATK versions

## Notes

- Both output MasterMutationList.xlsx were generated using the same input dataset processed through these different GATK versions
- We analyzed both outputs using the same methods as decribed in our publications

## Results Summary

| **GATK_4.2.0.0** | **GATK_4.5.0.0** |
|--------------|--------------|
| 333 initial candidate somatic variants | 235 initial candidate somatic variants |
| 212 overlapping candidate somatic variants | 212 overlapping candidate somatic variants |
| 121 unique candidate somatic variants | 23 unique candidate somatic variants |
| **61 real mutations called** | **61 real mutations called** |

In summary, substituting GATK versions did not affect the final mutation calls. While there were differences in the initial set of candidate variants, all unique variants were low allele frequency variants that were filtered out in later stages of our workflow.  
See `GATKversioncomparison.xlsx` for detailed metrics.

