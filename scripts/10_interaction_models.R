library(tidyverse)
library(survey)
library(broom)

# Load cleaned dataset
nhanes <- read_csv("data/cleaned/final_analysis_dataset.csv")

# Create survey design object
nhanes_design <- svydesign(
  id = ~SDMVPSU,
  strata = ~SDMVSTRA,
  weights = ~phth_weight_pooled,
  data = nhanes,
  nest = TRUE
)

# Model 1: MBzP x Age interaction
model_mbzp_age <- svyglm(
  parity_binary ~ log_MBzP * RIDAGEYR +
    BMXBMI +
    INDFMPIR +
    factor(DMDEDUC2) +
    factor(RIDRETH1) +
    URXUCR,
  design = nhanes_design,
  family = quasibinomial()
)

# Model 2: MBzP x BMI interaction
model_mbzp_bmi <- svyglm(
  parity_binary ~ log_MBzP * BMXBMI +
    RIDAGEYR +
    INDFMPIR +
    factor(DMDEDUC2) +
    factor(RIDRETH1) +
    URXUCR,
  design = nhanes_design,
  family = quasibinomial()
)

# Convert model outputs to OR format
age_interaction_results <- tidy(model_mbzp_age) %>%
  mutate(
    model = "MBzP x Age",
    OR = exp(estimate),
    CI_low = exp(estimate - 1.96 * std.error),
    CI_high = exp(estimate + 1.96 * std.error)
  )

bmi_interaction_results <- tidy(model_mbzp_bmi) %>%
  mutate(
    model = "MBzP x BMI",
    OR = exp(estimate),
    CI_low = exp(estimate - 1.96 * std.error),
    CI_high = exp(estimate + 1.96 * std.error)
  )

interaction_results <- bind_rows(
  age_interaction_results,
  bmi_interaction_results
)

# Print results
print(interaction_results)

# Save outputs
write_csv(
  interaction_results,
  "outputs/regression_tables/interaction_model_results.csv"
)

# Save full model summaries
sink("outputs/model_summaries/mbzp_age_interaction_summary.txt")
summary(model_mbzp_age)
sink()

sink("outputs/model_summaries/mbzp_bmi_interaction_summary.txt")
summary(model_mbzp_bmi)
sink()
