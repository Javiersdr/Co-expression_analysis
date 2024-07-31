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

DATA_DIR = "/data1/datos_javi/IHSM/RSeqFlow/Picual-vs-Arbequina-polen-maduro/"
# //////////////////////////////////////

INITIAL_FILE <- "CTFnormalisedCPMs-2024-05-13_01.02.57.tsv"
TRAIT_FILE <- "trait_data.tsv"
DEG_FILE <- "AllGenes_TREAT_allContrast_P-0.1_FC-1.2_2022-07-28_13.10.30.tsv"
DEG_columns <- 27:32

# WGCNA
threads = 16
min_module_size <- 30
merge_cut_height <- 0.25
power_diss <- 10
max_block_size <- 30000

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