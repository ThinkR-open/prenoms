
-   [About](#about)
-   [Installation](#installation)
-   [Utilisation](#utilisation)

<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![R-CMD-check](https://github.com/ThinkR-open/prenoms/workflows/R-CMD-check/badge.svg)](https://github.com/ThinkR-open/prenoms/actions)
<!-- badges: end -->

# About

`{prenoms}` (namely “firstnames”) allows you to explore the data on
first names given to children born in metropolitan France between 1900
and 2020.

These data are available at the French level and by department.

Source: These statistics come from the French civil status. They have
been collected by the National Institute of Statistics and Economic
Studies (Insee), that collects, analyses and disseminates information on
the French economy and society. These statistics are available
[here](https://www.insee.fr/fr/statistiques/2540004#documentation).

# Installation

You can install the development version of {prenoms} from GitHub:

    devtools::install_github( "ThinkR-open/prenoms" )
    library("prenoms")

# Utilisation

For example, names from current [ThinkR](https://thinkr.fr) staff
through time: [Colin](https://github.com/colinfay),
[Diane](https://github.com/DianeBeldame),
[Sébastien](https://github.com/statnmap),
[Cervan](https://github.com/Cervangirard),
[Vincent](https://github.com/VincentGuyader),
[Margot](https://github.com/MargotBr)
[Arthur](https://github.com/ArthurData),
[Antoine](https://github.com/ALanguillaume) &
[Florence](https://github.com/FlorenceMounier)

``` r
library("ggplot2")
library("dplyr")
library("tidyr")
library(prenoms)

# In France
load("data/prenoms_france.rda")

   thinkrs <- prenoms_france %>%
     filter(
         name == "Colin"  & sex == "M" |
         name == "Diane"   & sex == "F" |
         name == "Sébastien"  & sex == "M" |
         name == "Cervan"  & sex == "M" |
         name == "Vincent" & sex == "M" |
         name == "Margot"  & sex == "F" |
         name == "Arthur" & sex == "M" |
         name == "Antoine" & sex == "M" |
         name == "Florence"  & sex == "F" 
     ) %>%
     complete(
       name = c("Colin", "Diane", "Sébastien", "Cervan", "Vincent", "Margot", "Arthur", "Antoine", "Florence"),
       year = 1900:2020,
       fill = list(n=0, prop=0)
       ) %>% 
     group_by(name, year, sex) %>%
     summarise(n = sum(n),
               .groups = "drop") %>%
     arrange(year) %>% 
     mutate(
       sex = case_when(
         is.na(sex) & name == "Colin" ~ "M",
         is.na(sex) & name == "Diane" ~ "F",
         is.na(sex) & name == "Sébastien" ~ "M",
         is.na(sex) & name == "Cervan" ~ "M",
         is.na(sex) & name == "Vincent" ~ "M",
         is.na(sex) & name == "Margot" ~ "F",
         is.na(sex) & name == "Arthur" ~ "M",
         is.na(sex) & name == "Antoine" ~ "M",
         is.na(sex) & name == "Florence" ~ "F",
         TRUE ~ sex
       )
     )

   thinkrs %>%
     ggplot() +
     aes(x = year, y = n, color = name) + 
     geom_line() + 
     scale_x_continuous( breaks = seq(1900, 2020, by = 10) ) +
     labs(title = "ThinkR's team names evolution in France") +
     theme_bw()
```

<img src="man/figures/README-unnamed-chunk-1-1.png" width="100%" />

``` r
# In the department number of ThinkR's head office: 93

load("data/prenoms.rda")

   thinkrs <- prenoms %>%
     filter(
         name == "Colin"  & sex == "M" |
         name == "Diane"   & sex == "F" |
         name == "Sébastien"  & sex == "M" |
         name == "Cervan"  & sex == "M" |
         name == "Vincent" & sex == "M" |
         name == "Margot"  & sex == "F" |
         name == "Arthur" & sex == "M" |
         name == "Antoine" & sex == "M" |
         name == "Florence"  & sex == "F"
     ) %>%
     filter(dpt == 93) %>%
     complete(
       name = c("Colin", "Diane", "Sébastien", "Cervan", "Vincent", "Margot", "Arthur", "Antoine", "Florence"),
       year = 1900:2020,
       fill = list(n=0, prop=0)
       ) %>% 
     group_by(name, year, sex) %>%
     summarise(n = sum(n),
               .groups = "drop") %>%
     arrange(year) %>% 
     mutate(
       sex = case_when(
         is.na(sex) & name == "Colin" ~ "M",
         is.na(sex) & name == "Diane" ~ "F",
         is.na(sex) & name == "Sébastien" ~ "M",
         is.na(sex) & name == "Cervan" ~ "M",
         is.na(sex) & name == "Vincent" ~ "M",
         is.na(sex) & name == "Margot" ~ "F",
         is.na(sex) & name == "Arthur" ~ "M",
         is.na(sex) & name == "Antoine" ~ "M",
         is.na(sex) & name == "Florence" ~ "F",
         TRUE ~ sex
       )
     )

   thinkrs %>%
     ggplot() +
     aes(x = year, y = n, color = name) + 
     geom_line() + 
     scale_x_continuous( breaks = seq(1900, 2020, by = 10) ) +
     labs(title = "ThinkR's team names evolution in the 93 department") +
     theme_bw()
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />
