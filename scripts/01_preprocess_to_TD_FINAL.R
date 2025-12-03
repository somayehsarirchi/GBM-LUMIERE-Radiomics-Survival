# scripts/01_preprocess_to_TD_FINAL.R
# ------------------------------------------------------------
# Purpose:
#   Prepare the time-dependent analysis dataset (LUMIERE_TD_FINAL.csv)
#   from raw LUMIERE CSV files (downloaded from Figshare), OR
#   verify that the final CSV is already available in data/.
#
#   For now, this script:
#     1) Checks for the presence of data/LUMIERE_TD_FINAL.csv
#     2) Provides a clear message if raw files or final file are missing
#
#   You can gradually move chunks from your original full script
#   (e.g. LUMIERE_full_survival_analysis.R) into the section marked
#   "USER-SPECIFIC PREPROCESSING".
# ------------------------------------------------------------

library(here)
library(readr)
library(dplyr)

options(stringsAsFactors = FALSE)

# Path to final analysis dataset
OUT_FINAL <- here("data", "LUMIERE_TD_FINAL.csv")

# Optional: paths to raw CSV files (if you decide to include them later)
PATH_DEMO  <- here("data", "LUMIERE-Demographics_Pathology.csv")
PATH_RANO  <- here("data", "LUMIERE-ExpertRating-v202211.csv")
PATH_MR    <- here("data", "LUMIERE-MRinfo.csv")
PATH_PYRAD <- here("data", "LUMIERE-pyradiomics-deepradnumia-features.csv")

cat("=== 01_preprocess_to_TD_FINAL.R ===\n")

if (file.exists(OUT_FINAL)) {
  cat("Found existing final dataset:\n  ", OUT_FINAL, "\n")
  cat("No preprocessing performed (re-using existing LUMIERE_TD_FINAL.csv).\n")
} else {
  cat("Final dataset not found at:\n  ", OUT_FINAL, "\n\n")
  
  # Check whether raw files are present
  raw_files <- c(PATH_DEMO, PATH_RANO, PATH_MR, PATH_PYRAD)
  raw_exist <- file.exists(raw_files)
  
  if (!all(raw_exist)) {
    cat("Some raw LUMIERE CSV files are missing.\n")
    cat("Please download the raw data from the LUMIERE Figshare DOI\n")
    cat("and place them under the data/ folder, for example:\n")
    cat("  data/LUMIERE-Demographics_Pathology.csv\n")
    cat("  data/LUMIERE-ExpertRating-v202211.csv\n")
    cat("  data/LUMIERE-MRinfo.csv\n")
    cat("  data/LUMIERE-pyradiomics-deepradnumia-features.csv\n")
    stop("Cannot create LUMIERE_TD_FINAL.csv without raw input files.")
  }
  
  cat("All raw input files seem to be present.\n")
  cat("This is where you can move your user-specific preprocessing code.\n\n")
  
  # ----------------------------------------------------------
  # USER-SPECIFIC PREPROCESSING (TODO)
  # ----------------------------------------------------------
  # 1) Read raw CSVs from PATH_DEMO, PATH_RANO, PATH_MR, PATH_PYRAD
  # 2) Merge them into a single longitudinal dataset
  # 3) Derive time-dependent covariates and event information
  # 4) Save the final dataset to OUT_FINAL
  #
  # Example skeleton (replace with your actual code):
  #
  # demo  <- read_csv(PATH_DEMO)
  # rano  <- read_csv(PATH_RANO)
  # mr    <- read_csv(PATH_MR)
  # pyrad <- read_csv(PATH_PYRAD)
  #
  # mydata_td <- your_preprocessing_function(demo, rano, mr, pyrad)
  #
  # write_csv(mydata_td, OUT_FINAL)
  #
  # ----------------------------------------------------------
  
  stop("Preprocessing code has not been implemented in this script yet.\n",
       "Move your existing preprocessing steps here when ready.")
}

cat("Script 01 completed.\n")
