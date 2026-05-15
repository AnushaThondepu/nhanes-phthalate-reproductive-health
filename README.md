# NHANES Phthalate Reproductive Health Analysis

## Overview

This project examines associations between urinary phthalate metabolites and reproductive outcomes among U.S. women aged 18–44 years using NHANES 2003–2014 data.

The analysis uses survey-weighted logistic regression models to evaluate relationships between environmental exposure biomarkers and parity-related reproductive outcomes.

---

## Research Objectives

- Evaluate associations between urinary phthalate metabolites and parity
- Assess dose-response trends across exposure quartiles
- Examine cumulative exposure measures
- Conduct sensitivity analyses for model robustness

---

## Dataset

- NHANES 2003–2014
- Nationally representative U.S. survey
- Women aged 18–44 years
- Final analytic sample: N = 1,806

---

## Methods

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
- Most metabolites showed estimates close to the null
- Results should be interpreted cautiously due to cross-sectional design

---

## Repository Structure

data/           cleaned analytic datasets
scripts/        R analysis scripts
figures/        plots and visualizations
outputs/        regression outputs and tables
manuscript/     thesis PDF
docs/           methodology and documentation

---

## Technologies Used

- R
- tidyverse
- survey
- haven
- broom

---

## Author

Anusha Thondepu  
MS Bioinformatics  
University of Missouri–Kansas City
