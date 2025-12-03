# scripts/02_run_survival_models.R
# ------------------------------------------------------------
# Purpose:
#   Fit the final time-dependent Cox model on LUMIERE_TD_FINAL.csv
#   and save the model object as an RDS file under results/models/.
# ------------------------------------------------------------

library(here)
library(readr)
library(dplyr)
library(survival)

options(stringsAsFactors = FALSE)

cat("=== 02_run_survival_models.R ===\n")

# Ensure output folder exists
models_dir <- here("results", "models")
if (!dir.exists(models_dir)) dir.create(models_dir, recursive = TRUE)

# Path to final dataset
OUT_FINAL <- here("data", "LUMIERE_TD_FINAL.csv")

if (!file.exists(OUT_FINAL)) {
  stop("Final dataset not found at: ", OUT_FINAL,
       "\nRun 01_preprocess_to_TD_FINAL.R or provide the CSV manually.")
}

# Load data
mydata <- read_csv(OUT_FINAL)

cat("Dimensions of dataset:\n")
print(dim(mydata))

# ------------------------------------------------------------
# Define the survival object and final Cox model formula
# ------------------------------------------------------------
# TODO: Adjust column names to match your TD_FINAL dataset.
# Example assumptions:
#   - time variable:   Survival
#   - event variable:  event (1 = death, 0 = censored)
#   - covariates:      Age, Max2Ddiameter, DiffEntropy
#
# Replace these with your real column names if different.
# ------------------------------------------------------------

# Example: Surv(time, status)
surv_obj <- with(mydata, Surv(Survival, event))

cox_formula <- surv_obj ~ Age.at.surgery..years. + original_shape_Maximum2DDiameterSlice + original_glcm_DifferenceEntropy

cat("Fitting Cox model:\n")
print(cox_formula)

cox_final <- coxph(cox_formula, data = mydata, x = TRUE, y = TRUE)

cat("\nModel summary:\n")
print(summary(cox_final))

# Save model
model_path <- file.path(models_dir, "cox_final_model.rds")
saveRDS(cox_final, model_path)

cat("\nSaved final Cox model to:\n  ", model_path, "\n")
cat("Script 02 completed.\n")
