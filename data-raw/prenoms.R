library("readr")
library("dplyr")
library("stringr")
library("tidyr")

rewrite_history <- function(data, old_dpt, year_limit, props){
  after <- props$dpt

  avant <- data %>%
    filter(dpt == old_dpt, year < year_limit) %>%
    complete(nesting(year, sex, name), dpt = after ) %>%
    fill(n) %>%
    inner_join(props, by = "dpt") %>%
    mutate(n = prop * n ) %>%
    select(-prop)

  apres <- data %>%
    filter(year >= year_limit, dpt %in% after )

  data %>%
    anti_join(props, by = "dpt") %>%
    bind_rows(avant, apres) %>%
    arrange(year, dpt, sex, name)
}

rewrite_history_oise <- function(data){
  # modifer historique appliqué aux départements 78, 91 et 95

  oise_prop <- data %>%
    filter( between(year, 1968, 1998), dpt %in% c("78", "91", "95") ) %>%
    group_by(dpt) %>%
    summarise( prop = n() / nrow(.) )

  rewrite_history(data, "78", 1968, oise_prop )
}

rewrite_history_seine <- function(data){
  # modifer historique appliqué aux départements 75, 92, 93 et 94

  seine_prop <- data %>%
    filter( year >= 1968, dpt %in% c("75", "92", "93", "94" ) ) %>%
    group_by(dpt) %>%
    summarise( prop = n() / nrow(.) )

  rewrite_history(data, "75", 1968, props = seine_prop )
}

rewrite_history_corse <- function(data){
  # modifer historique appliqué aux départements 2A et 2B
  # Il faut remplacer le département 20 par 2A et 2B (moitié-moitié)

  corse_prop <- tibble("dpt" = c("20", "2A", "2B"), "prop" = c(0, 0.5, 0.5))

  rewrite_history(data, "20", Inf, props = corse_prop) %>%
    filter(n != 0)
}

prenoms <- read_tsv( file.path( "data-raw", "dpt2017.txt" ) ,
    # locale = locale(encoding = "iso-8859-1"),
    na = c("XX", "XXXX"),
    col_types = "icicd",
    progress = TRUE
  ) %>%
  filter( !is.na(annais), !is.na(dpt), preusuel != "_PRENOMS_RARES" ) %>%
  rename( n = nombre, sex = sexe, year = annais, name = preusuel ) %>%
  mutate(
    name = str_to_title(name),
    n = as.integer(n),
    sex = if_else( sex == 1, "M", "F")
  ) %>%
  select( year, sex, name, n, dpt ) %>%
  rewrite_history_oise() %>%
  rewrite_history_seine() %>%
  rewrite_history_corse() %>%
  mutate( n = as.integer(n) )

prop_dpt <- prenoms %>%
  group_by(year, dpt ) %>%
  summarise( total = sum(n) )

prenoms <- left_join( prenoms, prop_dpt, by = c("year", "dpt") ) %>%
  mutate( prop = n / total ) %>%
  select(-total)

save( prenoms, file = "data/prenoms.rda", ascii = FALSE, compress = "xz", compression_level = 9)
