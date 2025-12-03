# scripts/02_render_survival_report.R
#
# Purpose:
#   - Render the main LUMIERE survival analysis R Markdown report
#   - Output is an HTML file inside the "results" folder

library(rmarkdown)

# Path to the R Markdown file
RMD_PATH <- "notebooks/LUMIERE_survival_report.Rmd"

# Make sure results directory exists
if (!dir.exists("results")) dir.create("results", recursive = TRUE)

# Render the report
render(
  input       = RMD_PATH,
  output_dir  = "results",
  output_file = "LUMIERE_survival_report_FIXED_internal_EN.html"
)

cat("Rendered survival report to results/LUMIERE_survival_report_FIXED_internal_EN.html\n")
