library(tidyverse)
library(survey)
library(broom)

# Load cleaned analytic dataset
nhanes <- read_csv("data/cleaned/analytic_dataset_primary_parity_N1806.csv")

# Main survey design
nhanes_design <- svydesign(
  id = ~SDMVPSU,
  strata = ~SDMVSTRA,
  weights = ~phth_weight_pooled,
  data = nhanes,
  nest = TRUE
)

# Sensitivity 1: Exclude highest 1% of MBzP
nhanes_trimmed <- nhanes %>%
  filter(log_MBzP < quantile(log_MBzP, 0.99, na.rm = TRUE))

nhanes_design_trimmed <- svydesign(
  id = ~SDMVPSU,
  strata = ~SDMVSTRA,
  weights = ~phth_weight_pooled,
  data = nhanes_trimmed,
  nest = TRUE
)

model_trimmed <- svyglm(
  parity_binary ~ log_MBzP +
    RIDAGEYR +
    BMXBMI +
    INDFMPIR +
    factor(DMDEDUC2) +
    factor(RIDRETH1) +
    URXUCR,
  design = nhanes_design_trimmed,
  family = quasibinomial()
)

# Sensitivity 2: Creatinine-corrected MBzP exposure
nhanes <- nhanes %>%
  mutate(MBzP_creatinine_corrected = URXMZP / URXUCR,
         log_MBzP_creatinine_corrected = log(MBzP_creatinine_corrected))

nhanes_design_cc <- svydesign(
  id = ~SDMVPSU,
  strata = ~SDMVSTRA,
  weights = ~phth_weight_pooled,
  data = nhanes,
  nest = TRUE
)

model_creatinine_corrected <- svyglm(
  parity_binary ~ log_MBzP_creatinine_corrected +
    RIDAGEYR +
    BMXBMI +
    INDFMPIR +
    factor(DMDEDUC2) +
    factor(RIDRETH1),
  design = nhanes_design_cc,
  family = quasibinomial()
)

# Combine sensitivity results
sensitivity_results <- bind_rows(
  tidy(model_trimmed) %>% mutate(model = "Exclude top 1% MBzP"),
  tidy(model_creatinine_corrected) %>% mutate(model = "Creatinine-corrected MBzP")
) %>%
  mutate(
    OR = exp(estimate),
    CI_low = exp(estimate - 1.96 * std.error),
    CI_high = exp(estimate + 1.96 * std.error)
  )

print(sensitivity_results)

write_csv(
  sensitivity_results,
  "outputs/regression_tables/sensitivity_analysis_results.csv"
)
