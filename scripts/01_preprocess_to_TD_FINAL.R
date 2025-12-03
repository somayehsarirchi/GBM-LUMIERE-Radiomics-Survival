# scripts/01_preprocess_to_TD_FINAL.R
#
# Purpose:
#   - Read the raw LUMIERE CSV files
#   - Merge and clean them
#   - Create the time-dependent survival dataset LUMIERE_TD_FINAL.csv
#
# Notes:
#   - Adjust the file names if your raw CSVs have slightly different names.
#   - The final output is used by the R Markdown report and other scripts.

# 1. Load required packages -------------------------------------------------

library(dplyr)
library(readr)
library(tidyr)
# Add any other packages that you use in your preprocessing code.

# 2. Define input and output paths -----------------------------------------

PATH_DEMO   <- "data/raw/LUMIERE-Demographics_Pathology.csv"
PATH_RANO   <- "data/raw/LUMIERE-ExpertRating-v202211.csv"
PATH_MR     <- "data/raw/LUMIERE-MRinfo.csv"
PATH_PYRADS <- "data/raw/LUMIERE-pyradiomics-deepradiomics-features.csv"

OUT_FINAL   <- "data/LUMIERE_TD_FINAL.csv"

# 3. Read raw input tables --------------------------------------------------

demo   <- read_csv(PATH_DEMO)
rano   <- read_csv(PATH_RANO)
mrinfo <- read_csv(PATH_MR)
pyrads <- read_csv(PATH_PYRADS)

cat("Raw tables loaded.\n")
cat("demo   :", nrow(demo),   "rows\n")
cat("rano   :", nrow(rano),   "rows\n")
cat("mrinfo :", nrow(mrinfo), "rows\n")
cat("pyrads :", nrow(pyrads), "rows\n")

# 4. Merge and preprocess ---------------------------------------------------
# IMPORTANT:
#   Here you should paste the preprocessing code that you ALREADY wrote
#   in your R scripts / Rmd to create the final analysis dataset.
#
#   Typical steps might include:
#     - joining tables by patient ID and time
#     - filtering invalid records
#     - selecting radiomics features
#     - creating start/stop times and event indicator
#
# Example structure (replace with your real code):

# mydata <- demo %>%
#   inner_join(rano,   by = "PatientID") %>%
#   inner_join(mrinfo, by = "PatientID") %>%
#   inner_join(pyrads, by = c("PatientID", "Timepoint")) %>%
#   mutate(
#     # create survival variables, recode factors, etc.
#   )

# 5. Save analysis-ready dataset -------------------------------------------

write_csv(mydata, OUT_FINAL)

cat("\nSaved analysis-ready dataset to:", OUT_FINAL, "\n")
print(dim(mydata))
