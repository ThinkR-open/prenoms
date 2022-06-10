
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

# _CI
usethis::use_github_action_check_standard(
  save_as = "check-standard.yaml"
)

# _coverage
usethis::use_coverage()
usethis::use_github_action("test-coverage")

### Documentation --------------------------------------------------------------

# _News
usethis::use_news_md()

# _Contributing
usethis::use_tidy_contributing()
usethis::use_build_ignore("CONTRIBUTING.md")

# _Code of conduct
usethis::use_code_of_conduct(contact = "florence@thinkr.fr")

# Add comments for CRAN
usethis::use_cran_comments(open = rlang::is_interactive())
