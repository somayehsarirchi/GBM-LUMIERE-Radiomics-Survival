# scripts/05_render_report.R
# ------------------------------------------------------------
# Purpose:
#   Render the main LUMIERE survival R Markdown report
#   and save the HTML output under results/.
# ------------------------------------------------------------

library(here)
library(rmarkdown)

cat("=== 05_render_report.R ===\n")

rmd_path   <- here("notebooks", "LUMIERE_survival_report.Rmd")
output_dir <- here("results")
output_file <- "LUMIERE_survival_report_FIXED_internal_EN.html"

if (!file.exists(rmd_path)) {
  stop("R Markdown file not found at: ", rmd_path)
}

if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

render(
  input       = rmd_path,
  output_dir  = output_dir,
  output_file = output_file,
  envir       = new.env(parent = globalenv())
)

cat("Rendered survival report to:\n  ",
    file.path(output_dir, output_file), "\n")
cat("Script 05 completed.\n")
