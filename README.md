
-   [About](#about)
-   [Installation](#installation)
-   [Usage](#usage)

<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![R-CMD-check](https://github.com/ThinkR-open/prenoms/workflows/R-CMD-check/badge.svg)](https://github.com/ThinkR-open/prenoms/actions)
<!-- badges: end -->

# About

`{prenoms}` (namely “firstnames”) allows you to explore the data on
first names given to children born in metropolitan France between 1900
and 2020.

These data are available at the French level and by department.

> Source: These statistics come from the French civil status. They have
> been collected by the National Institute of Statistics and Economic
> Studies (Insee), that collects, analyses and disseminates information
> on the French economy and society. These statistics are available
> [here](https://www.insee.fr/fr/statistiques/2540004#documentation).

# Installation

You can install the development version of {prenoms} from GitHub:

``` r
devtools::install_github( "ThinkR-open/prenoms" )
library("prenoms")
```

# Usage

``` r
library(ggplot2)
library(dplyr)
library(tidyr)
library(purrr)
library(prenoms)
```

For example, names from current [ThinkR](https://thinkr.fr) staff
through time:

-   [Colin](https://github.com/colinfay)
-   [Diane](https://github.com/DianeBeldame)
-   [Sébastien](https://github.com/statnmap)
-   [Cervan](https://github.com/Cervangirard)
-   [Vincent](https://github.com/VincentGuyader)
-   [Margot](https://github.com/MargotBr)
-   Estelle
-   [Arthur](https://github.com/ArthurData)
-   [Antoine](https://github.com/ALanguillaume)
-   [Florence](https://github.com/FlorenceMounier)
-   [Murielle](https://github.com/MurielleDelmotte)

Let’s define a dataset holding our names and genders:

``` r
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
```

And then craft a function that will retrieve only the names
corresponding to our own names.

``` r
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
```

### At France country scale

``` r
# Data for the whole France
data(prenoms_france)

thinkrs <- get_thinkr_team_name_data(
  prenoms_df = prenoms_france,
  team_members_df = team_members
)
```

``` r
thinkrs %>%
  ggplot() +
  aes(x = year, y = n, color = name) +
  geom_line() +
  scale_x_continuous( breaks = seq(1900, 2020, by = 10) ) +
  labs(title = "ThinkR's team names evolution in France") +
  theme_bw()
```

<img src="man/figures/README-graph-france-1.png" width="100%" />

### In the “départment” of ThinkR’s headquarters: 93 (Seine-Saint-Denis)

``` r
# Data by "départment"
data(prenoms)

thinkrs_93 <- prenoms %>%   
  filter(dpt == 93) %>%
  get_thinkr_team_name_data(
    team_members
  )
```

``` r
thinkrs_93 %>%
  ggplot() +
  aes(x = year, y = n, color = name) +
  geom_line() +
  scale_x_continuous( breaks = seq(1900, 2020, by = 10) ) +
  labs(title = "ThinkR's team names evolution in the 93 department") +
  theme_bw()
```

<img src="man/figures/README-graph-departement-1.png" width="100%" />
