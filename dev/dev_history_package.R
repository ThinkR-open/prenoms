
### Daily Dev ------------------------------------------------------------------

attachment::att_amend_desc(
  extra.suggests = c(
    # Used in README example
    "dplyr",
    "purrr",
    "ggplot2",
    "tidyr"
  )
)

devtools::check()
rcmdcheck::rcmdcheck()

### Setup ----------------------------------------------------------------------

usethis::use_build_ignore("dev/")

## CI
usethis::use_github_action_check_standard(
  save_as = "check-standard.yaml"
)
