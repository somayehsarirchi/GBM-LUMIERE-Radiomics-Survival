GBM-LUMIERE-Radiomics-Survival

Radiomics-based survival modeling in glioblastoma using time-dependent Cox regression on longitudinal FLAIR MRI features (LUMIERE dataset).

This repository demonstrates how to preprocess the data, refit the survival model, compute time-dependent metrics (C-index, Brier score, IBS), perform bootstrap-based internal validation, and derive Cox-based risk groups.

🧠 1. Project overview

Glioblastoma (GBM) is an aggressive primary brain cancer with poor prognosis.
The LUMIERE cohort provides longitudinal radiomics features extracted from FLAIR MRI along with detailed clinical information.

This project implements:

Time-dependent Cox survival modeling

Longitudinal radiomics aggregation

Kaplan–Meier curves

Time-dependent C-index

Brier score & integrated Brier score (IBS)

Bootstrap .632+ internal validation

Cox-derived 3-group risk stratification

All analysis code is fully reproducible through the included R Markdown file.

📂 2. Repository structure
GBM-LUMIERE-Radiomics-Survival/
│
├── data/                         # Minimal analysis-ready dataset
│   └── LUMIERE_TD_FINAL.csv
│
├── results/                      # Generated results (HTML report, plots, etc.)
│   └── LUMIERE_survival_report_FIXED_internal_EN.html
│
├── notebooks/                    # R Markdown workflow
│   └── LUMIERE_survival_report.Rmd
│
├── scripts/                      # (optional) analysis scripts
│
├── LICENSE
└── README.md

📊 3. Data availability

This repository includes one processed dataset:

data/LUMIERE_TD_FINAL.csv


This file contains a minimal set of radiomics + clinical features required to reproduce the analysis.
It was generated from the full LUMIERE dataset using preprocessing scripts and contains:

start/stop format for time-dependent survival

cleaned clinical variables

selected radiomics features

🔗 Full raw dataset (external)

The full LUMIERE data (radiomics features, imaging data, and complete clinical annotations) is not hosted in this repository due to size and licensing.
Users can download the complete dataset from the original public source:

📌 LUMIERE Dataset: Suter, Yannick (2022). The LUMIERE Dataset: Longitudinal Glioblastoma MRI with Expert RANO Evaluation. figshare. Collection. https://doi.org/10.6084/m9.figshare.c.5904905.v1

📑 4. How to reproduce the analysis
Step 1 — Clone the repository
git clone https://github.com/somayehsarirchi/GBM-LUMIERE-Radiomics-Survival.git
cd GBM-LUMIERE-Radiomics-Survival

Step 2 — Open RStudio and install required packages
install.packages(c(
  "survival", "pec", "timeROC", "riskRegression",
  "ggplot2", "dplyr", "ggpubr", "survminer", 
  "data.table", "pheatmap"
))

Step 3 — Run the R Markdown workflow

Open:

notebooks/LUMIERE_survival_report.Rmd


Then click:

Knit → Knit to HTML

This will generate a full analysis report inside results/.

📈 5. Methods implemented
✔ Time-dependent Cox regression

Using start–stop formatted data and radiomics + clinical predictors.

✔ Kaplan–Meier survival analysis

Overall survival

Survival by RANO response (optional)

Survival by risk groups

✔ Model performance evaluation

Time-dependent C-index

Brier score over time

Integrated Brier score (IBS)

✔ Bootstrap (.632+) internal validation

Provides optimism-corrected performance metrics.

✔ Risk stratification

Cox linear predictor (LP)
→ divided into Low / Medium / High risk groups using ntile().

📄 6. Example output

The final rendered HTML report (including figures, tables, and interpretations) is available here:

📁 results/LUMIERE_survival_report_FIXED_internal_EN.html

🔁 7. Reproducibility notes

The CSV dataset in data/ is an analysis-ready subset and is sufficient to rerun all code.

For full-scale replication (including raw features), download the full dataset via DOI.

Scripts assume standard directory structure and relative paths.

The R Markdown workflow can be used for:

Reproducing published results

Supplementary materials

Benchmarking radiomics survival models

📜 8. License

This project is released under the MIT License.
You are free to reuse the code with proper attribution.

🙌 9. Citation

If you use this repository in academic work, please cite:

Sarirchi S. (2025). GBM-LUMIERE-Radiomics-Survival: 
Time-dependent survival modeling with longitudinal radiomics.
GitHub repository: https://github.com/somayehsarirchi/GBM-LUMIERE-Radiomics-Survival
