# configure_wf -> WGCNA
# Javier Santos
# 2023-11-03

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# DON'T TOUCH: CLEAN START ####
#
# clear the work space
rm(list=ls())
# garbage collection after removal RAM
gc()
# shut down all open graphic devices
graphics.off()
# ////////////////////////////////



# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# GIVE A NAME TO YOUR PROJECT ####
#
# You should define a name to appear in the final report
#
# Example:
#   PROJECT_NAME = "My analysis on mouse"

PROJECT_NAME = "WGCNA template"
# //////////////////////////////////////

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# PATH TO THE DIRECTORY CONTAINING THE SOURCE FILES ####
#
# You should include here the path where the code can be found on your computer
#
# Example:
#   SOURCE_DIR = "~/usr/local/mycodingfiles/"
# A final "/" in path is compulsory

SOURCE_DIR = "/data1/datos_javi/IHSM/Co-expression_analysis/"
# //////////////////////////////////////

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# PATH TO DATA-CONTAINING DIRECTORY ####
#
# You should include here the path where this file is on your computer
# This file should be side-by-side with the input data
# Output files and folders will be created there
#
# Example:
#   DATA_DIR = "~/Documents/My_MA_data/this_experiment/"
# A final "/" in path is compulsory

DATA_DIR = "/data1/datos_javi/IHSM/Co-expression_analysis/example/"
# //////////////////////////////////////

INITIAL_FILE <- "CTFnormalisedCPMs.tsv"
TRAIT_FILE <- "trait_data.tsv"

DO_DEGS <- FALSE
DEG_FILE <- "AllGenes_allContrast_TREAT-P-0.05_FC-1.5_2024-05-13_01.02.57.tsv"

# WGCNA
THREADS = 16
min_module_size <- 30
merge_cut_height <- 0.25
# Lower this number below according to your RAM. However, 64 Gb should be okay for 30000 genes
max_block_size <- 30000
# num_thresh is for genes you want to filter out because of low expression
# For example, 1 will eliminate genes whose expression is < 1 in in num_samples samples
# So, num_thresh = 1 and num_samples = 2 means only genes with expression higher than 1 in at least 2 samples will stay
num_thresh <- 1
num_samples <- 2
# This parameter allows to get more modules the higher it is (integer from 0 to 4)
deepSplit <- 2

# %%%%%%%%%%%%%%%%%%%%%%%%%%%
# END CONFIGURATION FILE ####
# %%%%%%%%%%%%%%%%%%%%%%%%%%%

# %%%%%%%%%%%%%%%%%%%%%%%%%%
# %%%%%%%%%%%%%%%%%%%%%%%%%%
# DO NOT TOUCH THE FOLLOWING
# %%%%%%%%%%%%%%%%%%%%%%%%%%
# %%%%%%%%%%%%%%%%%%%%%%%%%%

T00 <- proc.time() # Initial time for elaspsed time

## launch rmarkdown report ####
cat("\n", "*** Creating markdown report ***", "\n")

# the Rmd file must be located with code
loadRmd <- paste0(SOURCE_DIR, "Co-expression.Rmd")
results_folder <- "results_WGCNA_"
current_date <- format (Sys.time (), "%F_%H.%M.%S")
results_path <- paste0(DATA_DIR, results_folder, current_date, "/")
dir.create (results_path)

# the resulting HTML should be be saved with the results, not with code
library(rmarkdown)
render(input = loadRmd, 
       output_dir = results_path,
       output_file = " Report_WGCNA.html",
       quiet = TRUE)

cat("\n", "*** Report and results saved in the new folder ***", "\n")
message(results_path)

T_total2 <- proc.time() - T00
message("\nReal time taken by the current run: ", round(T_total2[[3]]/60, digits = 3), " min")
print(T_total2)