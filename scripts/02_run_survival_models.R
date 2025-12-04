## scripts/02_run_survival_models.R
##
## This script loads the preprocessed longitudinal survival dataset,
## prepares complete-case evaluation data, fits Cox models, computes 
## evaluation time grids, and saves all objects required for 
## downstream analyses and figure generation.

rm(list = ls())

# Load required packages
library(tidyverse)
library(readr)
library(survival)
library(riskRegression)
library(pec)
library(here)

# Input file (created by the preprocessing pipeline)
OUT_FINAL <- here("data", "LUMIERE_TD_FINAL.csv")

# Ensure results directory exists
dir.create(here("results"), showWarnings = FALSE, recursive = TRUE)

# ---------------------------------------------------------
# 1) Load final time-dependent dataset
# ---------------------------------------------------------

mydata <- read_csv(OUT_FINAL)

cat("Dataset dimensions:\n")
print(dim(mydata))

# ---------------------------------------------------------
# 2) Fit the final Cox model (as used in the Rmd report)
# ---------------------------------------------------------

form_final <- Surv(Survival, event) ~
  Age.at.surgery..years. +
  original_shape_Maximum2DDiameterSlice +
  original_glcm_DifferenceEntropy

model_final <- coxph(form_final, data = mydata, x = TRUE, y = TRUE)
saveRDS(model_final, file = here("results", "model_final_coxph.rds"))

# ---------------------------------------------------------
# 3) Complete-case evaluation dataset
# ---------------------------------------------------------

eval_vars <- c(
  "Survival", "event",
  "Age.at.surgery..years.",
  "original_shape_Maximum2DDiameterSlice",
  "original_glcm_DifferenceEntropy"
)

eval_data <- mydata %>%
  dplyr::select(all_of(eval_vars)) %>%
  na.omit()

cat("Complete-case dataset dimensions:\n")
print(dim(eval_data))
cat("Event distribution in eval_data:\n")
print(table(eval_data$event))

saveRDS(eval_data, file = here("results", "eval_data_complete_cases.rds"))

# ---------------------------------------------------------
# 4) Fit Cox model on complete-case dataset
#    (use literal formula in the call to avoid dependencies
#     on external objects when refitting during bootstrap)
# ---------------------------------------------------------

model_cc <- coxph(
  Surv(Survival, event) ~
    Age.at.surgery..years. +
    original_shape_Maximum2DDiameterSlice +
    original_glcm_DifferenceEntropy,
  data = eval_data,
  x = TRUE,
  y = TRUE
)

saveRDS(model_cc, file = here("results", "model_cc_coxph.rds"))

# ---------------------------------------------------------
# 5) Evaluation times (quartiles of follow-up)
# ---------------------------------------------------------

eval_times <- as.numeric(quantile(
  eval_data$Survival,
  probs = c(0.25, 0.5, 0.75),
  na.rm = TRUE
))

cat("Evaluation times (quartiles of follow-up):\n")
print(eval_times)

saveRDS(eval_times, file = here("results", "eval_times_quartiles.rds"))

# ---------------------------------------------------------
# 6) Time grids for C-index and Brier score curves
# ---------------------------------------------------------

times_grid <- seq(
  min(eval_data$Survival),
  max(eval_data$Survival),
  length.out = 200
)
saveRDS(times_grid, file = here("results", "times_grid_cindex.rds"))

times_grid2 <- seq(
  min(eval_data$Survival),
  max(eval_data$Survival),
  length.out = 200
)
saveRDS(times_grid2, file = here("results", "times_grid_brier.rds"))

# ---------------------------------------------------------
# 7) Save full dataset for Kaplan–Meier and other plots
# ---------------------------------------------------------

saveRDS(mydata, file = here("results", "mydata_full_td.rds"))

cat("All model and data objects saved to 'results/'.\n")
