# RSEM version Testing

To verify that the user could use different versions of RSEM with our software, we tested our pipeline on a representative sample using RSEM v1.3.3. The genes.results output file from this version was compared to the genes.results output from our pipeline that uses RSEM v1.2.0.

## Output Files used for Comparison
- `D58_SHR20_RNA_rsem.genes.results` - genes.results file from RSEM v1.2.0
- `D58_SHR20_RNA_rsem-v1.3.3.genes.results` - genes.results file from RSEM v1.3.3

## Notes

- Both outputs were generated using the same bam file and reference tarball
- Linear regression analysis was performed on expected read counts and FPKM to compare each RSEM version output
- Log transformed values were shown to diminish the impact of outliers; however, true linear correlations were even higher

## Results Summary

Comparing both outputs:
- Expected count; R<sup>2</sup> = 0.9994, p-value < 0.0001
- FPKM; R<sup>2</sup> = 0.9966, p-value < 0.0001

In summary, the linear regression analysis demonstrated a high degree of concordance with R<sup>2</sup> values close to 1 and p-values < 0.0001. Therefore, substituting RSEM versions does not affect the final result.
