library(tidyverse)
library(survey)
library(broom)

# Load cleaned analytic dataset
nhanes <- read_csv("data/cleaned/analytic_dataset_primary_parity_N1806.csv")

# Create MBzP quartiles
nhanes <- nhanes %>%
  mutate(
    MBzP_quartile = ntile(log_MBzP, 4),
    MBzP_quartile = factor(MBzP_quartile, levels = c(1, 2, 3, 4),
                           labels = c("Q1", "Q2", "Q3", "Q4")),
    MBzP_quartile_ordinal = as.numeric(MBzP_quartile)
  )

# Survey design
nhanes_design <- svydesign(
  id = ~SDMVPSU,
  strata = ~SDMVSTRA,
  weights = ~phth_weight_pooled,
  data = nhanes,
  nest = TRUE
)

# Quartile model
model_quartile <- svyglm(
  parity_binary ~ MBzP_quartile +
    RIDAGEYR +
    BMXBMI +
    INDFMPIR +
    factor(DMDEDUC2) +
    factor(RIDRETH1) +
    URXUCR,
  design = nhanes_design,
  family = quasibinomial()
)

# Trend model
model_trend <- svyglm(
  parity_binary ~ MBzP_quartile_ordinal +
    RIDAGEYR +
    BMXBMI +
    INDFMPIR +
    factor(DMDEDUC2) +
    factor(RIDRETH1) +
    URXUCR,
  design = nhanes_design,
  family = quasibinomial()
)

quartile_results <- tidy(model_quartile) %>%
  mutate(
    OR = exp(estimate),
    CI_low = exp(estimate - 1.96 * std.error),
    CI_high = exp(estimate + 1.96 * std.error)
  )

trend_results <- tidy(model_trend) %>%
  mutate(
    OR = exp(estimate),
    CI_low = exp(estimate - 1.96 * std.error),
    CI_high = exp(estimate + 1.96 * std.error)
  )

print(quartile_results)
print(trend_results)

write_csv(quartile_results, "outputs/regression_tables/mbzp_quartile_results.csv")
write_csv(trend_results, "outputs/regression_tables/mbzp_quartile_trend_results.csv")
