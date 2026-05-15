# NHANES Phthalate Reproductive Health Analysis

## Overview

This repository contains reproducible R workflows and analytic materials for a master's thesis examining associations between urinary phthalate metabolites and reproductive outcomes among U.S. women using NHANES 2003–2014 data.

The project applies survey-weighted epidemiologic methods to evaluate dose-response relationships between environmental exposure biomarkers and parity-related reproductive outcomes.

---

## Research Objectives

- Evaluate associations between urinary phthalate metabolites and parity
- Assess dose-response trends across exposure quartiles
- Examine cumulative exposure measures
- Conduct sensitivity analyses for robustness assessment

---

## Dataset

| Component | Description |
|---|---|
| Source | NHANES 2003–2014 |
| Population | U.S. women aged 18–44 years |
| Final analytic sample | N = 1,806 |
| Study design | Cross-sectional complex survey |
| Data source | CDC NHANES |

---

## Statistical Methods

- Survey-weighted logistic regression
- NHANES complex survey weighting
- Log-transformed urinary phthalate metabolites
- Quartile dose-response analysis
- Sensitivity analyses
- False discovery rate correction

---

## Key Findings

- MBzP showed a modest positive association with parity
- Quartile analyses suggested dose-response trends
- Most metabolites showed estimates near the null
- Findings should be interpreted cautiously due to cross-sectional design limitations

---

## Repository Structure

```text
data/           cleaned analytic datasets
scripts/        R analysis scripts
figures/        plots and visualizations
outputs/        regression outputs and tables
manuscript/     thesis PDF
docs/           methodology and documentation
requirements/   package installation scripts

Then push:

```bash
git add README.md
git commit -m "Improve README formatting and project overview"
git push origin main
