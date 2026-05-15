library(tidyverse)
library(survey)
library(broom)

# Load cleaned analytic dataset
nhanes <- read_csv("data/cleaned/analytic_dataset_primary_parity_N1806.csv")

# Create survey design object
nhanes_design <- svydesign(
  id = ~SDMVPSU,
  strata = ~SDMVSTRA,
  weights = ~phth_weight_pooled,
  data = nhanes,
  nest = TRUE
)

# Primary MBzP model
model_mbzp <- svyglm(
  parity_binary ~ log_MBzP +
    RIDAGEYR +
    BMXBMI +
    INDFMPIR +
    factor(DMDEDUC2) +
    factor(RIDRETH1) +
    URXUCR,
  design = nhanes_design,
  family = quasibinomial()
)

# Model summary
summary(model_mbzp)

# Tidy odds ratio output
model_results <- tidy(model_mbzp) %>%
  mutate(
    OR = exp(estimate),
    CI_low = exp(estimate - 1.96 * std.error),
    CI_high = exp(estimate + 1.96 * std.error)
  )

print(model_results)

# Save results
write_csv(
  model_results,
  "outputs/regression_tables/primary_model_results.csv"
)
