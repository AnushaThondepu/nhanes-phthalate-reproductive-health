packages <- c(
  "tidyverse",
  "haven",
  "survey",
  "broom",
  "janitor",
  "ggplot2",
  "readr"
)

install_if_missing <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
}

invisible(lapply(packages, install_if_missing))
