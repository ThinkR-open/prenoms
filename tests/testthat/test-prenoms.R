test_that("prenoms is loaded works", {
  library(prenoms)
  data("prenoms")
  expect_true(exists("prenoms"))
  expect_is(prenoms,"data.frame")
  expect_equal(names(prenoms),c("year", "sex", "name", "n", "dpt", "prop"))
})
test_that("prenoms is loaded works", {
  library(prenoms)
  data("prenoms_france")
  expect_true(exists("prenoms_france"))
  expect_is(prenoms_france,"data.frame")
  expect_equal(names(prenoms_france),c("year", "sex", "name", "n", "prop"))

})
test_that("examples in README work", {
  library(prenoms)
  library(dplyr)
  library(tidyr)
  library(purrr)
  library(ggplot2)

  team_members <- tribble(
    ~name,      ~sex,
    "Colin",     "M",
    "Diane",     "F",
    "Sébastien", "M",
    "Cervan",    "M",
    "Vincent",   "M",
    "Margot",    "F",
    "Estelle",  " F",
    "Arthur",    "M",
    "Antoine",   "M",
    "Florence",  "F",
    "Murielle",  "F"
  )

  get_thinkr_team_name_data <- function(
    prenoms_df,
    team_members_df
  ) {
    prenoms_df %>%
      # Get data corresponding only to team member names
      inner_join(
        team_members,
        by = c("name", "sex")
      ) %>%
      # Add missing combination for name x year
      complete(
        name = team_members$name,
        year = 1900:2020,
        fill = list( n = 0, prop = 0 )
      ) %>%
      group_by(name, year, sex) %>%
      summarise(
        n = sum(n),
        .groups = "drop"
      ) %>%
      arrange(year) %>%
      # If sex is not define (NA) we assumed it was
      # the same as the corresponding team member's
      mutate(
        sex = map2_chr(
          sex,
          name,
          function(
            sex,
            name
          ) {
            ifelse(
              is.na(sex) & name %in% team_members$name,
              team_members$sex[team_members$name == name],
              sex
            )
          }
        )
      )
  }

  data(prenoms_france)

  thinkrs <- get_thinkr_team_name_data(
    prenoms_df = prenoms_france,
    team_members_df = team_members
  )

  ggplot1 <- thinkrs %>%
    ggplot() +
    aes(x = year, y = n, color = name) +
    geom_line() +
    scale_x_continuous( breaks = seq(1900, 2020, by = 10) ) +
    labs(title = "ThinkR's team names evolution in France") +
    theme_bw()

  # tests on `thinkrs`
  expect_s3_class(object = thinkrs, class = "tbl")
  expect_equal(names(thinkrs), c("name", "year", "sex", "n"))
  expect_type(object = thinkrs[["name"]], type = "character")
  expect_type(object = thinkrs[["year"]], type = "double")
  expect_type(object = thinkrs[["sex"]], type = "character")
  expect_type(object = thinkrs[["n"]], type = "integer")

  #tests on `ggplot1`
  expect_s3_class(object = ggplot1, class = "ggplot")


})
