library(sf)

departements <- st_read( "data-raw/map/departements-20140306-50m.shp" ) %>%
  select(-nuts3,-wikipedia) %>%
  mutate_at( vars(nom,code_insee), as.character )

devtools::use_data( departements, overwrite = TRUE )
