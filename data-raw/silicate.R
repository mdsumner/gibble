## silicate
library(silicate)
library(sf)
point <- PATH(st_cast(minimal_mesh, "POINT"))
mpoint <- PATH(st_cast(minimal_mesh, "MULTIPOINT"))
p0 <- PATH0(minimal_mesh)
p1 <- PATH(minimal_mesh)
usethis::use_data(mpoint, point, p0, p1, internal = TRUE)
