
<!-- README.md is generated from README.Rmd. Please edit that file -->

# prenoms

First names given to babies in metropolitan France between 1900 and
2019.

    devtools::install_github( "ThinkR-open/prenoms" )
    library("prenoms")

For example, names from current [ThinkR](https://thinkr.fr) staff
[Colin](https://github.com/colinfay),
[Diane](https://github.com/DianeBeldame),
[Sébastien](https://github.com/statnmap),
[Cervan](https://github.com/Cervangirard) &
[Vincent](https://github.com/VincentGuyader) through time.

``` r
library("ggplot2")
library("dplyr")
library("tidyr")
library(prenoms)
data(prenoms)
   thinkrs <- prenoms %>%
     filter(
         name == "Diane"   & sex == "F" |
         name == "Sébastien"  & sex == "M" |
         name == "Colin"  & sex == "M" |
         name == "Cervan"  & sex == "M" |
         name == "Margot"  & sex == "F" |
         name == "Vincent" & sex == "M"
     ) %>%
     complete(name = c("Diane","Sébastien","Colin","Cervan","Margot","Vincent"),year=1900:2019,fill = list(n=0,prop=0)) %>% 
     group_by(name, year, sex) %>%
     summarise( n = sum(n) ) %>%
     arrange( year ) %>% 
     mutate(
       sex = case_when(
         is.na(sex) & name == "Cervan" ~ "M",
         is.na(sex) & name == "Colin" ~ "M",
         is.na(sex) & name == "Diane" ~ "F",
         is.na(sex) & name == "Margot" ~ "F",
         is.na(sex) & name == "Sébastien" ~ "M",
         is.na(sex) & name == "Vincent" ~ "M",
         TRUE ~ sex
         
       )
       
     )

ggplot( thinkrs, aes(x = year, y = n, color = name) ) + 
  geom_line() + 
  scale_x_continuous( breaks = seq(1900, 2020, by = 10) )+theme_bw()
```

<img src="man/figures/README-unnamed-chunk-1-1.png" width="100%" />
