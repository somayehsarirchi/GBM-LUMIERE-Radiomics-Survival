# scripts/04_export_results.R
# ------------------------------------------------------------
# Purpose:
#   Export model summaries (e.g. Cox regression coefficients)
#   to CSV files under results/tables/ for use in manuscripts.
# ------------------------------------------------------------

library(here)
library(readr)
library(dplyr)
library(broom)
library(survival)

options(stringsAsFactors = FALSE)

cat("=== 04_export_results.R ===\n")

model_path <- here("results", "models", "cox_final_model.rds")
tables_dir <- here("results", "tables")
if (!dir.exists(tables_dir)) dir.create(tables_dir, recursive = TRUE)

if (!file.exists(model_path)) {
  stop("Model file not found at: ", model_path,
       "\nRun 02_run_survival_models.R first.")
}

cox_final <- readRDS(model_path)

# Tidy summary of Cox model
cox_tidy <- broom::tidy(cox_final, exponentiate = TRUE, conf.int = TRUE)

# Save to CSV
out_csv <- file.path(tables_dir, "cox_final_model_summary.csv")
write_csv(cox_tidy, out_csv)

cat("Saved Cox model summary to:\n  ", out_csv, "\n")
cat("Script 04 completed.\n")
