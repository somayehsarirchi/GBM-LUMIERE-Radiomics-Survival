# scripts/03_plot_results.R
# ------------------------------------------------------------
# Purpose:
#   1) Load the final Cox model and TD dataset.
#   2) Compute linear predictor (risk_score) for each patient.
#   3) Create tertile-based risk groups and plot KM curves.
# ------------------------------------------------------------

library(here)
library(readr)
library(dplyr)
library(survival)
library(survminer)
library(ggplot2)

cat("=== 03_plot_results.R ===\n")

# Paths
OUT_FINAL  <- here("data", "LUMIERE_TD_FINAL.csv")
model_path <- here("results", "models", "cox_final_model.rds")
fig_dir    <- here("results", "figures")
if (!dir.exists(fig_dir)) dir.create(fig_dir, recursive = TRUE)

# Checks
if (!file.exists(OUT_FINAL)) {
  stop("Final dataset not found at: ", OUT_FINAL)
}
if (!file.exists(model_path)) {
  stop("Model file not found at: ", model_path,
       "\nRun 02_run_survival_models.R first.")
}

# 1) Load data and model
mydata    <- read_csv(OUT_FINAL)
cox_final <- readRDS(model_path)

cat("Dataset dimensions (from CSV):\n")
print(dim(mydata))

# 2) Compute linear predictor using the full dataset
#    IMPORTANT: use newdata = mydata so length matches nrow(mydata)
mydata$risk_score <- predict(cox_final, type = "lp", newdata = mydata)

# Optionally drop rows where risk_score is NA (e.g. missing covariates)
n_before <- nrow(mydata)
mydata   <- mydata %>% filter(!is.na(risk_score))
n_after  <- nrow(mydata)

cat("Rows kept after removing NA risk_score:\n")
cat("  before:", n_before, "  after:", n_after, "\n")

# 3) Create tertile-based risk groups
mydata$risk_group <- ntile(mydata$risk_score, 3)
mydata$risk_group <- factor(mydata$risk_group,
                            labels = c("Low", "Medium", "High"))

cat("Risk group counts:\n")
print(table(mydata$risk_group))

# 4) Kaplan–Meier by risk_group
#    TODO: اگر اسم ستون‌های زمان/رخداد فرق دارد، این دو را عوض کن
surv_obj <- with(mydata, Surv(Survival, event))

fit_risk <- survfit(surv_obj ~ risk_group, data = mydata)

# Plot KM + risk table
p <- ggsurvplot(
  fit_risk,
  data = mydata,
  risk.table = TRUE,
  conf.int = TRUE,
  pval = TRUE,
  legend.title = "Risk groups",
  legend.labs = c("Low", "Medium", "High"),
  xlab = "Time (weeks)",
  ylab = "Survival probability",
  ggtheme = theme_bw(base_size = 14)
)

fig_path <- file.path(fig_dir, "KM_by_risk_group.png")
ggsave(fig_path, p$plot, width = 7, height = 5, dpi = 300)

cat("Saved KM plot to:\n  ", fig_path, "\n")
cat("Script 03 completed.\n")
