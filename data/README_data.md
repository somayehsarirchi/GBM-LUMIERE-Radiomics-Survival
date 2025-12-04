# Data Directory

This folder contains **no data files** because the LUMIERE dataset is publicly
available on Figshare and cannot be redistributed directly within this repository.

To reproduce the full analysis, please download the required CSV files from:

**Yannick Suter (2022).  
The LUMIERE Dataset: Longitudinal Glioblastoma MRI with Expert RANO Evaluation.  
Figshare. https://doi.org/10.6084/m9.figshare.c.5904905.v1**

---

## 📥 Required input files

After downloading the dataset from Figshare, place the following CSV files into this directory:

LUMIERE-Demographics_Pathology.csv
LUMIERE-ExpertRating-v202211.csv
LUMIERE-MRinfo.csv
LUMIERE-pyradiomics-deepbratumia-features.csv


These files are used by:

scripts/01_preprocess_to_TD_FINAL.R


to generate the time-dependent survival dataset.

---

## 📄 Derived dataset

The preprocessing script produces:

data/LUMIERE_TD_FINAL.csv


This file is **not included** in the repository and is generated automatically
from the raw LUMIERE CSV files.

---

## ❗ Note

All data files—both raw and derived—are excluded from Git using `.gitignore`
to ensure the repository remains lightweight and compliant with Figshare data licensing.

---

If you encounter any issues preparing the data, please open an issue in the GitHub repository.