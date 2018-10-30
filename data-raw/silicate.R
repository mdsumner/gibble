## silicate
library(silicate)
library(sf)
point <- PATH(st_cast(minimal_mesh, "POINT"))
mpoint <- PATH(st_cast(minimal_mesh, "MULTIPOINT"))
usethis::use_data(mpoint, point, internal = TRUE)
