library("readr")
library("dplyr")
library("stringr")
library("tidyr")

prenoms_france <- read_tsv( file.path( "data-raw", "nat2017.txt" ) ,
    locale = locale(encoding = "iso-8859-1"),
    na = c("XX", "XXXX"),
    # col_types = "icicd",
    progress = FALSE
  ) %>%
  filter( !is.na(annais), preusuel != "_PRENOMS_RARES" ) %>%
  rename( n = nombre, sex = sexe, year = annais, name = preusuel ) %>%
  mutate(
    name = str_to_title(name),
    n = as.integer(n),
    sex = if_else( sex == 1, "M", "F")
  ) %>%
  select( year, sex, name, n ) %>%
  mutate( n = as.integer(n) )


save( prenoms_france, file = "data/prenoms_france.rda", ascii = FALSE, compress = "xz", compression_level = 9)
