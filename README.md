# Co-expression_analysis
This is a workflow for gene co-expression analysis with WGCNA and Mfuzz, though Mfuzz is not recommended as it yields less accurate results.

You can use the files in the example folder to make a test run, but first you must change the configuration file to fit the paths and other variables to your necessities.

## Installation

You only need to clone the repository wherever you want:

```bash
git clone https://github.com/Javiersdr/Co-expression_analysis.git
```

## Configuration

There is a configuration file (`configure_WGCNA.R`) you will need to edit before running the code.

There is a **DON'T TOUCH: CLEAN START** text that must not be modified. Below it, you will find the following configuration variables:

- `PROJECT_NAME`: This will be the title of your report results file.
- `SOURCE_DIR`: The path where the folder with the code is located.
- `DATA_DIR`: The path where the data to analyse is located.
- `INITIAL_FILE`: The file with your data matrix. This file must be normalised. You can see one in the `example` folder.
- `TRAIT_FILE`: A file with trait information. You can see one in the `example` folder.
- `DO_DEGS`: This boolean (TRUE/FALSE) determines if a Fisher-test will be performed to check if any module has a significant number of differentially expressed genes (DEGs). Of course, it would be necessary to perform a differential expression analysis first.
- `DEG_FILE`: The file with the DEGs. For now, this file should be an output of [RSeqFlow](https://github.com/mgclaros/RSeqFlow)

**WGCNA parametrisation**:
- `THREADS`: Number of threads for the WGCNA functions that can be parallelised.
- `min_module_size`: How many genes must any module have at minimum.
- `merge_cut_height`: A value for the dendrogram cut to merge modules.
- `max_block_size`: Sometimes, there are so many genes it would take too much memory to perform the analysis. This is the parameter to determine how big should any block of genes be. 30000 is a good number for 64 Gb, but keep in mind the amount of RAM needed grows exponentially.
- `filter_type`: An number between 1 and 3 that determines which filtering method should be used. 1: raw expression-based filtering; 2: mean-based filtering; 3: variance-based filtering.
- `num_thresh`: Expression value used for filtering out low-expression genes.
- `num_samples`: The minimum number of samples in which a gene must have expression ≥ `num_thresh` to be retained.
- `quantile_thresh`: The quantile of genes to keep when applying mean or variance filtering.
- `deepSplit`: This is a somehow obscure WGCNA parameter that goes from 0 to 4 returning a higher amount of modules the bigger it is.

## Output

This analysis will result in an HTML report with images that give you information about every step. There are also three different output tab-separated files.

- `gene_modules_auto.tsv`: This file contains two columns. The first one shows the gene IDs and the second one the module each gene belongs to.
- `fisher_result_greater_auto.tsv`: This file contains the result of the Fisher test that statistically checks if any module contains a significantly high amount of DEGs, if performed.
- `gene_modules_significant_cor.tsv`: This file is similar to `gene_modules_auto.tsv`, but it only has information about those modules that were significantly correlated with at least one trait.

## Utils

The cor_matrix_filter R script allows you to easily calculate the correlations between all genes in a module, filter to an arbitrary correlation threshold and storing the info only in one diagonal to reduce storage ocupation.
