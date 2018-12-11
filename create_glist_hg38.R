## Usage:
# Rscript create_glist_hg38.R > create_glist_hg38_log.txt 2>&1

library('GenomicRanges')
library('SummarizedExperiment')
library('sessioninfo')

load('/dcl01/lieber/ajaffe/lab/brainseq_phase2/expr_cutoff/unfiltered/rse_gene_unfiltered.Rdata', verbose = TRUE)

genes <- rowRanges(rse_gene)

gene_info <- data.frame(
    chr = gsub('chr', '', seqnames(genes)),
    start = start(genes),
    end = end(genes),
    id = genes$gencodeID,
    stringsAsFactors = FALSE
)

stopifnot(all(sapply(gene_info, function(x) sum(is.na(x))) == 0))

save(gene_info, file = 'glist-hg38.Rdata')
write.table(gene_info, file = 'glist-hg38', col.names = FALSE, quote = FALSE, row.names = FALSE, sep = ' ')

## Reproducibility information
print('Reproducibility information:')
Sys.time()
proc.time()
options(width = 120)
session_info()
