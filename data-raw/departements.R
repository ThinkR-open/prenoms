library(sf)

departements <- st_read( "data-raw/map/departements-20140306-50m.shp" )

use_data( departements, overwrite = TRUE )
